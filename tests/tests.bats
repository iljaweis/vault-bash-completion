#!/usr/bin/env bats

source vault-bash-completion.sh
load get_completions

export VAULT_ADDR=http://127.0.0.1:8200

fail() {
  echo "$@" > /dev/stderr
  return 1
}

@test "'vault ' => commands" {
  run get_completions 'vault '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'audit-disable audit-enable' ]] || fail "output was: \"$output\""
}

@test "'vault c' => commands" {
  run get_completions 'vault c'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'capabilities' ]] || fail "output was: \"$output\""
}

@test "'vault p' => commands" {
  run get_completions 'vault p'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'path-help policies policy-delete policy-write' ]] || fail "output was: \"$output\""
}

@test "'vault r' => commands" {
  run get_completions 'vault r'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'read rekey remount renew revoke rotate' ]] || fail "output was: \"$output\""
}

@test "'vault read' => cubbyhole/ secret/ sys/" {
  run get_completions 'vault read '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'cubbyhole/ secret/ sys/' ]] || fail "output was: \"$output\""
}

@test "'vault read c' => cubbyhole/" {
  run get_completions 'vault read c'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'cubbyhole/' ]] || fail "output was: \"$output\""
}

@test "'vault read s' => secret/ sys/" {
  run get_completions 'vault read s'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'secret/ sys/' ]] || fail "output was: \"$output\""
}

@test "'vault list' => cubbyhole/ secret/ sys/" {
  run get_completions 'vault list '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'cubbyhole/ secret/ sys/' ]] || fail "output was: \"$output\""
}

@test "'vault list c' => cubbyhole/" {
  run get_completions 'vault list c'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'cubbyhole/' ]] || fail "output was: \"$output\""
}

@test "'vault list s' => secret/ sys/" {
  run get_completions 'vault list s'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'secret/ sys/' ]] || fail "output was: \"$output\""
}

@test "'vault list cubbyhole/' => cubbyhole/test" {
  vault write cubbyhole/test hello=world
  run get_completions 'vault list cubbyhole/'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'cubbyhole/test' ]] || fail "output was: \"$output\""
}

@test "'vault policies ' => default root" {
  run get_completions 'vault policies '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default root' ]] || fail "output was: \"$output\""
}

@test "'vault policies d' => default" {
  run get_completions 'vault policies d'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default' ]] || fail "output was: \"$output\""
}

@test "'vault policy-delete ' => default root" {
  run get_completions 'vault policy-delete '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default root' ]] || fail "output was: \"$output\""
}

@test "'vault policy-delete d' => default" {
  run get_completions 'vault policy-delete d'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default' ]] || fail "output was: \"$output\""
}

@test "'vault policy-write ' => default root" {
  run get_completions 'vault policy-write '
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default root' ]] || fail "output was: \"$output\""
}

@test "'vault policy-write d' => default" {
  run get_completions 'vault policy-write d'
  [[ "$status" == 0 ]]
  output=$(echo "$output" | paste -s -d ' ' -)
  [[ "$output" =~ 'default' ]] || fail "output was: \"$output\""
}
