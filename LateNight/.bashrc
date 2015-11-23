# LateNight
# Version 1.0
# Theme for Git-Bash
# Requires: xterm-256color terminal type

export PATH="$PATH:/c/Python27:./node_modules/.bin"

alias color_ls='for i in {000..255}; do echo -e "$i: \\033[38;5;${i}m Colored text\\033[0m"; done'

FG(){
    colorCode=$1
    echo "\\[\\033[38;5;${colorCode}m\\]"
}
BG(){
    colorCode=$1
    echo "\\[\\033[38;5;${colorCode}m\\]"
}
reset_color(){
    echo "\\[\\033[0m\\]"
}

set_prompt() {
    prevExitCode=$?
    userInfo="$(FG 135)[$(FG 124)\u@$(FG 160)\h$(FG 135)]"
    currDir="$(FG 105)\w"

    arrowChar='>'
    if [[ $prevExitCode == 0 ]]; then
        coloredArrow="$(FG 129)${arrowChar}$(FG 135)${arrowChar}$(FG 147)${arrowChar}"
    else
        coloredArrow="$(FG 129)${arrowChar}$(FG 124)${arrowChar}$(FG 160)${arrowChar}"
    fi

    gitCurrBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ "$gitCurrBranch" != "" ]]; then
        if $(git status | tail -n1 | grep -q "working directory clean"); then
            gitInfo="$(FG 165)✔ ${gitCurrBranch}"
        else
            gitInfo="$(FG 196)✘ ${gitCurrBranch}"
        fi
    else
        gitInfo=""
    fi

    infoLine="${userInfo} ${currDir} ${gitInfo}"
    promptLine="${coloredArrow}"
    PS1="$infoLine\n$promptLine \[\e[0m\]"
}
PROMPT_COMMAND='set_prompt'
