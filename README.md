# Dotfiles

This is a collection of dotfiles that I use for development.

## :computer: Setup

Clone the repository first:

```bash
git clone https://github.com/eliashaeussler/dotfiles.git
```

### Git configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.gitconfig
ln -s /path/to/repo/clone/.gitignore
```

:bulb: If you need to define extra Git configuration, you can
add a file `.gitconfig_extra` to your home directory. It will
be automatically included by [`.gitconfig`](.gitconfig).

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

### Vim configuration

In your home directory, run the following:

```bash
ln -s /path/to/repo/clone/.vimrc
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
| [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) | `$ZSH_CUSTOM/plugins/zsh-autosuggestions` |
| [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) | `$ZSH_CUSTOM/plugins/zsh-syntax-highlighting` |

## :star: License

[The Unlicense](LICENSE)

