# ---------------------------------------------------------------------------
# vault-bash-completion
#
# This adds bash completions for [HashiCorp Vault](https://www.vaultproject.io/)
#
# see https://github.com/iljaweis/vault-bash-completion
# ---------------------------------------------------------------------------

function _vault_mounts() {
  (
    set -euo pipefail
    if ! vault mounts 2> /dev/null | awk 'NR > 1 {print $1}'; then
      echo "secret"
    fi
  )
}

function _vault() {
  local VAULT_COMMANDS='delete path-help read renew revoke server status write audit-disable audit-enable audit-list auth auth-disable auth-enable capabilities generate-root init key-status list mount mount-tune mounts policies policy-delete policy-write rekey remount rotate seal ssh step-down token-create token-lookup token-renew token-revoke unmount unseal version'

  local cur=${COMP_WORDS[COMP_CWORD]}
  local line=${COMP_LINE}

  if [ "$(echo $line | wc -w)" -le 2 ]; then
    if [[ "$line" =~ ^vault\ (read|write|delete|list)\ $ ]]; then
      COMPREPLY=($(compgen -W "$(_vault_mounts)" -- ''))
    else
      COMPREPLY=($(compgen -W "$VAULT_COMMANDS" -- $cur))
    fi
  elif [[ "$line" =~ ^vault\ (read|write|delete|list)\ (.*)$ ]]; then
    path=${BASH_REMATCH[2]}
    if [[ "$path" =~ ^([^ ]+)/([^ /]*)$ ]]; then
      list=$(vault list ${BASH_REMATCH[1]} | tail -n +2)
      COMPREPLY=($(compgen -W "$list" -P "${BASH_REMATCH[1]}/" -- ${BASH_REMATCH[2]}))
    else
      COMPREPLY=($(compgen -W "$(_vault_mounts)" -- $path))
    fi
  fi
}

complete -o default -o nospace -F _vault vault
