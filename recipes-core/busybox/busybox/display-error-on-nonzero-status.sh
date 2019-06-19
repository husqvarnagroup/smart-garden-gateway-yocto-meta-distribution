# shellcheck disable=SC2148,SC2154
PS1="\$(ret=\$? && [ \"\$ret\" -ne 0 ] && printf 'ERROR: %d | ' \$ret)$PS1"
