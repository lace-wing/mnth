use base.nu *
use std/assert

# Make themes.
#
# Use the completion menu to see the subcommands.
@category conversions
@search-terms theme theming colors colours coloring colouring
export def main [] {
  help mnth
}

# Make a theme.
@example 'Making the Hanekawa theme for Ghostty.' 'mnth make hanekawa ghostty'
@example 'Making the Hanekawa theme for Ghostty, then copying the file to the theme folder.' 'mnth make hanekawa ghostty | cp $in.0.path $env.XDG_CONFIG_HOME/ghostty/themes/'
@example 'Making the Hanekawa theme for all targets, then opening the file for Ghostty.' 'mnth make hanekawa | where target == ghostty | ^open $in.0.path'
export def make [
  theme: string@list_themes, # Theme name
  ...targets: string@list_targets # Target names, leave empty for all targets
  --new(-n) # If to ignore cache and run everything
]: nothing -> table<target: string, path: string> {
  assert ($theme in (list_themes)) $"Unknown theme: ($theme)"
  let all_targets = list_targets
  let targets = if ($targets | is-empty) { $all_targets } else {
    $targets | each { assert ($in in $all_targets) $"Unknown target: ($in)"; $in }
  }

  $targets | each {|t| nu ($TARGET_DIR | path join $"($t).nu") --new=($new) $theme | {target: $t, path: $in} }
}

export def clean []: nothing -> nothing {
  rm -rf $CACHE_DIR
  rm -rf $OUTPUT_DIR
}

def list_themes []: nothing -> list<string> {
  ls $THEME_DIR --short-names | where type == dir | get name
}

def list_targets [spans?: list<string>]: nothing -> list<string> {
  ls $TARGET_DIR --short-names | where type == file | get name | each {$in | split row '.' | drop 1 | str join '.' } | where { ($spans | is-empty) or ($in not-in $spans) }
}

