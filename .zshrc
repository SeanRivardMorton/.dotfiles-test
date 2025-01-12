# Path to your oh-my-zsh installation.
export ZSH="/home/sean/.oh-my-zsh"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export DENO_INSTALL="/home/sean/.deno"

export GOROOT=/usr/local/go
export GOPATH=$usr/local/go
export PATH=$PATH:/usr/local/go/bin

plugins=(zsh-syntax-highlighting zsh-autosuggestions git)

# Environment Variables
#
export DEFAULT_USER=$USER
export PATH="$PATH:/opt/nvim-linux64/bin"

export OPEN_API_TYPE=""
export OPENAI_API_BASE="https://api.openai.com/v1"

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Sourcing

source $ZSH/oh-my-zsh.sh

export PNPM_HOME="/home/sean/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## Loading in zsh-vi-mode. Using oh-my-zsh bugs out.
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Functions

function shadd () {
  pnpm dlx shadcn@latest add $1
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function sa () {
  npx shadcn-ui@latest add $1
}

function jrnl () {
  # Creates a new markdown file with name as day-month-year_1$.md
  touch $(date +%d-%m-%Y)_$1.md
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # added by pipx (https://github.com/pipxproject/pipx)
# export PATH="/home/sean/.local/bin:$PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# source /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/tokyonight_storm.omp.json)"
# eval "$(oh-my-posh init zsh --config 'https://github.com/dreamsofautonomy/zen-omp/blob/main/zen.toml')"


# eval "$(starship init zsh)"
# alias vi=vim
# alias vim=nvim

# Aliases

alias start-redis='sudo service redis-server start'
alias stop-redis='sudo service redis-server stop'
alias python='python3'

## Config Managers.. oh-my-[zsh|posh|tmux]
alias omp="cd $(brew --prefix oh-my-posh)/themes"
alias omt="cd ~/.config/tmux && nvim ~/.config/tmux/tmux.conf.local"
alias omz="nvim ~/.zshrc"

## Display current directory with fzf preview
alias cdf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias vim='nvim --listen /tmp/nvim-server.pipe'
eval "$(zoxide init zsh --cmd cd)"


# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
#     *)            fzf "$@" ;;
#   esac
# }

# eval "$(fzf --zsh)"

# export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

# source ghf.bash
. "/home/sean/.deno/env"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ls="yazi"

export BAT_THEME=tokyonight_night
