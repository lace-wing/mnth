use ../base.nu *

const TARGET = 'ghostty'

def main [theme: string, --new(-n)]: nothing -> string {
  let out_file = get_out_file $theme $TARGET ($theme | str capitalize)
  if not $new and (is_to_date $out_file (get_colors_file $theme)) {
    return $out_file
  }
  let colors = get_colors --new=($new) $theme

  let layers = {
    background: $colors.dark
    foreground: $colors.soft
    "cursor-color": $colors.white
    "cursor-text": $colors.black
    "selection-background": $colors.somber
    "selection-foreground": $colors.light
  } | items {|k, v| $"($k) = ($v)"}
  let palette = $colors.ansi.indexed | each {|r| $"palette = ($r.index)=($r.item)"}
  let text = $palette ++ $layers
  mkpr $out_file
  $text | save -f $out_file
  return $out_file
}
