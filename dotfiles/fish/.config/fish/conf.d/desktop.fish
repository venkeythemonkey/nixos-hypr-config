# Disable the default Fish greeting.
set -g fish_greeting ""

# Aliases for modern CLI utilities
if command -q eza
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
    alias tree="eza --tree --icons"
end

if command -q bat
    alias cat="bat --paging=never"
end

if command -q yazi
    alias y="yazi"
end
