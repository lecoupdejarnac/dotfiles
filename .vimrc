version 7.0
set nocompatible
set cpo&vim
set backspace=indent,eol,start
set cmdheight=2
set history=50
set hlsearch
set incsearch
set mouse=a
set ruler
set cindent
set number
set background=dark
set isfname=@,48-57,/,.,-,_,+,,,#,$,%,[,],:,;,~
set tabstop=3
set shiftwidth=3
set expandtab "tabs converted to spaces
set autoindent
set nocindent
set nosmartindent
syn on

"automatically load changes to a file made in another editor (ie. VS)
set autoread

"set path=.,ref:,vms_include:,,
set path=.
set wildmenu
set ignorecase
set smartcase
set makeprg=makefds
set errorformat=%C\ %m,%A%p^,%C%%CXX-%t-%m,%Zat\ line\ number\ %l\ in\ file\ %f,%+GTEST\ is\ now\ UPTODATE\ for,%-G%.%#
set diffopt=filler,vertical,iwhite
" save local marks after exciting
set viminfo='100,f0
" don't show menu bars:
set guioptions-=m
set guioptions-=T
" don't show scrollbars
set guioptions+=LlRrb
set guioptions-=LlRrb


map! <S-Insert> <MiddleMouse>
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>
map Q gq
map <S-Insert> <MiddleMouse>
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>

noremap! <Home> ^
noremap <Home> ^
noremap! <S-Home> 0
noremap <S-Home> 0
inoremap <Home> <C-O>^
inoremap <S-Home> <C-O>0

colorscheme ncormier

" toggle commenting of current line
fun! CommentLine(comment)
  execute "normal $"
  let stopline = line(".") 
  let result = search('^'.a:comment, 'b', stopline)
  if (result != 0)
    let curline = getline(".")
    call setline(stopline, substitute(curline, '^'.a:comment, "", ""))
  else
    execute "normal 0i".a:comment
  endif
endfun

" show name of current function
fun! ShowFuncName() 
  let lnum = line(".") 
  let col = col(".") 
  echohl ModeMsg 
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW')) 
  echohl None 
endfun 

set winminheight=0
let g:maxxed = 0
let g:orig_width = 0
let g:orig_height = 0
" toggle window maximization
fun! MinMaxWindow()
  let orig_pos = getpos(".")
  if g:maxxed == 0
    let g:orig_width = winwidth(0)
    let g:orig_height = winheight(0)
    execute "normal \<C-W>_\<C-W>\<bar>"
    let g:maxxed = 1
  else
    "execute "normal \<C-W>=" 
    execute "normal ".g:orig_height."\<C-W>_" 
    execute "normal ".g:orig_width."\<C-W>\<bar>" 
    "set winwidth=g:orig_width
    "set winwidth=g:orig_height
    let g:maxxed = 0 
  endif
  call setpos('.', orig_pos)
endfun

fun! Num2S(num, len)
  let filler = "                                                            "
  let text = ''.a:num
  return strpart(filler, 1, a:len - strlen(text)).text
endfun

fun! FoldText()
  let sub = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=', '', 'g')
  let diff = v:foldend - v:foldstart + 1
  return  '+'.v:folddashes.'['.Num2S(diff,3).']'.sub
endfun

fun! VSscript(param)
  let cmd = '!"C:\\Documents and Settings\\ncormier\\devenvdden.pl" ' . a:param
  silent execute cmd
endfun

fun! Checkout(file)
   call VSscript('checkout ' . a:file)
   sleep 1
   execute ":e " . a:file
endfun

fun! Revert(file)
   call VSscript('revert ' . a:file)
endfun

fun! OpenOther()
   let file = expand('%')
   let len = strlen(file)
   let dot = strridx(file, '.')
   let ext = strpart(file, dot, len-1)
   if ext =~ '\.h'
      let new_ext = '.cpp'
   elseif ext =~ '\.cpp' || ext =~ '\.cxx' || ext =~ '\.c'
      let new_ext = '.h'
   else
      return
   endif
   let target = substitute(file, '\' . ext, new_ext, '')
   execute ':vs ' . target
   
endfun

fun! Fullscreen()
  set columns=999
  set lines=999
endfun

set foldtext=FoldText()

" toggle maximize on current window
noremap <F11> :call MinMaxWindow()<Return> 
" CTRL+t to open new tab (ala Firefox)
noremap <C-t> :tabnew<Return>
" CTRL+c to copy to global clipboard
noremap <C-c> "+y
" CTRL+p to paste from global clipboard
noremap <C-p> "+gP
" backslash to comment-out a line
noremap <Bslash> :call CommentLine()<Return> 
" space scrolls page down (like less)
noremap <Space> <PageDown>
" toggle highlighting of search text
noremap <C-h> :set invhls hls?<Return>
"show name of current function
noremap <F3> :call ShowFuncName()<Return>
"show hidden chars
noremap <Space> :set list!<Return>

"run IncrediBuild in VS
noremap <F7> :call VSscript('incredibuild')<Return>
"debug IncrediBuild project
noremap <F5> :call VSscript('incredidebug')<Return>
"send line # to visual studio
noremap <F6> :call VSscript('gotoline % '.line("."))<Return>
"checkout from perforce
noremap <F2> :call Checkout('%')<Return>
"revert from perforce
noremap <C-F2> :call Revert('%')<Return>
" make window fullscreen
noremap <F12> :call Fullscreen()<Return>
" open .h/.cpp from other in vertical split view
" noremap <M-h> :call OpenOther()<Return>
noremap <C-o> :call OpenOther()<Return>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" File type related autosetting
au FileType c,cpp setlocal shiftwidth=3 tabstop=3
au FileType python,perl,cfg setlocal shiftwidth=4 tabstop=4

" backslash to comment-out a line
au FileType c,cpp noremap <Bslash> :call CommentLine("//")<Return> 
au FileType python,perl,cfg,bash noremap <Bslash> :call CommentLine("#")<Return> 
