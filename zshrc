# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="gentoo"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(github cap gem lol zsh-syntax-highlighting bundler heroku vim)

source /etc/profile
source $ZSH/oh-my-zsh.sh
zstyle :omz:plugins:ssh-agent agent-forwarding on

unsetopt nomatch
unsetopt correctall

# Customize to your needs...
LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
export LS_COLORS;
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'fg=yellow'
  alias                         'fg=none,bold'
  builtin                       'fg=none,bold'
  function                      'fg=none,bold'
  command                       'fg=none,bold'
  hashed-command                'fg=none,bold'
  path                          'fg=cyan'
  globbing                      'fg=cyan'
  history-expansion             'fg=blue'
  single-hyphen-option          'fg=magenta'
  double-hyphen-option          'fg=magenta'
  back-quoted-argument          'fg=magenta,bold'
  single-quoted-argument        'fg=green'
  double-quoted-argument        'fg=green'
  dollar-double-quoted-argument 'fg=cyan'
  back-double-quoted-argument   'fg=cyan'
  assign                        'none'
)

#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^[OD" backward-word
bindkey "^[OC" forward-word

alias noh="unsetopt sharehistory"

unsetopt auto_name_dirs # rvm_rvmrc_cwd fix
unset RUBYOPT

alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"
alias npm_bin='PATH=`pwd`/node_modules/.bin:$PATH; rehash'

UNAME=`uname`

if [ ${UNAME} = "Darwin" ]; then
	PATH=/Users/matteo/bin:/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH #:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/Library/TeX/texbin:$PATH
	export MANPATH=`/usr/bin/manpath`
	export MANPATH=/opt/local/share/man:$MANPATH
	export LIBRARY_PATH=/opt/local/lib
	export C_INCLUDE_PATH=/opt/local/include/
	export CPLUS_INCLUDE_PATH=/opt/local/include/
	#export DYLD_LIBRARY_PATH=/Users/rionda/Documents/uni/code/lib/:/Users/rionda/ImageMagick-6.6.7/lib
	export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
	export CXX=clang++
fi

if [ ${UNAME} = "FreeBSD" ]; then
	export CXX=clang++39
	export CC=clang39
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/llvm39/lib/
fi

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS=XR
export GREP_OPTIONS='--color=auto'
#alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
export CLICOLOR=1
export CLICOLORS=1
#export LSCOLORS gxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # solarized?

if [ ${UNAME} = "FreeBSD" ]; then
	alias ls='ls -FG' # for BSD ls
	#alias gvim='vim'
else
	alias ls='ls --color=auto -F'
fi
export RSYNC_RSH=ssh
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
#export HADOOP_HOME /Users/rionda/hadoop-0.20.205.0
#export PATH=/Users/rionda/hadoop-0.20.205.0/bin:$PATH
#export CLASSPATH=.:/Users/rionda/hadoop-0.20.205.0/hadoop-core-0.20.205.0.jar:/Users/rionda/mahout/trunk/core/target/mahout-core-0.7-SNAPSHOT.jar

#export SVN_ROOT svn+ssh://mapreduce@verona.dei.unipd.it/svn
export SVN_RSH=ssh
export SVN_EDITOR="vim --noplugin"

#SSH_ENV="$HOME/.ssh/environment"
#
#function start_agent {
#	killall ssh-agent
#	echo -n "Initialising new SSH agent..."
#	ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#	echo succeeded
#	chmod 600 "${SSH_ENV}"
#	. "${SSH_ENV}" > /dev/null
#	#ssh-add;
#}
#
## Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#	. "${SSH_ENV}" > /dev/null
#	ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#		start_agent;
#	}
#else
#		start_agent;
#fi

export GPG_TTY=$(tty)
if [ ! -n "$SSH_TTY" ]; then
	gpg-connect-agent -q /bye
	SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock


[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
cd . # to rvm reload

set -o vi
