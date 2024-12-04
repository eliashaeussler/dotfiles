#!/usr/bin/env bash
set -e

readonly source_dir="$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"
readonly target_dir="${1-$HOME}"
readonly omz_dir="${target_dir}/.oh-my-zsh"

echo "Source directory: $source_dir"
echo "Target directory: $target_dir"

# Check if target directory is writable
if [ ! -d "$target_dir" ]; then
    >&2 echo "The target directory does not exist or is not writable."
    exit 1
fi

function prompt() {
  local label="$1"

  printf "\e[33m%s\e[39m [\e[32mY\e[39m/n] " "$label"
}

function is_brew_package_installed() {
  local package="$1"

  set +e
  brew list "${package}" >/dev/null 2>&1
  local exitCode="$?"
  set -e

  return "$exitCode"
}

function is_omz_plugin_installed() {
  local plugin="$1"

  if [ -d "${omz_dir}/custom/plugins/${plugin}" ]; then
    return 0
  fi

  return 1
}

function _install_git() {
  echo "Linking configuration files..."
  ln -svfn "${source_dir}/.gitconfig" "${target_dir}/.gitconfig"
  ln -svfn "${source_dir}/.gitignore" "${target_dir}/.gitignore"

  echo
  echo "Installing required programs..."
  if ! is_brew_package_installed git-delta; then
    brew install git-delta
  else
    echo "'git-delta' is already installed."
  fi
}

function _install_ssh() {
  local source_config_file="${source_dir}/.ssh/config"
  local target_config_file="${target_dir}/.ssh/config"
  local sockets_directory="${target_dir}/.ssh/sockets"
  local header_comment="# added by eliashaeussler/dotfiles"
  local content="${header_comment}\nMatch all\nInclude ${source_config_file}\n"

  echo "Configuring includes..."
  if [ -f "${target_config_file}" ]; then
    content="${content}\n$(cat "${target_config_file}")"
  else
    mkdir -p "$(dirname "${target_config_file}")"
  fi

  if grep -q "${header_comment}" "${target_config_file}"; then
    echo "Already added."
  else
    echo -e "${content}" > "$target_config_file"
    echo "Done."
  fi

  echo "Creating sockets directory..."
  if [ -d "${sockets_directory}" ]; then
    echo "Already exists."
  else
    mkdir -p "${sockets_directory}"
    echo "Done."
  fi
}

function _install_starship() {
  echo "Linking configuration file..."
  mkdir -p "${target_dir}/.config"
  ln -svfn "${source_dir}/.config/starship.toml" "${target_dir}/.config/starship.toml"

  echo
  echo "Installing required programs..."
  if ! is_brew_package_installed starship; then
    brew install starship
  else
    echo "'starship' is already installed."
  fi
  if ! is_brew_package_installed drud/ddev/ddev; then
    brew install drud/ddev/ddev
  else
    echo "'drud/ddev/ddev' is already installed."
  fi
}

function _install_restic() {
  echo "Linking scripts..."
  mkdir -p "${target_dir}/.config/restic"
  ln -svfn "${source_dir}/.config/restic/backup" "${target_dir}/.config/restic/backup"
  ln -svfn "${source_dir}/.config/restic/cleanup" "${target_dir}/.config/restic/cleanup"

  echo
  echo "Creating empty configuration files..."
  touch "${target_dir}/.config/restic/excludes.txt"
  touch "${target_dir}/.config/restic/files.txt"
  touch "${target_dir}/.config/restic/password.txt"
  touch "${target_dir}/.config/restic/repository.txt"

  echo
  echo "Installing required programs..."
  if ! is_brew_package_installed restic; then
    brew install restic
  else
    echo "'restic' is already installed."
  fi
}

function _install_vim() {
  echo "Linking configuration file..."
  ln -svfn "${source_dir}/.vimrc" "${target_dir}/.vimrc"
}

