# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew lein jira mvn z)

source $ZSH/oh-my-zsh.sh

# https://stackoverflow.com/a/48341347/924604
PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '$PROMPT

# Customize to your needs...
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# from http://www.timbabwe.com/2012/05/iterm_tab_and_window_titles_with_zsh/ (experimenting with it still)
# set tab title to cwd
precmd () {
  tab_label=${PWD/${HOME}/\~} # use 'relative' path
  echo -ne "\e]2;${tab_label}\a" # set window title to full string
  echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
}

jdk() {
    version=$1
    echo "Setting java version ${version}"
    unset JAVA_HOME
    home_version="${version}"
    if [ "1.8" = "${version}" ]; then
        home_version="8"
    fi
    jenv local "${version}"
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-${home_version}.jdk/Contents/Home"
    export LEIN_JAVA_CMD=$JAVA_HOME/bin/java
    export PATH="$JAVA_HOME/bin":$PATH;
    java -version
}

alias jdk8="jdk 1.8"
alias jdk11="jdk 11"
alias jdk17="jdk 17"

# Default JDK
jdk11

alias mvnfast="mvn clean install -DskipTests"
alias mvnfasto="mvn clean install -DskipTests -o"
alias mvnshade="mvn clean install -DskipTests -Pshade"

export PATH=/usr/local/bin:/usr/local/sbin:${PATH}

# For Java
eval "$(jenv init -)"

alias dcomp='docker-compose'
alias dps='docker-compose ps'
alias dmach='docker-machine'

export JAVA_TOOL_OPTIONS='-Djava.awt.headless=true'

# For Ruby

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# For Python

eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.12.4/bin/python"

# For GPG with S3 and Maven
# gnupg
# https://github.com/pstadler/keybase-gpg-github/issues/11

# start gpg-agent if not already running

[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    export GPG_AGENT_INFO
else
    eval $( gpg-agent --daemon --enable-ssh-support )
fi

export GPG_AGENT_INFO
export GPG_TTY=$(tty)

# For fun

alias weather='curl wttr.in'

# Chrome cmd line

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#nvm install 18 --latest-npm
nvm use 18

alias lzd='lazydocker'

# Created by `pipx` on 2024-07-22 03:09:49
export PATH="$PATH:/Users/mikerod/.local/bin"
