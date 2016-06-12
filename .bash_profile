#!/bin/sh

# Load our dotfiles like ~/.bash_prompt, etcâ¦
#   ~/.extra can be used for settings you donât want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

#
# function to print the directory tree
#
function tree {
  find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
export JAVA_TOOL_OPTIONS='-Djava.awt.headless=true'
export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m"

alias ll='ls -lart'
alias lla='ls -lart'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='01;35'
#
# function to get the git branch
#
#
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#
# History file settings
#
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history

export CLICOLOR=1
export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \[\033\e[0;31m\]\u\$\[\033[0m\]\n"
export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \[\033\e[34m\]\$(parse_git_branch) \[\033\e[0;31m\]\u\e[0;37m->\n"


export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;38;5;226'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# git completion
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# svn completion
if [ -f ~/.svn_completion.bash ]; then
    source ~/.svn_completion.bash
fi

# svn prompt
if [ -f ~/.svn_prompt.bash ]; then
    . ~/.svn_prompt.bash
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh


function tree {
find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

if [ -f ~/.maven-completion.bash ]; then
  . ~/.maven-completion.bash
fi


export PATH=$HOME/.rbenv/bin:/usr/local/sbin:$PATH
eval "$(rbenv init -)"