function _install_nano() {
  echo "Linking configuration file..."
  ln -svfn "${source_dir}/.nanorc" "${target_dir}/.nanorc"

  echo
  echo "Installing required programs..."
  if ! is_brew_package_installed nano; then
    brew install nano
  else
    echo "'nano' is already installed."
  fi
}

function _install_zsh() {
  echo "Linking configuration file..."
  ln -svfn "${source_dir}/.zsh_aliases" "${target_dir}/.zsh_aliases"
  ln -svfn "${source_dir}/.zshrc" "${target_dir}/.zshrc"

  echo
  echo "Installing required programs..."
  if [ ! -d "${omz_dir}" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "'Oh My Zsh' is already installed."
  fi
  if ! is_omz_plugin_installed git-flow-completion; then
    git clone https://github.com/bobthecow/git-flow-completion "${omz_dir}/custom/plugins/git-flow-completion"
  else
    echo "'git-flow-completion' is already installed."
  fi
  if ! is_omz_plugin_installed k; then
    git clone https://github.com/supercrabtree/k "${omz_dir}/custom/plugins/k"
  else
    echo "'k' is already installed."
  fi
  if ! is_omz_plugin_installed zsh-autosuggestions; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${omz_dir}/custom/plugins/zsh-autosuggestions"
  else
    echo "'zsh-autosuggestions' is already installed."
  fi
  if ! is_omz_plugin_installed zsh-syntax-highlighting; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${omz_dir}/custom/plugins/zsh-syntax-highlighting"
  else
    echo "'zsh-syntax-highlighting' is already installed."
  fi
  if ! is_brew_package_installed mcfly; then
    brew install mcfly
  else
    echo "'mcfly' is already installed."
  fi
}

function _install_scripts() {
  echo "Linking scripts..."
  ln -svfn "${source_dir}/scripts" "${target_dir}/scripts"
}

# ------

# Git configuration
echo
read -p "$(prompt "Set up Git configuration?")" -n 1 -r setup_git
echo

if [[ $setup_git =~ ^[Yy]?$ ]]; then
  _install_git
else
  echo "Skipped."
fi

# SSH configuration
echo
read -p "$(prompt "Set up SSH configuration?")" -n 1 -r setup_ssh
echo

if [[ $setup_ssh =~ ^[Yy]?$ ]]; then
  _install_ssh
else
  echo "Skipped."
fi

# Starship configuration
echo
read -p "$(prompt "Set up Starship configuration?")" -n 1 -r setup_starship
echo

if [[ $setup_starship =~ ^[Yy]?$ ]]; then
  _install_starship
else
  echo "Skipped."
fi

# Restic configuration
echo
read -p "$(prompt "Set up Restic configuration?")" -n 1 -r setup_restic
echo

if [[ $setup_restic =~ ^[Yy]?$ ]]; then
  _install_restic
else
  echo "Skipped."
fi

# Vim configuration
echo
read -p "$(prompt "Set up vim configuration?")" -n 1 -r setup_vim
echo

if [[ $setup_vim =~ ^[Yy]?$ ]]; then
  _install_vim
else
  echo "Skipped."
fi


# Nano configuration
echo
read -p "$(prompt "Set up nano configuration?")" -n 1 -r setup_nano
echo

if [[ $setup_nano =~ ^[Yy]?$ ]]; then
  _install_nano
else
  echo "Skipped."
fi

# ZSH configuration
echo
read -p "$(prompt "Set up ZSH configuration?")" -n 1 -r setup_zsh
echo

if [[ $setup_zsh =~ ^[Yy]?$ ]]; then
  _install_zsh
else
  echo "Skipped."
fi

# Scripts
echo
read -p "$(prompt "Set up scripts?")" -n 1 -r setup_scripts
echo

if [[ $setup_scripts =~ ^[Yy]?$ ]]; then
  _install_scripts
else
  echo "Skipped."
fi

echo
printf "\e[32mDone\e[39m 🎉"
echo
