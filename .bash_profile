#!/bin/sh


# function to get the git branch
#
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

JAVA_HOME=`/usr/libexec/java_home -v 1.7`
#GRADLE_HOME=/usr/local/Cellar/gradle/1.7/libexec
#export GRADLE_HOME
export CLICOLOR=1
export JAVA_HOME
export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \[\033\e[0;31m\]\u\$\[\033[0m\]\n"
export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \[\033\e[34m\]\$(parse_git_branch) \[\033\e[0;31m\]\u\e[0;37m->\n"
#PATH=/Developer/usr/bin:/Library/PostgreSQL/9.1/bin:$PATH:/usr/local/mysql/bin

export PATH

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi


function tree {
find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

alias ll='ls -lrt'

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"
### Added bash complete for rabbitmq
#source /usr/local/etc/bash_completion.d/rabbitmqadmin.bash
