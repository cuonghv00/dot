# ------------------------------ common -----------------------------
alias ll="ls -l"
alias ls="eza --icons -l -T -L=1"
alias cat="bat"
alias ip='ip -c'
alias free='free -h'
alias tree='tree -a'
alias df='df -h'
alias chmox='chmod +x'
alias diff='diff --color'
alias view='vi -R' # which is usually linked to vim
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias more="less"
alias ssh="TERM=xterm-256color ssh"

command -v vim >/dev/null && alias vi=vim

# ssh tunnel
# alias <alias_name>="ssh -fnL <local_listen_port>:<localhost_or_remoteIP>:{remote_listen_port} -o ServerAliveInterval=30 <jump_proxy> -N"

# ------------------------------ docker -----------------------------
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexec='docker exec -it'
alias dlogs='docker logs'
alias dstart='docker start'
alias dstop='docker stop'
alias dbash='docker exec -it $(docker ps -q | head -n 1) bash'
alias dprune='docker system prune -af'

# ------------------------------ tmux -----------------------------
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias tr='tmux source-file ~/.tmux.conf'

# ------------------------------ kubectl -----------------------------
alias k='kubectl'
alias kaf='kubectl apply -f'
alias keti='kubectl exec -t -i'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kcuc='kubectl config use-context'
alias kcgc='kubectl config get-contexts'
alias kpf='kubectl port-forward'
alias kcp='kubectl cp'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# Pod management.
alias kgp='kubectl get pods'
alias kgpl='kgp -l'
alias kgpn='kgp -n'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'
alias kgpall='kubectl get pods --all-namespaces -o wide'

# Service management.
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context --current --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kgss --watch'
alias kgsswide='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'

# Node Management
alias kgno='kubectl get nodes'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

# Service account management.
alias kdsa="kubectl describe sa"
alias kdelsa="kubectl delete sa"

# DaemonSet management.
alias kgds='kubectl get daemonset'
alias kgdsa='kubectl get daemonset --all-namespaces'
alias kgdsw='kgds --watch'
alias keds='kubectl edit daemonset'
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'

# CronJob management.
alias kgcj='kubectl get cronjob'
alias kecj='kubectl edit cronjob'
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'

# Job management.
alias kgj='kubectl get job'
alias kej='kubectl edit job'
alias kdj='kubectl describe job'
alias kdelj='kubectl delete job'

# ------------------------------ git -----------------------------
alias g='git'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gcmsg='git commit --message'
alias gl='git pull'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpsup='git push --set-upstream origin $(git_current_branch)'