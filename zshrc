UNAME=`uname` # OS name, used later

umask 0077

# Stuff for OS X
if [ ${UNAME} = "Darwin" ]; then
	# /etc/zprofile calls /usr/libexec/path_helper, which messes up the order of
	# directories. Then ~/.zprofile come in and adds duplicates. Rather than
	# playing tricks, we just set PATH directly the way we want it.
	PATH=/Users/matteo/bin:/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/Library/Apple/usr/bin/
	# Add MacPorts paths as needed
	export LIBRARY_PATH=/opt/local/lib
	export C_INCLUDE_PATH=/opt/local/include/
	export CPLUS_INCLUDE_PATH=/opt/local/include/
	export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
	export CXX=clang++
	export TEXINPUTS=.:/opt/local/share/texmf//:

	export LC_ALL="en_US.UTF-8"
fi

# Check for updates to oh-my-zsh every day, and ask to update.
zstyle ':omz:update' frequency 1
zstyle ':omz:update' mode reminder
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/ (or a custom dir)
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="gentoo-rionda"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
unsetopt correctall # Do not correct the command line arguments
# If a pattern for filename generation has no matches, leave it unchanged in the
# argument list (setting nomatch would print an error instead)
unsetopt nomatch

# Turn off all beeps
#unsetopt BEEP
# Turn off autocomplete beeps (at least some)
unsetopt LIST_BEEP

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/zsh-config

# fzf config
if [ ${UNAME} = "Darwin" ]; then
	export FZF_DEFAULT_COMMAND='/opt/local/bin/rg --files --hidden --glob "!.git/*"'
fi
# macports fzf suggest using the following, but instead we use the oh-my-zsh fzf
# plugin
#source /opt/local/share/fzf/shell/key-bindings.zsh
#source /opt/local/share/fzf/shell/completion.zsh

# oh-my-zsh fzf-tab plugin conf
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Use tmux popup to show the completions
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# oh-my-zsh zsh-autosuggestions plugin conf
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# oh-my-zsh vi-mode plugin conf
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# zsh-syntax-highlighting *must* be the last plugin loaded.
# Also, some other plugin conflicts with the fzf keybindings, so fzf must be
# loaded late
plugins=(
	colored-man-pages colorize dirhistory extract git kitty macos macports vi-mode sudo zsh-autosuggestions zsh-completions z fzf fzf-tab zsh-syntax-highlighting)

autoload -U compinit && compinit # reload completion, for zsh-completions

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

# kitty aliases
if [ -e "${HOME}/.config/kitty/kittyaliases.zsh" ]; then
	source "${HOME}/.config/kitty/kittyaliases.zsh"
fi

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
