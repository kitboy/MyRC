" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" {{{1 system config

filetype off
call pathogen#infect()
call pathogen#helptags()

" mapc				" clear all mapping

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set dir=~/temp  " swap file dir
set backup		" keep a backup file
set backupext=.bak
set backupdir=~/temp
set undofile
set undoreload=10000
set undodir=~/temp/undo/
" set patchmode=.orig

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" {{{2 filetype
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on


  " autoload omni-complete plugin
  "set ofu=syntaxcomplete#Complete
  set completeopt=longest,menu
  autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
  autocmd Filetype java setlocal omnifunc=javacomplete#Complete

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
" }}}2

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set diffopt+=vertical

" }}}1


" install plugin.vim to ~/.vim/plugin and plugin.txt(help) to ~/.vim/doc
" then run :helptags ~/.vim/doc to install help
" when pathogen has been installed(put pathogen.vim in ~/.vim/autoload)
" other plugin can be placed into seperate folder in ~/.vim/bundle/

" {{{1 custom plugins

" {{{2 nerd tree
nnoremap <F2> <Esc>:NERDTreeToggle<CR>
"       // let loaded_nerd_tree=1    // 禁用所有与NERD_tree有关的命令
"       nmap <silent> <leader>tto :NERDTreeToggle<cr>
"       let NERDTreeIgnore=['/.vim$', '/~$']    // 不显示指定的类型的文件
"       let NERDTreeShowHidden=0    // 不显示隐藏文件(好像只在linux环境中有效)
"       let NERDTreeSortOrder=['//$','/.cpp$','/.c$', '/.h$', '*']    // 排序
"       let NERDTreeCaseSensitiveSort=0     // 不分大小写排序
"       let NERDTreeWinSize=30
"       // let NERDTreeShowLineNumbers=1
"       let NERDTreeShowBookmarks=1
"       let NERDTreeQuitOnOpen=1    // 打开文件后, 关闭NERDTrre窗口
"       // let NERDTreeHighlightCursorline=1     // 高亮NERDTrre窗口的当前行
"       // nmap <silent> <leader>tmk :Bookmark expand(/"<cword>/")<cr>
" }}}2


" {{{2 taglist plugin
nnoremap <F3> <Esc>:TlistToggle<CR>
let Tlist_Ctags_Cmd='/usr/bin/ctags'   " 若在windows中应写成: let Tlist_Ctags_Cmd='ctags.exe'
let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=18
let Tlist_Use_Horiz_Window=0
" }}}2

" {{{2 nerd comment plugin
" let NERD_java_alt_style=1
" Default mapping: [count],cc   " 以行为单位进行注释.
" ,c<space>     " comment <--> uncomment.
" ,cm           " 以段作为单位进行注释.
" ,cs           " 简洁美观式注释.
" ,cy           " Same as ,cc except that the commented line(s) are yanked first.
" ,c$            " 注释当前光标到行未的内容.
" ,cA           " 在行尾进行手动输入注释内容.
" ,ca           " 切换注释方式(/**/ <--> //).
" ,cl           " Same cc, 并且左对齐.
" ,cb           " Same cc, 并且两端对齐.
" ,cu           " Uncomments the selected line(s)
" }}}2

" {{{2 latex-suite
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
if has("win32")
    set shellslash
endif
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" }}}2

" {{{2 cscope plugin to extend ctags
if has("cscope")
	set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
	" check cscope for definition of a symbol before checking ctags:
	" set to 1 if you want the reverse search order.
	set csto=1

	" add any cscope database in current directory
	" let g:csdb = g:workdir . "/cscope.out"
	if filereadable("cscope.out")
		" exe "cs add " . g:csdb
		cs add cscope.out
		" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif

	" show msg when any other cscope db added
	set cscopeverbose

	nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
" }}}2

" {{{2 minibufexpl plugin
" let g:miniBufExplSplitToEdge = 0
" let g:miniBufExplSplitBelow = 0
" let g:miniBufExplMapWindowNavVim = 1 
" let g:miniBufExplMapWindowNavArrows = 1 
" let g:miniBufExplMapCTabSwitchBufs = 1 
" let g:miniBufExplModSelTarget = 1 
" let g:miniBufExplForceSyntaxEnable = 1
" }}}2

" {{{2 super tab behave
    let g:SuperTabDefaultCompletionType = "context"
    " let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    let g:SuperTabContextDefaultCompletionType = "<c-p>"
    let g:SuperTabRetainCompletionDuration = 'insert'
" }}}2
" }}}1


" {{{1 my setting
" <Leader> is \ by default
let mapleader = ","
nnoremap <leader>zz <Esc>:wqa!<CR>
colorscheme evening
" {{{2 vimrc setting
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
" }}}2

" {{{2 project setting
" " auto sv and ld session
" au VimEnter * source ~/.vim/project.vim
" au VimLeave * mks! ~/.vim/project.vim
" au FocusLost * : wa		" when lost focus, always save all
set tags=tags;				" 分号不可少，从当前目录向上找tags
" set autochdir               " auto change pwd to current file
" create new workspace in current dir (create tags and cscope,too)
" nnoremap <silent> <Leader>nn <Esc>:mks! workspace.vim<CR>:let g:workspace=v:this_session<CR>:let g:workdir=getcwd()<CR>:!find . -name "*.c" -o -name "*.h" -o -name "*.cc" -o -name "*.java" > cscope.files<CR>:!cscope -bkq -i cscope.files<CR>:!ctags -R<CR>
nnoremap <silent> <Leader>nn <Esc>:mks! workspace.vim<CR>:!find . -name "*.c" -o -name "*.h" -o -name "*.cc" -o -name "*.java" > cscope.files<CR>:!cscope -bkq -i cscope.files<CR>:!ctags -R<CR>
" load workspace in current dir if exist
if filereadable("workspace.vim")
	" let g:workdir=getcwd()
	" let g:workspace=v:this_session
    source workspace.vim
endif
" save current workspace
" nnoremap <silent> <Leader>ww <Esc>:exe "mks! " . g:workspace<CR> 
nnoremap <silent> <Leader>ww <Esc>:mks! workspace.vim<CR>
" }}}2

" open binary file
" nnoremap <F7> <Esc>:%!xxd<CR>
" nnoremap <F8> <Esc>:%!xxd -r<CR>
" goto and back from tags
nnoremap <CR> <C-]>
nnoremap <S-t> <C-t>
" tab and window key resign
" autocmd BufWinEnter * tab sunhide | call SwitchToBuf(expand("<amatch>"))     " auto open new buffer in new tab
" autocmd BufWinLeave * bdelete expand("<amatch>")
" au BufAdd,BufNewFile,BufRead * nested tab sball
nnoremap <C-Tab> <Tab>                  " move to n-newer pos, .vs. C-O move to n-older pos
nnoremap <Tab> :tabn<CR>                " move to next tab
nnoremap <S-TAB> :tabp<CR>
nnoremap <UP> <C-w>k					" move to window
nnoremap <DOWN> <C-w>j
nnoremap <LEFT> <C-w>h
nnoremap <RIGHT> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set splitbelow
set splitright
" au VimResized * exe "normal! \<c-w>="	" Resize splits when the window is resized
" close window or tab
nnoremap <C-c> :q<CR>
nnoremap <C-v> :w<CR>
nnoremap <C-n> :tabe<CR>
" set tab size
set shiftwidth=4			" 
set softtabstop=4           " 
set tabstop=4               " 
set smartindent				" 
set expandtab
" set show window style
set guifont=Monospace\ 12
set laststatus=2
set cmdheight=1
set showtabline=2
set showmode
set showcmd
set ruler
set number
set cursorline
set statusline=\ %<%F[%1*%M%*%n%R%H]%=0x%B\ %y\ %0(%{&fileformat}\ %{&fileencoding}\ %c:%l/%L%)\ %P
" set search style
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
set matchpairs+=<:>
set showmatch
nnoremap <silent> <leader><space> :nohl<CR>
" keep 50 lines of command line history
set history=500
" st command line auto-completion
set wildmenu
set wildmode=full
set wildignore=*.bak,*.o,*.e,*~
" move line in screen instead of file line 
nnoremap j gj
nnoremap k gk
" use ' instead of ` and use ` to change buffer, use ; instead of :
noremap ' `
noremap ` <C-^>
" noremap ; :
" fold setting
set foldenable
set foldmethod=syntax
set foldcolumn=0
nnoremap <leader>fm <Esc>:set foldmethod=marker<CR>
nnoremap <leader>fs <Esc>:set foldmethod=syntax<CR>
nnoremap <leader>fi <Esc>:set foldmethod=indent<CR>
nnoremap <leader>fd <Esc>:set foldmethod=diff<CR>
nnoremap <leader>fn <Esc>:set foldmethod=manual<CR>
nnoremap <space> za		" 用空格键来开关折叠
" 配置多语言环境
if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=ucs-bom,utf-8,gbk
	set fenc=utf-8

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    set langmenu=zh_CN.utf-8                 "设置菜单语言
    source $VIMRUNTIME/delmenu.vim           "导入删除菜单脚本，删除乱码的菜单
    source $VIMRUNTIME/menu.vim              "导入正常的菜单脚本
    language messages zh_CN.utf-8            "设置提示信息语言

else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


inoreab #p #!/usr/bin/python3 
inoreab #i #include
cnoreab p3 !python3 % 
cnoreab pdb !pdb %

" }}}1

"" python debug
"python << EOF
"import time
"import vim
"def SetBreakpoint():
"    import re
"    nLine = int( vim.eval( 'line(".")'))
"    strLine = vim.current.line
"    strWhite = re.search( '^(\s*)', strLine).group(1)
"    vim.current.buffer.append( "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" % {'space':strWhite, 'mark': '#' * 30}, nLine - 1)
"    for strLine in vim.current.buffer:
"        if strLine == "import pdb":
"            break
"    else:
"        vim.current.buffer.append( 'import pdb', 0)
"        vim.command( 'normal j1')
"def RemoveBreakpoints():
"    import re
"    nCurrentLine = int( vim.eval( 'line(".")'))
"    nLines = []
"    nLine = 1
"    for strLine in vim.current.buffer:
"        if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
"            nLines.append(nLine)
"        nLine += 1
"    nLines.reverse()
"    for nLine in nLines:
"        vim.command( 'normal %dG' % nLine)
"        vim.command( 'normal dd')
"        if nLine < nCurrentLine:
"            nCurrentLine -= 1
"    vim.command( 'normal %dG' % nCurrentLine)
"def RunDebugger():
"    vim.command('wall')
"    strFile = vim.eval( "g:mainfile")
"    vim.command( "!start python -m pdb %s" % strFile)
"vim.command( 'map <F6> :py SetBreakpoint()<cr>')
"vim.command( 'map <F7> :py RemoveBreakpoints()<cr>')
"# vim.command( 'map <F5> :py RunDebugger()<cr>')
"vim.command('map <F5> :!python -m pdb %<CR>')
"EOF


" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END
