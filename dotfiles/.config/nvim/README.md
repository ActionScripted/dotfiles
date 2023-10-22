https://github.com/nanotee/nvim-lua-guide
https://teukka.tech/luanvim.html
https://github.com/alpha2phi/modern-neovim

## Troubleshooting

- **Indentation or formatting not working.**
  - This is likely due to an issue with treesitter or something null-ls is calling.
  - Treesitter: there isn't much to do but wait for a fix or search their issue tracker.
  - null-ls: make sure things are installed correctly and active for the file (`:NullLsInfo`)
  - Examples:
    - Treesitter: Python raw strings (`r"sup"`) caused indentation to stop working.
    - null-ls: Black wasn't auto-formatting on save because `pyproject.toml` had invalid `extend-exclude`

## Future

Things to try out:

- <https://github.com/folke/flash.nvim>
- <https://github.com/SmiteshP/nvim-navbuddy>
