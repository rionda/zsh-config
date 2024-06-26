function prompt_char {
	# Use percent sign for normal user
	if [ $UID -eq 0 ]; then echo "#"; else echo "%%"; fi
}

# For root: (red,bold)root@hostname, For non-root: (green,bold)hostname
# (blue,bold)last_three_components_of_pwd_with_tilde_contraction git_prompt
# status_of_parser (for continuation lines) (specified by %_) prompt_char
PROMPT='%(!.%{$fg_bold[red]%%n@}.%{$fg_bold[green]%})%m %{$fg_bold[blue]%}%3~ ${ZSH_THEME_GIT_PROMPT_PREFIX}$(git_current_branch)$(git_prompt_status)${ZSH_THEME_GIT_PROMPT_SUFFIX}%_$(vi_mode_prompt_info)%{$reset_color%}%{$fg_bold[blue]%}$(prompt_char)%{$reset_color%} '

# Right prompt: (blue,bold)[time of day in 24hr with seconds]
RPROMPT='%{$fg_no_bold[blue]%}[%*]%{$reset_color%}'

# Indicator of 'normal' mode for the vi-mode plugin.
MODE_INDICATOR="%{$fg[magenta]%}©"

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}] "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}↑$(git_commits_ahead)"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[yellow]%}↓"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}◒"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[yellow]%}↔"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}△"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}↪"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}➜"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}▧"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}!!!!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}§"
