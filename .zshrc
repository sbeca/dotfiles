#
# .zshrc
#
# @author Jeff Geerling
# @author Scott Beca
#

# Colors
unset LSCOLORS
export CLICOLOR=1

# Don't require escaping globbing characters in zsh
unsetopt nomatch

# Nicer prompt
export PS1=$'\n'"%F{green} %*%F{white} %3~ %F{white}"$'\n'"$ "

# Enable plugins
plugins=(git brew history kubectl history-substring-search)

# Set up homebrew environment
ARCH_NAME="$(uname -m)"
if [ "${ARCH_NAME}" = "x86_64" ]; then
    BREW_BIN_PATH="/usr/local/bin"
    BREW_SHARE_PATH="/usr/local/share"
elif [ "${ARCH_NAME}" = "arm64" ]; then
    BREW_BIN_PATH="/opt/homebrew/bin"
    BREW_SHARE_PATH="/opt/homebrew/share"
else
    echo "Unknown architecture: ${ARCH_NAME}"
fi
if [ -x "$BREW_BIN_PATH/brew" ]; then
  eval "$($BREW_BIN_PATH/brew shellenv)"
fi

# Set Android SDK path
export ANDROID_HOME="$HOME/Library/Android/sdk"

# Custom $PATH with various extra locations.
# Add Rust to $PATH
export PATH="$HOME/.cargo/bin:$PATH"
# Add .NET SDK tools to $PATH
export PATH="$PATH:$HOME/.dotnet/tools"
# Add Android SDK platform tools to $PATH
export PATH="$PATH:$ANDROID_HOME/platform-tools"
# Add Python version bundled with Apple's command line tools to $PATH
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
# Add LM Studio CLI to $PATH
export PATH="$HOME/.lmstudio/bin:$PATH"

# Bash-style time output
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Allow history search via up/down keys
source ${BREW_SHARE_PATH}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Completions
autoload -Uz compinit && compinit
# Case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Tell homebrew to not autoupdate every single time I run it (just once a week)
export HOMEBREW_AUTO_UPDATE_SECS=604800
