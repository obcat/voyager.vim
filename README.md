# 🛰 voyager.vim

Minimal file exploror for Vim.

⚠️ **UNDER CONSTRUCTION**

Currently, only for \*nix. Windows is not supported.

## Getting started

To start a file explorer, run a command that starts editing files, giving the path to the directory you want to open.

**Examples:**

* Open current directory in the current window.
    ```
    edit .
    ```

* Open parent directory of current buffer in the vertical split window.
    ```
    vsplit %:h
    ```

## Special thanks

Inspired by:

* **[mattn/vim-molder](https://github.com/mattn/vim-molder)**
* [cocopon/vaffle.vim](https://github.com/cocopon/vaffle.vim)
* [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)

Thank you to the developers!


## License

MIT License.
