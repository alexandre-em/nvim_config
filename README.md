# Neovim setup

This is my personal nvim setup for coding with :

- Java
- Typescript

## Prerequisites

First install neovim and all dependencies that will be used to make it functional.

```sh
    pacman -Sy neovim gcc ripgrep fd
    pacman -Sy nodejs npm python-pip
    pacman -Sy git lazygit
    npm i -g npm n
    n latest
    npm i -g neovim
    pip install neovim pynvim --upgrade
    npm install -g @fsouza/prettierd
```

Install nvim plugin manager (packer) by cloning the repository

```sh
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Then install the programming language you want and their dependencies

### Java

First install the recent version or specific version of Java (must be >= 17)

```sh
    pacman -Sy Java
    pacman -Sy jre17-openjdk
    pacman -Sy jdk17-openjdk
```

Then install the `java-debug` project by cloning the repository where you want
it to be installed

```sh
    git clone https://github.com/microsoft/java-debug
    cd java-debug
    ./mvnw clean install
```

Then download the Lombok library (jar) and save it to `~/.local/share/eclipse`
folder (create it if do not exist)

### Typescript

```sh
    npm i -g neovim typescript typescript-language-server
```

## Nvim

```sh
    mkdir .config/nvim/
    cd .config/nvim/
    git clone https://github.com/alexandre-em/nvim_config.git
```

Edit the `java.lua` file and adapt the files path to yours

Open nvim and install all plugins

```sh
    :PackerInstall
    :TSInstall markdown markdown_inline
    :Mason
    # Then select by pressing the key `i`
    #   eslint_d java-debug-adapter java-test jdtls
    #   lua-language-server prettierd typescript-language-server
```

## Shortcuts

### Vim

#### Nvim Surround

    Old text                    Command         New text

---

    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

### Tmux

| Key                  | Description                |
| -------------------- | -------------------------- |
| `ctrl-b + o`         | Switch between buffers     |
| `ctrl-b + q + ${i}`  | Switch to the `i` buffer   |
| `ctrl-b + %`         | Create a vertical buffer   |
| `ctrl-b + "`         | Create a horizontal buffer |
| `ctrl-b + alt-arrow` | Resize the buffer          |
