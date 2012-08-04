" ncormier's Vim color file

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ncormier"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal      guifg=Grey90       guibg=Black
highlight Search      guifg=Black        guibg=Red       gui=bold
highlight Visual      guifg=Grey25                       gui=bold
highlight Cursor      guifg=Black        guibg=Green     gui=bold

highlight Special     guifg=Orange 
highlight Comment     guifg=#80a0ff
highlight Todo        guifg=Black        guibg=Yellow    gui=bold
highlight StatusLine  guifg=blue         guibg=white

highlight Statement   guifg=Yellow                       gui=italic
highlight Conditional guifg=Yellow 
highlight Exception   guifg=#ffff99
highlight link Operator Conditional 

highlight Type        guifg=Green                        gui=NONE 
highlight link StorageClass Type
highlight link Structure Type
highlight link Typedef Type 

highlight LineNr      guifg=#777777                      gui=NONE

highlight PreProc     guifg=#990033
highlight PreCondit   guifg=Cyan3
highlight link Include PreProc
highlight Macro       guifg=#cc0033
highlight link Define Macro 
highlight IfDefIfOut  guifg=DarkGray

highlight Constant    guifg=#ff9933 
highlight link Character  Constant
highlight link Number     Constant
highlight link Boolean    Constant
highlight link Float      Constant
highlight String      guifg=#ff9933       guibg=#333333

" Console
highlight Normal      ctermfg=LightGrey  ctermbg=Black
highlight Search      ctermfg=Black      ctermbg=Red     cterm=NONE
highlight Visual                                         cterm=reverse
highlight Cursor      ctermfg=Black      ctermbg=Green   cterm=bold
highlight Special     ctermfg=Brown
highlight Comment     ctermfg=DarkGray
highlight StatusLine  ctermfg=blue       ctermbg=white
highlight Statement   ctermfg=Yellow                     cterm=NONE
highlight Type                                           cterm=NONE 
highlight LineNr      ctermfg=LightBlue  ctermbg=Grey    cterm=NONE
highlight Preproc     ctermfg=Red

