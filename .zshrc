if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit add-zsh-hook vcs_info
  compinit
fi

# Load ZSH version control information
# used above for completions ###   autoload -Uz add-zsh-hook vcs_info
setopt PROMPT_SUBST
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:*' formats '(%b)'
#zstyle ':vcs_info:*' check-for-changes true
precmd() { vcs_info }

NEWLINE=$'\n'
PROMPT='%F{13}%m  %K{21}%F{11}%n%k%f %(?.%F{green}√.%F{red}?%?)%f %F{11}%D{%Y-%m-%d %H:%M:%S}%F{10}  %~%f%b %F{172} %F{red}${vcs_info_msg_0_} %f%F{white} ->🍺 ${NEWLINE}'

for file in ~/.{extra,bash_prompt,exports,functions,aliases}; do
        [ -r "$file" ] && source "$file"
done

SHELL_SESSIONS_DISABLE=1
setopt SHARE_HISTORY

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabagacad
export JAVA_TOOL_OPTIONS=-Djava.awt.headless=true
export MAVEN_OPTS="-Xms256m -Xmx4096m -Xverify:none"
export FEP=FuseInator
export DOCK_MVNREPO=${HOME}/.m2/repository

#export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \[\033\e[34m\]\$(parse_git_branch) \[\033\e[0;31m\]\u\e[0;37m->\n"
#export PS1="\[\033\e[1;35m\]\h:\[\033\e[1;32m\]\w \e[1;33m \$(__svn_ps1) \D{%F %T} \[\033\e[97;45m\]\$(parse_git_branch) \[\033\e[97;44m\] \u \e[0;37m->\360\237\215\272\n"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='01;35'

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=9000000
export SAVEHIST=7800000

export JAVA_TOOL_OPTIONS=-Djava.awt.headless=true
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
export JAVA_21_HOME=$(/usr/libexec/java_home -v21)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'
alias java21='export JAVA_HOME=$JAVA_21_HOME'
java11

# python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

plugin=(
  pyenv
)

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


#autoload -U colors && colors

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char


 #[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
#  Ruby env settings
#
eval "$(rbenv init -)"
export RACK_ENV=development
#export PATH="/usr/local/opt/yq@3/bin:/usr/local/sbin:$PATH"


#
#  Show an ASCII directory tree
#
function tree {
  find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

if [ -f ~/.maven-completion.bash ]; then
  . ~/.maven-completion.bash
fi

#
#  brew install openjdk@8
#  sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
#
function usejava () {
  version=$1
  sudo ln -sfn /usr/local/opt/openjdk@$version/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-$version.jdk
}


