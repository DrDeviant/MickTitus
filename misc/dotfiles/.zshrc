# Path to your oh-my-zsh configuration.
export ZSH="$HOME/.local/ohmyzsh"
ZSH_THEME="candy"
# PS1="\[\e[1;38;2;255;105;97m\][\[\e[m\]\[\e[1;38;2;255;179;71m\]\u\[\e[m\]\[\e[1;38;2;253;253;150m\]@\[\e[m\]\[\e[1;38;2;119;221;119m\]\h\[\e[m\] \[\e[1;38;2;174;198;207m\]\W\[\e[m\]\[\e[1;38;2;134;134;175m\]]\[\e[1m\]\[\e[1;38;2;203;153;201m\]\\$\[\e[m\] "

alias v="lvim"
# echo "rht-vmctl start all"

#Pacman and Yay
alias pacman="yay"
alias upgrade="yay -Syu"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

#Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

#Get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

#Git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias newtag='git tag -a'

#Get error messages
alias jctl="journalctl -p 3 -xb"

#Distro info
alias distro='cat /etc/*-release'
alias myip='curl ipv4.icanhazip.com'

# Adding SSH keys to agent the "Ghetto" way
# eval "$(ssh-agent -s)" &> /dev/null
# ssh-add -S github $HOME/.ssh/github &> /dev/null
# ssh-add -S services $HOME/.ssh/external &> /dev/null

# Things in Path
NPM_CONFIG_PREFIX=~/.npm-global
export PATH="$HOME/.config/npm-global:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn-global:$PATH"
source $ZSH/oh-my-zsh.sh
