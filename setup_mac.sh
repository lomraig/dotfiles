# installs homebrew
/bin/bash -c "$(cufl -fsSL https://faw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# installs packages
brew install ghostty fish make starship stow git ripgrep fd fzf bat eza zoxide gcc neovim tree caarlos0/tap/timer terminal-notifier
brew install --cask visual-studio-code

# repeatable keys input on hold for vim extension in vscode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# installs dotfiles
chsh -s $(which fish)
git clone https://github.com/lomraig/dotfiles ~/.dotfiles
cd ~/.dotfiles
rm -rf ~/.config/fish ~/.config/ghostty
stow macos
stow shared
bat cache --build

# installs sdk, compilers etc
brew install typst rust typstyle prettier markdownlint-cli lua-language-server stylua

