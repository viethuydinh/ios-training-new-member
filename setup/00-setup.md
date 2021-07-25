# Setup Environment for iOS Development

## Prerequisites
- Mac machine

## Getting Started
### Install Command Line Tools
Open terminal and type:
```
$ sudo xcode-select --install 
```

### Install Homebrew
[Homebrew](https://brew.sh/) - The missing package manager for macOS (or Linux)
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Homebrew-Cask extends Homebrew and allows you to install large binary files via a command-line tool.
```
$ brew tap caskroom/cask
```

### Install iTerm2
[iTerm2](https://www.iterm2.com/) is a terminal emulator for macOS that does amazing things.
```
$ brew cask install iterm2
```

### Install Z shell (zsh) or fish shell
Choose one.
```
$ brew install zsh
```
or
```
$ brew install fish
```

### Install Xcode
Download and install it from the App Store or from [Apple's website](https://developer.apple.com/xcode/).

### Install another Code Editor
Sometimes you want to edit other file types than .swift, eg: make a deploy script, ...
Just choose one between Sublime Text and Visual Studio Code
```
$ brew cask install sublime-text
```
or
```
$ brew cask install visual-studio-code
```

### More
Checkout below resources for more
- [New MacBook Setup for Developers](https://dev.to/therealdanvega/new-macbook-setup-for-developers-2nma)
- [macOS Setup Guide](https://sourabhbajaj.com/mac-setup/)
