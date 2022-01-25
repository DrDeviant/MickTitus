export ZSH="$HOME/.local/plugin_managers/ohmyzsh"
ZSH_THEME="candy"

alias vim="lvim"

echo "rht-vmctl start all"

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
alias awesome-logs='vim ~/.local/share/sddm/xorg-session.log'

#Distro info
alias distro='cat /etc/*-release'
alias myip='curl ipv4.icanhazip.com'

# Adding SSH keys to agent the "Ghetto" way
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -S github $HOME/.ssh/github &> /dev/null
ssh-add -S services $HOME/.ssh/external &> /dev/null

# Things in Path
export PATH="$HOME/.config/npm-global:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn-global:$PATH"

source $ZSH/oh-my-zsh.sh


