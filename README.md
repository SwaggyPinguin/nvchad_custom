# Installation

## Setup

Clone the NvChad git repository

```
cd ~/.config
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
```

Clone the custom configuration repository to the nvchad folder

```
cd ~/.config/nvim/lua/
git clone https://github.com/SwaggyPinguin/nvchad_custom.git custom
# or
git clone git@github.com:SwaggyPinguin/nvchad_custom.git
```

# Uninstall

Uninstall complete NvChad

```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

Uninstall your custom configs

```
rm -rf ~/.config/nvim/lua/custom
```
