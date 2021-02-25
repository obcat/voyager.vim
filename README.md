# 🛰 voyager.vim

[![CI](https://github.com/obcat/voyager.vim/workflows/CI/badge.svg)](https://github.com/obcat/voyager.vim/actions?query=workflow%3Aci)

Minimal file exploror written in Vim9 script.

**LIMITATIONS**

* This plugin is written in Vim9 script, but the specification of Vim9 is not
yet stable. I guarantee this works fine on the Vim that I use, but it is also
not stable. In other words, you shouldn't use this plugin.

* Currently, only for \*nix. Windows is not supported.

## Getting started

To start a file explorer, run a command that starts editing files, giving the
path to the directory you want to open.

**Examples:**

* Open the current directory in the current window.
    ```
    edit .
    ```

* Open the parent directory of current buffer in the vertical split window.
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
