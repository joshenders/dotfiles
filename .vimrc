" Will tell Vim not to behave like old-school Vi. This makes Vim more useful.
set nocompatible

" Syntax highlighting
syntax on

" Enable line numbers
"set number

" Turn off word wrapping
set wrap!

" Smart indent works with more intelligence than autoindent. It tries to recognize code and will indent when it deems appropriate.
set smartindent

" Turns tabs into whitespace 
set expandtab

" Controls the number of space characters that will be inserted when the tab key is pressed
set tabstop=2

" Changes the number of space characters inserted for indentation
set shiftwidth=2

" Highlights the matching [braces|brackets|parens] when the cursor is on a bracket.
set showmatch

" Turns on the ruler (status info) at the bottom of the screen.
set ruler

" Highlights all matches in text when you search
set hlsearch

" Informative status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" Turn autobackup off
set nobackup
set nowb
set noswapfile

" Fix for backspace not working correctly in INSERT mode 
set backspace=2

" Allows moving to previous line after reaching first/last character in a line with cursor keys
set whichwrap=<,>,h,l,[,]
