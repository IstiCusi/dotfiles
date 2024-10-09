source /home/phonon/.phonon-docker/tensor_run.sh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ext_agnoster"
plugins=(git zsh-autosuggestions rust)
source $ZSH/oh-my-zsh.sh
#--------------------------------------------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------------------------------------

fzf_ripgrep_content_search() {
  echo -n "Enter search term: "
  read search_term

  if [[ -n "$search_term" ]]; then
    local file
    file=$(rg --no-heading --line-number --color=always "$search_term" . |
      fzf --ansi --preview 'batcat --style=numbers --color=always --line-range=:500 {1}' \
        --delimiter=: --preview-window=up:60%:wrap | cut -d':' -f1)

    if [[ -n "$file" ]]; then
      nvim "$file" # Öffne die Datei direkt in nvim
    fi
  else
    echo "No search term entered."
  fi
}

# Binde die Funktion direkt an den Shortcut ohne ZLE-Widget
bindkey -s '^f' 'fzf_ripgrep_content_search\n'

# ------------------------------------------------------------------

alias v="NVIM_APPNAME=expnvim nvim"
alias vv="NVIM_APPNAME=nvim nvim"

function nvims() {
  items=("default" "expnvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
# bindkey -s ^a "nvims\n"

export MANPAGER='nvim +Man! +"set nocul" +"set noshowcmd" +"set noruler" +"set noshowmode" +"set laststatus=0" +"set showtabline=0" +"set nonumber"'
export EDITOR=v

# ------------------------------------------------------------------

alias c='clear' # for usage with tmux that cannot be use ctrl-l

alias em='emacsd std'
alias emnw='em -- -nw'
alias rr=ranger
alias b=batcat
alias ccat='pygmentize -g'
alias spi='kitty icat'
alias spd='/home/phonon/Development/gitRepositories/termpdf.py/termpdf.py'
alias diskusage='baobab'

alias 2v='cd ~/.config/expnvim/lua/'
alias 2d='cd ~/Development/'
alias 2cs='cd ~/Development/codesnips'
alias 2w='cd ~/Development/workspaces'
alias 2wc='cd ~/Development/workspaces/workspace_VS_C++'
alias 2a='cd ~/Development/codesnips/amiga'
alias 2ah='cd ~/Development/codesnips/amiga/include/'
alias 2c='cd ~/Development/codesnips/c64/Link_to_C64-Dev/'

alias p='evince ~/Desktop/popos.pdf &'

alias lle='exa -l --icons'
alias lse='exa --icons'
alias ls='exa --icons'
alias adir='ll -I "*.uaem" -I "*.info"'

alias droid='/usr/bin/java -jar /home/phonon/Development/tools/c64-droi/droid-64-java-v0.50.jar'
alias xcbasic='/home/phonon/Development/tools/c64-xcbasic/xcbasic64'
alias cc1541=~/Development/tools/c64-droi/cc1541_lin_glibc_x86

alias GDB='gdb -x .gdbinit_local'
alias debug=gf2

# ------------------------------------------------------------------

export PATH=$PATH:/home/phonon/.local/bin
export PATH=$PATH:/home/phonon/Development/tools/bin
export VBCC="/home/phonon/Development/lang/amiga_sdk/vbcc"
export PATH="$VBCC/bin:$PATH"
export NDK_INC="/home/phonon/Development/lang/amiga_sdk/NDK_3.9/Include/include_h"
export NDK_ASMINC="/home/phonon/Development/lang/amiga_sdk/NDK_3.9/Include/include_i"
export PATH="$PATH:/home/phonon/Development/tools/git-filter-repo"
export PATH="$PATH:/home/phonon/Development/tools/C64-KickAssembler"
export PATH="$PATH:/home/phonon/Development/tools/godot"
export PATH="$PATH:/home/phonon/Development/lang/node-v14.18.1-linux-x64/bin/"
export PATH="$PATH:/home/phonon/Development/lang/C64-turboasm"
export PATH="$PATH:/home/phonon/Development/lang/c64-dasm/"
export PATH="$PATH:/home/phonon/Development/lang/C64-tass"
export PATH="$PATH:/home/phonon/Development/tools/c64-exomizer"
export PATH="$PATH:/home/phonon/Development/tools/c64-goattracker/linux"
export PATH="$PATH:/home/phonon/Development/lang/c64-acme/acme091/src"
export PATH="$PATH:/home/phonon/Development/tools/x48-0.4.3/"
export PATH="$PATH:/home/phonon/Development/lang/c64-cc65/bin/"
export PATH="$PATH:/home/phonon/Development/tools/agr-0.5.1/"
export PATH="$PATH:/home/phonon/Development/gitRepositories/fltk-1.3.4-2/"
export PATH="$PATH:/home/phonon/Development/tools/c64-b2"
export PATH="$PATH:/home/phonon/Development/lang/porth"
export PATH="$PATH:/home/phonon/Development/lang/Krakatau/target/release/"
export PATH="$PATH:/home/phonon/Development/tools/edb-debugger/bin/"
export PATH="$PATH:/home/phonon/.emacs.d/bin"
export PATH="$PATH:/home/phonon/Development/tools/emacs-distribution"
export PATH="$PATH:/home/phonon/.config/doom/bin/"
export PATH="$PATH:/opt/openpdfsign/bin/"
export PATH="$PATH:/home/phonon/Development/lang/go/bin/"
export GOPATH="/home/phonon/Development/lang/go/gorepo"

# ------------------------------------------------------------------

export EMSDK_QUIET=1
source ~/Development/tools/emsdk/emsdk_env.sh

# ------------------------------------------------------------------

export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# ------------------------------------------------------------------

export WM_PROJECT_USER_DIR=~/Development/codesnips/openfoam-examples/

# ------------------------------------------------------------------

export FS_UAE_BASE_DIR=/home/phonon/Development/workspaces/fsuae

# ------------------------------------------------------------------

export PATH="$PATH:/home/phonon/Development/tools/rendering/blender-3-3.10-FS/"

# ------------------------------------------------------------------

export IDF_PATH=/home/phonon/Development/workspaces/workspace_arduino/ESP8266_RTOS_SDK
alias espinit='source $IDF_PATH/export.sh'

# ------------------------------------------------------------------

export OPENAI_API_KEY=""

# ------------------------------------------------------------------

export MODULAR_HOME="/home/phonon/.modular"

# ------------------------------------------------------------------

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export Python="/home/phonon/.pyenv/shims/python3" # Octave
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source $HOME/.cargo/env

# ------------------------------------------------------------------

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# ------------------------------------------------------------------

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"