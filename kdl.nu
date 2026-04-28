const TAB = '  '

export def kdl_null [] {
  '#null'
}

export def kdl_bool [a?: bool] {
  $in | let t | $a | default $t | let a
  if $a { '#true' } else { '#false' }
}

export def kdl_num [a?: float] {
  $in | let t | $a | default $t | let a
  match $a {
    inf => '#inf'
    -inf => '#-inf'
    nan => '#nan'
    _ => { $a | into string }
  }
}

export def kdl_string [a?: string] {
  $in | let t | $a | default $t | let a
  $a | to json
}

export def kdl_key [a?: string] {
  $in | let t | $a | default $t | let a
  $a | str trim | str replace --all ' ' '_'
}

export def kdl_prop [k: string, v?: string] {
  $in | let t | $v | default $t | let v
  $"($k)=($v)"
}

export def kdl_block [a?: string] {
  $in | let t | $a | default $t | let a
  $a | split row (char nl) | each { $TAB + $in } | str join (char nl) | $"{(char nl)($in)(char nl)}"
}

export def kdl_node [k?: string, ...as: string] {
  $in | let t | $k | default $t | let k
  $"($k) ($as | str join ' ')"
}

