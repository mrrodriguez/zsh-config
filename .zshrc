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
# DISABLE_AUTO_TITLE="true"

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

# Customize to your needs...
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JAVA_HOME
export LEIN_JAVA_CMD=$JAVA_HOME/bin/java

function setupjdk6 {
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home 
    export LEIN_JAVA_CMD=${JAVA_HOME}/bin/java
}

function setupjdk7 {
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
    export LEIN_JAVA_CMD=${JAVA_HOME}/bin/java
}

function setupjdk8 {
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home
    export LEIN_JAVA_CMD=${JAVA_HOME}/bin/java
}

alias jdk6="setupjdk6"
alias jdk7="setupjdk7"
alias jdk8="setupjdk8"

alias mvnfast="mvn clean install -DskipTests"
alias mvnshade="mvn clean install -DskipTests -Pshade"

PATH=/usr/local/bin:${PATH}
PATH=${PATH}:/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

export HADOOP_PREFIX=/opt/cdh4_mac_bundle/hadoop-2.0.0-cdh4.1.1
export HADOOP_MAPRED_HOME=/opt/cdh4_mac_bundle/hadoop-2.0.0-mr1-cdh4.1.1
export HBASE_HOME=/opt/cdh4_mac_bundle/hbase-0.92.1-cdh4.1.1

export PATH=$PATH:$HADOOP_PREFIX/bin:$HBASE_HOME/bin

alias hadoopstart='$HADOOP_PREFIX/sbin/start-dfs.sh;$HADOOP_MAPRED_HOME/bin/start-mapred.sh'
alias hadoopstop='$HADOOP_PREFIX/sbin/stop-dfs.sh;$HADOOP_MAPRED_HOME/bin/stop-mapred.sh'

alias hbasestart='$HBASE_HOME/bin/start-hbase.sh'
alias hbasestop='$HBASE_HOME/bin/stop-hbase.sh'

alias clusterstart='hadoopstart && hbasestart'
alias clusterstop='hbasestop && hadoopstop'

# I don't think this works... Hmmm, I'll come back to it I guess.
alias emacs="/usr/local/Cellar/emacs/24.2/Emacs.app/Contents/MacOS/Emacs -nw"

export MAVEN_OPTS="-Xmx1024M -XX:MaxPermSize=512M"
export JAVA_TOOL_OPTIONS='-Djava.awt.headless=true'

# TODO fix user path when I know one.
# It seems the `brew` plugin automatically handles pushing brew
# install paths ahead of root binaries, leaving it for now though.
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH:/Users/MR027750/.rvm/gems/ruby-1.9.3-p362/bin:/Users/MR027750/.rvm/gems/ruby-1.9.3-p362@global/bin:/Users/MR027750/.rvm/rubies/ruby-1.9.3-p362/bin:/Users/MR027750/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/cdh4_mac_bundle/hadoop-2.0.0-cdh4.1.1/bin:/opt/cdh4_mac_bundle/hbase-0.92.1-cdh4.1.1/bin
