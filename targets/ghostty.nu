use ../base.nu *

const TARGET = 'ghostty'

def main [theme: string]: nothing -> string {
  let out_file = get_out_file $theme $TARGET ($theme | str capitalize)
  if (is_to_date $out_file (get_colors_file $theme)) {
    return $out_file
  }
  let colors = get_colors $theme
  let layers = {
    background: $colors.black
    foreground: $colors.white
    "cursor-color": $colors.grey
    "cursor-text": $colors.black
    "selection-background": $colors.grey
    "selection-foreground": $colors.black
  } | items {|k, v| $"($k) = ($v)"}
  let palette = $colors.ansi.indexed | each {|r| $"palette = ($r.index)=($r.item)"}
  let text = $palette ++ $layers
  mkpr $out_file
  $text | save -f $out_file
  return $out_file
}
