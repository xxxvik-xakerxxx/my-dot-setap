HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob nomatch notify correctall promptsubst interactivecomments
unsetopt appendhistory beep
autoload -U colors compinit
colors 
compinit

[[ -a $(whence -p pacman-color) ]] && compdef _pacman pacman-color=pacman

eval $(dircolors ~/.dircolors)
autoload -U pick-web-browser

alias -s {go,txt,cfg,c,cpp,rb,asm,nim,conf,d}=subl3
alias -s {avi,mpeg,mpg,mov,m2v}=mpv
alias -s {html,htm}=chromium
alias -s {png,jpg,gif,svg}=feh

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lah --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -ah --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias cp='cp -i'
alias df='df -h'
alias free='free -hm'
alias grep='grep --colour=always'
alias uptime='uptime -p'
alias cal='~/./dotfiles/cal.py'
alias rm='rm -rf'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias feh='feh -q -g 1880x980 --scale-down --auto-zoom'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin'
alias gpl='git pull origin'
alias gd='git diff'
alias gr='git rm'
alias gl='git lg'
alias gitlog='git log --graph --pretty=oneline --abbrev-commit --all --decorate'


alias S='sudo pacman -S'
alias Sc='echo "\n" | sudo pacman -Sc'
alias Ss='sudo pacman -Ss'
alias Syu='sudo pacman -Syu'
alias Syua='yaourt -Syua'
alias Q='sudo pacman -Q'
alias R='sudo pacman -R'
alias Rsc='sudo pacman -Rsc'
alias aS='yaourt -S'
alias aSs='yaourt -Ss'
alias pgp='gpg --recv-key'

alias dotfiles='~/dotfiles/'
alias pycode='~/Документы/Py/'
alias ccode='~/Документы/C-C++/'
alias acode='~/Документы/ANDROID/'
alias wcode='~/Документы/WEB/'
alias gitrepo='~/Документы/GIT/'
alias mac='echo 24:FD:52:C1:73:A7'

alias edit='vim'
alias ping='mtr'
alias g='googler'
alias wiki='wiki-search' # arch-wiki-lite
alias calc='python -c "print(eval(input()))"'
alias hdmi='xrandr --output VGA1 --auto --output HDMI1 --auto'
alias nvidia='vblank_mode=0 optirun -b primus'
alias hs='/usr/share/playonlinux/playonlinux --run "Hearthstone"'
alias poe='nvidia /usr/share/playonlinux/playonlinux --run "Path of Exile"'
alias wow='nvidia wine ~/Downloads/WoW/wow.exe'

bindkey '\e[3~' delete-char  # del
bindkey '5D' backward-word  # ctrl+left
bindkey '5C' forward-word   # ctrl+right

# extract <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

man() {
  env \
    LESS_TERMCAP_md=$'\e[1;36m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;40;92m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
      man "$@"
}

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

local gitprompt='$(~/dotfiles/gitprompt.py)'
PATH=$PATH:~/.cabal/bin
export EDITOR="vim"
export PROMPT="%{$fg_bold[blue]%}% %~${gitprompt} %{$fg[white]%}% $ %{$reset_color%}%u"
byobu; clear;
