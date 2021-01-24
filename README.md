# 🛰 voyager.vim

Minimal file exploror.

## Under construction

As of now: 

* Vim only
* Unix only


## Getting started

Add the following lines to your vimrc in order to disable a conflicting plugin bundled in Vim.
```vim
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
```

To open a voyager buffer, i.e. file explorer, run a command that starts editing files with the path to a directory you would like to open.

**Examples:**

* Open in the current window.
    ```vim
    edit {directory}
    ```

* Open in the vertically splited window.
    ```vim
    vsplit {directory}
    ```

## Special thanks

Inspired by:

* **[mattn/vim-molder](https://github.com/mattn/vim-molder)**
* [cocopon/vaffle.vim](https://github.com/cocopon/vaffle.vim)
* [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)

Thank you to the developers!


## License

MIT License.
