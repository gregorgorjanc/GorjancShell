#!/bin/sh

# https://ss64.com/mac/syntax-profile.html
# 
# Order of evaluation:
# /etc/profile → .bash_profile → .bash_login → .profile
# .zshenv → .zprofile → .zshrc → .zlogin
# 
# .zshenv is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search $PATH, plus other important environment variables.
# 
# .zprofile is only evaluated when you login to your mac user account.
# After editing .zprofile relaunch the terminal or run: exec zsh --login
# 
# .zshrc is evaluated every time a shell is launched.
# Used for parameters like $PROMPT, aliases, functions, options, history variables
# and keymappings you would like to have in both login and interactive shells.

# ---- HOMEBREW ---------------------------------------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"

# ---- PATH ---------------------------------------------------------

# Add commonly used folders to $PATH
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# ---- SHRC ---------------------------------------------------------

# if [ -f "$HOME/.zshrc" ]; then
#   source "$HOME/.zshrc"
# fi

