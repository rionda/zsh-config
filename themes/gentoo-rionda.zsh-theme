function prompt_char {
	# Use percent sign for normal user
	if [ $UID -eq 0 ]; then echo "#"; else echo "%%"; fi
}

function git_prompt {
	if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
		BRANCH=$(git_current_branch)
		if [[ -n ${BRANCH} ]]; then
			echo "$ZSH_THEME_GIT_PROMPT_PREFIX$BRANCH$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
		else
			return 0
		fi
	fi
}

# For root: (red,bold)root@hostname, For non-root: (green,bold)hostname
# (blue,bold)last_three_components_of_pwd_with_tilde_contraction git_prompt
# status_of_parser (for continuation lines) (specified by %_) prompt_char
PROMPT='%(!.%{$fg_bold[red]%%n@}.%{$fg_bold[green]%})%m %{$fg_bold[blue]%}%3~ $(git_prompt)%_$(vi_mode_prompt_info)%{$reset_color%}$(prompt_char)%{$reset_color%} '

# Right prompt: (blue,bold)[time of day in 24hr with seconds]
RPROMPT='%{$fg_no_bold[blue]%}[%*]%{$reset_color%}'

# Indicator of 'normal' mode for the vi-mode plugin.
MODE_INDICATOR="%{$fg[magenta]%}©"

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}] "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[yellow]%}↓"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}◒"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}△"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}↪"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}➜"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}▧"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}!!!!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}§"
