function prompt_char {
	# Use percent sign for normal user
	if [ $UID -eq 0 ]; then echo "#"; else echo "%%"; fi
}

# For root: (red,bold)root@hostname, For non-root: (green,bold)hostname
# (blue,bold)last_three_components_of_pwd_with_tilde_contraction git_prompt_info
# status_of_parser (for continuation lines) (specified by %_)
# prompt_char
PROMPT='%(!.%{$fg_bold[red]%%n@}.%{$fg_bold[green]%})%m %{$fg_bold[blue]%}%3~ $(git_prompt_info)%_$(prompt_char)%{$reset_color%} '
RPROMPT='%{$fg_no_bold[blue]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}] "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}↑"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}◒"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}△"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}↪"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}!!!!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[gray]%}§"
