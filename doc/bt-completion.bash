# Copyright © 2018-2019 Vasili Karaev
# 
# This file is part of bt.
#
# bt is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bt.  If not, see <http://www.gnu.org/licenses/>.

__bt_escape_strings_stdin() {
    sed 's/\(.*\)/\"\1\"/g'
}

_bt_commands() {
    commands="add search list remove"

    COMPREPLY=($(compgen -W "$commands" -- "$cur"))
}

_bt_add() {
    local opts="-m -t -d"

    if [[ "$cur" == -* ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "${cur}"))
        return
    fi

    local IFS=$'\n'
    local ls1="ls -1 --quoting-style=shell-escape-always"
    local prev="${COMP_WORDS[COMP_CWORD - 1]}"

    case "$prev" in
        -t)
            COMPREPLY=($(compgen -W "$(eval "$ls1" "$BT_TORR_DIR")" -- "$cur" \
                         | __bt_escape_strings_stdin))
            ;;
        -d)
            COMPREPLY=($(compgen -W "$(eval "$ls1" "$BT_DEST_DIR")" -- "$cur" \
                         | __bt_escape_strings_stdin))
            ;;
        *)
            ;;
    esac
}

_bt_list() {
    local opts="-a -d -e -q -s"

    if [[ "$cur" == -* ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "${cur}"))
    fi
}


_bt() {
    local c=1
    local word
    local cmd

    while [ "$c" -lt "$COMP_CWORD" ]; do
        word="${COMP_WORDS[c]}"
        case "$word" in
            -h|-v)
                ;;
            *)
                cmd="$word"
                break
                ;;
        esac
        c="$((c + 1))"
    done

    cur="${COMP_WORDS[COMP_CWORD]}"

    if [ -z "$cmd" ]; then
        case "$cur" in
            -*) COMPREPLY=() ;;
            *) _bt_commands ;;
        esac
        return
    fi

    case "$cmd" in
        add)    _bt_add  ;;
        search)          ;;
        list)   _bt_list ;;
        remove)          ;;
        *)               ;;
    esac
}

complete -F _bt bt
