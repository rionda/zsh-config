# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/ (or a custom dir)
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="gentoo-rionda"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
#export DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
unsetopt correctall # Do not correct the command line arguments arguments
# If a pattern for filename generation has no matches, leave it unchanged in the
# argument list (setting nomatch would print an error instead)
unsetopt nomatch

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/zsh-config

# oh-my-zsh fzf plugin conf
export FZF_BASE="/opt/local/share/fzf/shell"
export FZF_DEFAULT_COMMAND='/opt/local/bin/rg --files --hidden --glob "!.git/*"'
export FZF_TMUX=1

# oh-my-zsh tmux plugin conf
ZSH_TMUX_FIXTERM="true"
ZSH_TMUX_UNICODE="true"
ZSH_TMUX_AUTOSTART="true"

# oh-my-zsh zsh-autosuggestions plugin conf
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green"

# oh-my-zsh vi-mode plugin conf
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# zsh-syntax-highlighting *must* be the last plugin loaded.
# Also, some other plugin conflicts with the fzf keybindings, so fzf must be
# loaded late
plugins=(
	colored-man-pages colorize dirhistory git macos macports vi-mode sudo zsh-autosuggestions zsh-completions z fzf zsh-syntax-highlighting)

autoload -U compinit && compinit # reload completion, for zsh-completions

source /etc/profile
source $ZSH/oh-my-zsh.sh

export EDITOR=vim
export VISUAL=vim
export PAGER=less
# less(1) options: X (do not clear screen), F (automatically exit if the content
# can fit in a single screen), R (only output colors as raw), m (long prompt),
# E (automatically quit when reaching end-of-file)
export LESS=XFRmE
# Use ssh for rsync and svn (I don't really use svn anymore but...)
export RSYNC_RSH=ssh
export SVN_RSH=ssh

UNAME=`uname` # OS name, used later

# Stuff for OS X
if [ ${UNAME} = "Darwin" ]; then
	# Prepend my bin directory and MacPorts directories to PATH, if needed
	DIRS_TO_PREPEND_TO_PATH=/Users/matteo/bin:/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin
	if [ ! `echo ${PATH} | grep -q ^${DIRS_TO_PREPEND_TO_PATH}` ]; then
		PATH=${DIRS_TO_PREPEND_TO_PATH}:${PATH}
	fi
	# Add MacPorts paths as needed
	export LIBRARY_PATH=/opt/local/lib
	export C_INCLUDE_PATH=/opt/local/include/
	export CPLUS_INCLUDE_PATH=/opt/local/include/
	export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
	export CXX=clang++
	export TEXINPUTS=.:/opt/local/share/texmf//:
fi

# Setup GPG and, if needed, SSH agent through GPG
export GPG_TTY=$(tty)
# Setup SSH when not a remote host.
if [ ! -n "$SSH_TTY" ]; then
	gpg-connect-agent -q /bye # ensure that gpg-agent is running
	SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
# create a link for the SSH auth socket in a standardized place
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -L "$SSH_AUTH_SOCK" ]; then
		ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# Colors and highlight
export GREP_OPTIONS='--color=auto'
if [ ${UNAME} = "FreeBSD" ]; then
	export CLICOLOR=1 # for colors in ls(1) and maybe others
	#export LSCOLORS gxBxhxDxfxhxhxhxhxcxcx
	export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # solarized?
fi
export CLICOLORS=1 # No idea, more historical stuff for colors?
# For GNU ls(1) and zsh completion
export LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
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

# Bindings
set -o vi # use vi bindings

# Aliases
if [ ${UNAME} = "FreeBSD" ]; then
	alias ls='ls -FG' # for BSD ls: F (display slash after dirs), G (colors)
else
	alias ls='ls --color=auto -F' # F (display slash after dirs)
fi
alias cat=ccat # colorized cat
alias less=cless # colorized less

# host specific settings

# Set the clang version
set_clang_version () {
	CLANGXX=`which clang++$1`
	if [ $? -eq 0 ]; then
		export CXX=${CLANGXX}
	fi
	CLANG=`which clang$1`
	if [ $? -eq 0 ]; then
		export CC=${CLANG}
	fi
}

HOSTNAME=`hostname | cut -d . -f 1`
if [ ${UNAME} = "FreeBSD" ]; then
	if [ ${HOSTNAME} = "fantasma" ]; then
		set_clang_version 39
	elif [ ${HOSTNAME} = "triton" ]; then
		set_clang_version 40
	elif [ ${HOSTNAME} = "rionda" ]; then
		set_clang_version 40
	fi
fi

# cs.brown.edu stuff
if [ ${HOSTNAME} = "pompeii" ]; then
	# Define the shell-independent environment commands. See hooks(7) for more
	# information.
	setenvvar () { eval $1=\"$2\"; export $1; }
	setenvifnot () { if eval [ -z \"\$$1\" ]; then eval $1=\"$2\"; export $1; fi; }
	pathappend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=\$$1:$2; fi; }
	pathappendifdir () { if [ -d "$2" ]; then pathappend $*; fi; }
	pathprepend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=$2:\$$1; fi; }
	pathprependifdir () { if [ -d "$2" ]; then pathprepend $*; fi; }
	shellcmd () { _cmd=$1; shift; eval "$_cmd () { command $* \"\$@\"; }"; }
	sourcefile () { if [ -f "$1" ]; then . $1; fi; }
	sourcefile ~/.environment
	# Run the coursehooks.
	sourcefile /u/system/hooks/sh/simple-hooks
	# Set tty options.
	stty sane
	ulimit -c unlimited
fi

# Integration with iterm2. Does not work in tmux.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
