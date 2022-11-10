# Neovim configuration

- Clone and place this repository in the directory `~/.config` (MacOS)


## Required dependencies
- [neovim](https://github.com/neovim/neovim) (version >= 0.7.0): `brew install neovim` (MacOS)
- [packer](https://github.com/wbthomason/packer.nvim): a plugin manager
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
- prettier: `yarn global add prettier` or `npm install prettier -g`
- eslint: `yarn global add eslint` or `npm install eslint -g`
- [rg](https://github.com/BurntSushi/ripgrep): `brew install ripgrep`
- [fd](https://github.com/sharkdp/fd): `brew install fd`
- [lua-language-server](https://github.com/sumneko/lua-language-server/wiki/Getting-Started#command-line): `brew install lua-language-server`
- [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server): `npm install -g typescript-language-server typescript`


## Plugins Installation
- Open file: `~/.config/nvim/lua/steve/plugins.lua`
- Run command: `:PackerInstall`
- Quit and reopen neovim.


## References
- https://github.com/LunarVim/Neovim-from-scratch
- https://github.com/craftzdog/dotfiles-public
- https://github.com/levanthuanmy/nvim
- https://github.com/miltonllera/neovim-config
- https://github.com/brainfucksec/neovim-lua/tree/main/nvim/lua
- https://github.com/glepnir/nvim
- https://youtu.be/ajmK0ZNcM4Q
- https://youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ
