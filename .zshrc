# Add commonly used folders to $PATH
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Specify default editor: vim, code, ...
export EDITOR=code

# ---- OH MY ZSH ---------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages colorize pip python brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# TODO: move your stuff to 2_Areas/RC_FILES_or_something_like_this and source
#       it from here

# ---- KEY folders -------------------------------------------------------


alias home="cd $HOME; pwd"
alias Home=home

export DOWNLOADS="$HOME/Downloads"
alias downloads="cd $DOWNLOADS; pwd"
alias Downloads=downloads

export DESKTOP="$HOME/Desktop"
alias desktop="cd $DESKTOP; pwd"
alias Desktop=desktop

export DOCUMENTS="$HOME/Documents"
alias documents="cd $DOCUMENTS; pwd"
alias Documents=documents

# ---- PARA folders ------------------------------------------------------

export PROJECTS="$DOCUMENTS/1_Projects"
alias projects="cd $PROJECTS; pwd"
alias Projects=projects

export AREAS="$DOCUMENTS/2_Areas"
alias areas="cd $AREAS; pwd"
alias Areas=areas

export RESOURCES="$DOCUMENTS/3_Resources"
alias resources="cd $RESOURCES; pwd"
alias Resources=resources

export ARCHIVE="$DOCUMENTS/4_Archive"
alias archive="cd $ARCHIVE; pwd"
alias Archive=archive

# ---- STORAGES folders --------------------------------------------------

export STORAGES='~/Storages'

alias storages="cd $STORAGES; pwd"
alias Storages=storages

export GITBOX="$STORAGES/GitBox"
alias gitbox="cd $GITBOX; pwd"
alias GitBox=gitbox

export DROPBOX="$STORAGES/DropBox"
alias dropbox="cd $DROPBOX; pwd"
alias DropBox=dropbox

export GOOGLEDRIVE="$STORAGES/GoogleDrive"
alias googledrive="cd $GOOGLEDRIVE; pwd"
alias GoogleDrive=googledrive

# ---- XYZ ---------------------------------------------------------------

export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# ---- CONDA -------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/mambaforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/usr/local/Caskroom/mambaforge/base/etc/profile.d/mamba.sh" ]; then
    . "/usr/local/Caskroom/mambaforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
