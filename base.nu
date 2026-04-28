export const ROOT_DIR = path self | path dirname

export const TARGET_DIR = $ROOT_DIR | path join 'targets'

export const THEME_DIR = $ROOT_DIR | path join 'themes'

export const OUTPUT_DIR = $ROOT_DIR | path join 'out'

export const CACHE_DIR = $ROOT_DIR | path join 'cache'

export def "rgb_hex2ints" []: string -> list<int> {
  $in | str replace '#' '' | split chars | chunks 2 | each { str join | decode hex | into int }
}

export def mkpr [file: path]: nothing -> nothing { mkdir ($file | path dirname) }

export def is_to_date [test: path, control: path]: nothing -> bool { ($test | path exists) and (ls $test | get modified.0) >= (ls $control | get modified.0) }

export def get_colors_file [theme: string]: nothing -> string {
  [$THEME_DIR, $theme, 'colors.toml'] | path join
}

export def get_out_file [theme: string, target: string, file: string]: nothing -> string {
  [$OUTPUT_DIR, $theme, $target, $file] | path join
}

export def get_colors_cache [theme: string]: nothing -> string {
  [
    $CACHE_DIR
    $"colors.($theme).nuon"
  ] | path join
}

export def get_colors [theme: string]: nothing -> record {
  let colors_file = get_colors_file $theme
  let colors_cache = get_colors_cache $theme
  if (is_to_date $colors_cache $colors_file) {
    return (%open $colors_cache)
  }
  let colors = (%open $colors_file)
  let ansi_ordering = [
    black
    red
    green
    yellow
    blue
    magenta
    cyan
    white
  ] | enumerate
  let bright_offset = $ansi_ordering | length
  let ansi_standard = $ansi_ordering | update item {|r| $colors.ansi.standard | get $r.item}
  let ansi_bright = $ansi_ordering | update index {|r| $r.index + $bright_offset} | update item {|r| $colors.ansi.bright | get $r.item}
  let result = $colors | update ansi ($colors.ansi | insert indexed ($ansi_standard ++ $ansi_bright))
  mkpr $colors_cache
  $result | to nuon --raw | save -f $colors_cache
  return $result
}
