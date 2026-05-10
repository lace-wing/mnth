use ../base.nu *
use ../kdl.nu *

const TARGET = 'zellij'

def main [theme: string, --new(-n)]: nothing -> string {
  let out_file = get_out_file $theme $TARGET $"($theme).kdl"
  if not $new and (is_to_date $out_file (get_colors_file $theme)) {
    return $out_file
  }
  let colors = get_colors --new=($new) $theme

  let text_groups = [
    'text_unselected'
    'text_selected'
    'ribbon_selected'
    'ribbon_unselected'
    'table_title'
    'table_cell_selected'
    'table_cell_unselected'
    'list_selected'
    'list_unselected'
    'frame_selected'
    'frame_highlight'
    'exit_code_success'
    'exit_code_error'
  ]
  let text_keys = [
    'base'
    'background'
    ...(0..3 | each { $"emphasis_($in)" })
  ]

  let player_group = 'multiplayer_user_colors'
  let player_keys = 1..10 | each { $"player_($in)" }

  kdl_node 'themes' (kdl_block (
    kdl_node $theme (kdl_block (
      # TODO text groups
      kdl_node $player_group (kdl_block (
        $player_keys | zip ($colors.ansi.indexed | where index != 0 and index != 8 | get item | take 10) | each {|p| kdl_node $p.0 ...($p.1 | rgb_hex2ints | kdl_num)} | str join (char nl)
      ))
    ))
  )) | let text

  mkpr $out_file
  $text | save -f $out_file
  return $out_file
}
