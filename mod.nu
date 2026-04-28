use base.nu *


export def main [job: string@name_jobs, theme?: string@name_themes, ...targets: string@name_targets] {
  let targets = if ($targets | is-empty) { name_targets } else { $targets }
  match $job {
    'clean' => { clean }
    'make' => {
      if ($theme | is-empty) { error make "No theme to make!" }
      $targets | each {|t| nu ($TARGET_DIR | path join $"($t).nu") $theme }
    }
  }
}


def clean []: nothing -> nothing {
  rm -rf $CACHE_DIR
  rm -rf $OUTPUT_DIR
}


def name_jobs []: nothing -> list<string> { [make, clean] }


def name_themes []: nothing -> list<string> {
  ls $THEME_DIR --short-names | where type == dir | get name
}


def name_targets []: nothing -> list<string> {
  ls $TARGET_DIR --short-names | where type == file | get name | each {$in | split row '.' | drop 1 | str join '.' }
}

