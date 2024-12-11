# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
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
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# This customizes the iTerm title bar to show useful info for in context of the
# tab showing in the terminal.
precmd() {
  local max_length=25  # Max total length for the tab title
  local prefix=".."    # Prefix to indicate truncation
  local prefix_length=${#prefix}
  local allowed_length=$((max_length - prefix_length))  # Remaining length for the path
  local truncated_path
  local current_path="$PWD"

  # Check if the path exceeds the max length
  if [[ ${#current_path} -gt $max_length ]]; then
    # Extract the last allowed_length characters from the path
    truncated_path="${prefix}${current_path: -$allowed_length}"
  else
    # If the path is short enough, use it as-is
    truncated_path="$current_path"
  fi

  # Set the iTerm2 tab and window titles, respectively.
  print -Pn "\e]1;$truncated_path ($(uname -m))\a"
  print -Pn "\e]2;%n@%m: $truncated_path ($(uname -m))\a"
}

# Toggles for using arm64 vs x86_64 homebrew.
current_arch() { 
    echo "Current arch: $(uname -m)"
    echo "ARCH env var: ${ARCH:-NONE}"
}

switch_arch() {
    local new_arch=$1
    if [[ "$new_arch" != "arm64" && "$new_arch" != "x86_64" ]]; then
        echo "Invalid architecture. Use 'arm64' or 'x86_64'"
        return 1
    fi

    # Set the ARCH environment variable
    export ARCH=$new_arch
    
    # Only switch if we're not already on the desired architecture
    if [[ "$(uname -m)" != "$new_arch" ]]; then
        echo "Switching to new arch: ${ARCH}"
        # Use arch -x86_64 or arch -arm64 to execute subsequent commands
        if [[ "$new_arch" == "x86_64" ]]; then
            # Switch to x86_64 architecture
            exec arch -x86_64 /bin/zsh
        else
            # Switch to arm64 architecture
            exec arch -arm64 /bin/zsh
        fi
    fi
}

# Initial architecture setup - runs when shell starts
initial_arch_setup() {
    # If ARCH is set (like from VSCode), switch to that architecture
    if [[ -n "$ARCH" ]]; then
        switch_arch "$ARCH"
    fi
}

# Run the initial setup
initial_arch_setup

alias zarm='ARCH=arm64 initial_arch_setup'
alias zros='ARCH=x86_64 initial_arch_setup'
alias brow='arch -x86_64 /usr/local/Homebrew/bin/brew'
alias ib='PATH=/usr/local/bin'

if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    alias brew='arch -x86_64 /usr/local/bin/brew'
    export PATH="/usr/local/bin:$PATH"
    eval "$(/usr/local/bin/brew shellenv)"
fi

# For Java

export JAVA_TOOL_OPTIONS='-Djava.awt.headless=true'

jdk() {
    version=$1
    echo "Setting java version ${version}"
    unset JAVA_HOME
    home_version="${version}"
    if [ "1.8" = "${version}" ]; then
        home_version="8"
    fi
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-${home_version}.jdk/Contents/Home"
    jenv add "${JAVA_HOME}" 
    jenv local "${version}"
    export LEIN_JAVA_CMD=$JAVA_HOME/bin/java
    export PATH="$JAVA_HOME/bin":$PATH;
    java -version
}

alias jdk8="jdk 1.8"
alias jdk11="jdk 11"
alias jdk17="jdk 17"
alias jdk21="jdk 21"

eval "$(jenv init -)"

# Default JDK
jdk21

# For Ruby

if [[ $(uname -m) == "arm64" ]]; then
    echo "Using rbenv with arm64"
    export RBENV_ROOT="${HOME}/.rbenv"

    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
    rbenv global 3.2.0

else
    echo "Using brew/rbenv with x86_64"
    export RBENV_ROOT="${HOME}/.rbenv_x86"

    # Initialize rbenv for x86
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
    rbenv global 3.2.0
fi

# For Python

eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.13.0/bin/python"

# For fun

alias weather='curl wttr.in'

# Chrome cmd line

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

eval "$(direnv hook zsh)"

alias lzd='lazydocker'

# Created by `pipx` on 2024-07-22 03:09:49
export PATH="$PATH:/Users/mikerod/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#nvm install 18 --latest-npm
nvm use 18
