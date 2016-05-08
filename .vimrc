" Will tell Vim not to behave like old-school Vi. This makes Vim more useful.
set nocompatible

" Enable line numbering
set number

" Syntax highlighting
syntax on

" Turn off word wrapping
set wrap!

" Smart indent works with more intelligence than autoindent. It tries to recognize code and will indent when it deems appropriate.
set smartindent

" Turns tabs into whitespace 
set expandtab

" Controls the number of space characters that will be inserted when the tab key is pressed
set tabstop=4

" Changes the number of space characters inserted for indentation
set shiftwidth=4

" Highlights the matching [braces|brackets|parens] when the cursor is on a bracket.
set showmatch

" Turns on the ruler (status info) at the bottom of the screen.
set ruler

" Highlights all matches in text when you search
set hlsearch

" Always display status line
set laststatus=2

" Informative status line
"set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" Turn autobackup off
set nobackup
set nowb
set noswapfile

" Fix for backspace not working correctly in INSERT mode 
set backspace=2

" Enable visual bell instead of audible bell
"set visualbell 

" Allows moving to previous line after reaching first/last character in a line with cursor keys
set whichwrap=<,>,h,l,[,]

" set list
"set listchars=tab:»-,trail:•,eol:¶,nbsp:⎵,space:⎵,precedes:«,extends:» sbr=↪
set listchars=tab:»-,trail:•,eol:¶,nbsp:⎵,precedes:«,extends:» sbr=↪

" Enable Syntax highlighting for .vcl
autocmd BufNewFile,BufRead *.vcl set syntax=C
