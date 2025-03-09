# Dotfiles

This is a collection of dotfiles that I use for development.

## :computer: Setup

Clone the repository first:

```bash
git clone https://github.com/eliashaeussler/dotfiles.git
```

### :robot: Automatic setup

```bash
cd dotfiles
./setup.sh
```

:bulb: The setup script works on macOS and Linux. On macOS, [Homebrew](https://brew.sh/)
must be installed. For Linux, `apt` is used as package manager. 

### :technologist: Manual setup

Run all required commands from the following configuration section.

## :pencil: Shipped configuration

### Git configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.gitconfig
ln -s /path/to/repo/clone/.gitignore
```

:bulb: If you need to define extra Git configuration, you can
add a file `.gitconfig_extra` to your home directory. It will
be automatically included by [`.gitconfig`](.gitconfig).

#### Required programs

* [`git-delta`](https://github.com/dandavison/delta)
* [`git-gone`](https://github.com/swsnr/git-gone)

### SSH configuration

Add the following to the beginning of your `.ssh/config` file:

```
Match all
Include /path/to/repo/clone/.ssh/config
```

### Starship configuration

In your home directory, run the following:

```bash
mkdir -p .config
cd .config
ln -s /path/to/repo/clone/.config/starship.toml
```

#### Required programs

* [DDEV](https://github.com/drud/ddev)
* Git

### Restic configuration

In your home directory, run the following:

```bash
mkdir -p .config/restic
cd .config/restic
ln -s /path/to/repo/clone/.config/restic/backup
ln -s /path/to/repo/clone/.config/restic/cleanup

# Set up Restic backup using config files
vim excludes.txt
vim files.txt
vim password.txt
vim repository.txt
```

### Vim configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.vimrc
```

### Nano configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.nanorc
```

### ZSH configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.zsh_aliases
ln -s /path/to/repo/clone/.zshrc
```

:bulb: If you need to define extra ZSH configuration, you can
add a file `.zshrc_extra` to your home directory. It will
be automatically included by [`.zshrc`](.zshrc).

#### Required ZSH modules and plugins

| Module name | Installation path |
|-------------|-------------------|
| [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) | `$HOME/.oh-my-zsh` |
| [`git-flow-completion`](https://github.com/bobthecow/git-flow-completion) | `$ZSH_CUSTOM/plugins/git-flow-completion` |
| [`k`](https://github.com/supercrabtree/k) | `$ZSH_CUSTOM/plugins/k` |
| [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) | `$ZSH_CUSTOM/plugins/zsh-autosuggestions` |
| [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) | `$ZSH_CUSTOM/plugins/zsh-syntax-highlighting` |

#### Required programs

* [McFly](https://github.com/cantino/mcfly)

### Scripts

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/scripts
```

## :star: License

[The Unlicense](LICENSE)

