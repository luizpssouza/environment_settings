. ~/tmuxcompletion

# binding keys
bind '"\C-H":backward-kill-word' #ctrl backspace
bind 'set completion-ignore-case on'

# poetry
export PATH="${HOME}/.local/bin:$PATH"

alias upd='sudo apt update'
alias upg='sudo apt upgrade -y'
alias updg='upd && upg'

export PATH="$PATH:/opt/mssql-tools/bin"

export PS1='\D{%H.%M.%S}) \[\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1) $NODE_VERSION_PS1\n\[\033[0;32m\] └─\[\033[0;32m\] \$\[\033[0;32m\] ▶\[\033[0m\] '

alias llg='ll | grep'
alias l='ls -lhaF'
alias ll='ls -lhaF'

#tmux
alias tmux='tmux -2'

# ~/.bash_profile
# ----------------------
# Git Aliases
# ----------------------
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gaaacm='git add --all && git commit -m '
alias gau='git add --update'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch --delete '
alias gbdall='git branch --merged| egrep -v "(^\*|master|main|develop|release)" | xargs git branch -d'
alias gbm='git branch -m'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gpush='git push'
alias gpushb='git push -u origin HEAD'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

alias mycm='cat ~/.bash_profile | grep '
alias mtask='nvim ~/Documents/tasks.txt'

alias activate='source venv/bin/activate'

# kubernetes
alias k='kubectl'
complete -F __start_kubectl k
alias kubectl-get-current-namespace='kubectl config view --minify --output "jsonpath={..namespace}"; echo;'
alias k-get-current-namespace='kubectl config view --minify --output "jsonpath={..namespace}"; echo;'

alias kcf='k create -f '
alias kcn='echo "Type namespace: "; read namespace; k config set-context --current --namespace=$namespace'
alias kaf='k apply -f '

alias kdp='k delete pod '
alias kd='k delete '

alias kgp='k get pod -o wide'
alias kgd='k get deploy -o wide'
alias kgs='k get service -o wide'
alias kgi='k get ingress -o wide'
alias kgn='k get nodes -o wide'
alias kgnl='k get nodes -o wide --show-labels'

alias ktn='k top node'
alias ktp='k top pod'

alias kpf='k port-forward '
alias kex='echo "Pod name: "; read podname; k exec -it $podname /bin/bash'

# docker-compose
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcu='docker-compose up -d'
alias dcbu='docker-compose build && docker-compose up -d'
alias dcua='docker-compose up'
alias dcd='docker-compose down'

# wifi utilities
alias wifisignal='watch -n1 iwconfig'

# vim
alias vim='nvim'
alias evi='vim ~/.vimrc'

# edit bash profile
alias ebp='vim ~/.bash_profile && . ~/.bash_profile'

# fzf
alias se='fzf'

# poetry
export PATH="$HOME/.poetry/bin:$PATH"
alias po="poetry"
alias pos="python_path_default; poetry shell;"

# yarn
alias yarntestall="yarn lint && yarn test && yarn build"

# python
python_path_default() {
    export PYTHONPATH=$(pwd)
    echo $PYTHONPATH
}

get_python_path_default() {
    echo $PYTHONPATH
}


#nvm
nvm_start() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    _node_version
}

_node_version()
{
  export NODE_VERSION_PS1="(node:$(node -v))"
}
_node_version

# network settings

# disable ipv6
ipv6_disable() {
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
}

alias clip="xclip -selection c"

#network
alias ip4='dig @resolver4.opendns.com myip.opendns.com +short -4'
alias ip6='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -6'
alias cip4='ip4 | clip'
