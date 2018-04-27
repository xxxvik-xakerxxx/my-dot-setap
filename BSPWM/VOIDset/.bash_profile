# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

if [[ $- == *i* ]]; then
    export SHELL=zsh
    exec zsh -l
fi