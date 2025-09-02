# Enable Powerlevel10k instant prompt. Should stay close to the top of zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# HISTORY
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
# setopt SHARE_HISTORY           # Share history between all sessions.

# Directory history using dir stack feature
setopt AUTO_PUSHD 		# Make cd push the old directory onto the directory stack.
setopt PUSHD_MINUS		# Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack. Normaly ‘-’ removes the entry from the list.
setopt PUSHD_SILENT 		# Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME 		# Do not print the directory stack after pushd or popd.
setopt PUSHD_IGNORE_DUPS	# Don’t push multiple copies of the same directory onto the directory stack.
DIRSTACKSIZE=8
alias dh="dirs -v"

setopt autocd extendedglob
bindkey -v

# ALIASES
alias nd="nix develop -c $SHELL -l"
alias nrs="sudo nixos-rebuild switch --flake \.\#"
alias nv="nvim"
alias bat_cap="cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:37/PNP0C09:00/PNP0C0A:00/power_supply/BAT0/capacity"
export BACKLIGHT="/sys/class/backlight/amdgpu_bl1/brightness"
export KBDLIGHT="/sys/class/leds/tpacpi::kbd_backlight/brightness"

source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh


