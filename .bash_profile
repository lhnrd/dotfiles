# Load the shell dotfiles:
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

BREW_PREFIX=$(brew --prefix)

# Add tab completion for many Bash commands
test -f /etc/bash_completion && . /etc/bash_completion
test -f $BREW_PREFIX/etc/bash_completion && . $BREW_PREFIX/etc/bash_completion
test -f $BREW_PREFIX/etc/profile.d/bash_completion.sh && . $BREW_PREFIX/etc/profile.d/bash_completion.sh

# Git auto complete
test -f ~/.git-completion.bash && . ~/.git-completion.bash

# NPM Auto Completion
type npm >/dev/null 2>&1 && . <(npm completion)

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
