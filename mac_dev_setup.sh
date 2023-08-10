#!/bin/bash

function install {
  echo "Installing macOS Development Environment..."

  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install chruby ruby-install
  ruby-install ruby 3.2.2
  chruby ruby-3.2.2
  gem install bundler
  sudo gem install cocoapods
  gem install jekyll bundler
  gem install rails
  brew install git
  brew install gh
  brew tap heroku/brew && brew install heroku
  brew install node
  brew install nodenv
  brew install postgresql
  brew install redis
  brew install yarn

  echo "Installation complete! Enjoy your development environment."
}

function update {
  echo "Updating macOS Development Environment..."

  softwareupdate --install -a
  brew update
  brew upgrade
  ruby-install --latest
  latest_ruby=$(ruby-install --latest | grep 'ruby' | tail -1 | awk '{print $1}')
  chruby $latest_ruby
  gem update bundler
  sudo gem update cocoapods
  gem update jekyll
  gem update rails

  echo "Update complete! Your development environment is now up-to-date."
}

function doctor {
  echo "Running macOS Development Environment Doctor..."

  if xcode-select -p &>/dev/null; then echo "Xcode Command Line Tools: Installed"; else echo "Xcode Command Line Tools: Missing."; fi
  if brew --version &>/dev/null; then echo "Homebrew: $(brew --version)"; else echo "Homebrew: Missing."; fi
  if chruby --version &>/dev/null; then echo "Chruby: $(chruby --version)"; else echo "Chruby: Missing."; fi
  if ruby --version &>/dev/null; then echo "Ruby: $(ruby --version)"; else echo "Ruby: Missing."; fi
  if bundler --version &>/dev/null; then echo "Bundler: $(bundler --version)"; else echo "Bundler: Missing."; fi
  if pod --version &>/dev/null; then echo "Cocoapods: $(pod --version)"; else echo "Cocoapods: Missing."; fi
  if jekyll --version &>/dev/null; then echo "Jekyll: $(jekyll --version)"; else echo "Jekyll: Missing."; fi
  if rails --version &>/dev/null; then echo "Rails: $(rails --version)"; else echo "Rails: Missing."; fi
  if git --version &>/dev/null; then echo "Git: $(git --version)"; else echo "Git: Missing."; fi
  if gh --version &>/dev/null; then echo "GitHub CLI: $(gh --version)"; else echo "GitHub CLI: Missing."; fi
  if heroku --version &>/dev/null; then echo "Heroku CLI: $(heroku --version)"; else echo "Heroku CLI: Missing."; fi
  if node --version &>/dev/null; then echo "Node: $(node --version)"; else echo "Node: Missing."; fi
  if nodenv --version &>/dev/null; then echo "Nodenv: $(nodenv --version)"; else echo "Nodenv: Missing."; fi
  if psql --version &>/dev/null; then echo "Postgres: $(psql --version)"; else echo "Postgres: Missing."; fi
  if redis-server --version &>/dev/null; then echo "Redis: $(redis-server --version)"; else echo "Redis: Missing."; fi
  if yarn --version &>/dev/null; then echo "Yarn: $(yarn --version)"; else echo "Yarn: Missing."; fi

  echo "Doctor check complete."
}


clear  # Clears the terminal screen
printf '\e[3J' # Clears the terminal's scrollback buffer

echo "Welcome to the macOS Development Environment Setup!"
echo "Please choose an option:"
echo "1) Install"
echo "2) Update"
echo "3) Doctor"
echo "4) Exit"

read -p "Enter the number of your choice: " choice

case $choice in
  1)
    install
    ;;
  2)
    update
    ;;
  3)
    doctor
    ;;
  4)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac
