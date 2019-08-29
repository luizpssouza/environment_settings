
export PATH="$PATH:/opt/mssql-tools/bin"

export PS1='\[\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0;32m\] \$\[\033[0;32m\] ▶\[\033[0m\] '

alias llg='ll | grep'

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
alias gc='git commit'
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
