set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let colors_name="operator"

hi Cursor       ctermfg=0    ctermbg=7
hi CursorIM     ctermfg=0    ctermbg=7
hi EndOfBuffer  ctermfg=0    ctermbg=0
hi Error        ctermfg=1    ctermbg=NONE
hi ErrorMsg     ctermfg=1    ctermbg=NONE
hi Folded       ctermfg=6    ctermbg=8
hi IncSearch    ctermfg=1    ctermbg=NONE
hi MatchParen   ctermfg=1    ctermbg=NONE cterm=underline
hi ModeMsg      ctermfg=6    ctermbg=NONE
hi MoreMsg      ctermfg=6    ctermbg=NONE
hi Pmenu        ctermfg=5    ctermbg=8
hi PmenuSBar    ctermfg=NONE ctermbg=8
hi PmenuSel     ctermfg=8    ctermbg=3
hi PmenuThumb   ctermfg=NONE ctermbg=8
hi Question     ctermfg=NONE ctermbg=NONE
hi QuickFixLine ctermfg=7    ctermbg=6
hi Search       ctermfg=1    ctermbg=NONE
hi SpecialKey   ctermfg=NONE ctermbg=NONE cterm=underline
hi StatusLine   ctermfg=NONE ctermbg=8    cterm=bold
hi StatusLineNC ctermfg=NONE ctermbg=2    cterm=bold
hi TabLine      ctermfg=6    ctermbg=NONE cterm=NONE
hi TabLineFill  ctermfg=0    ctermbg=NONE
hi TabLineSel   ctermfg=0    ctermbg=6    cterm=NONE
hi Todo         ctermfg=6    ctermbg=NONE cterm=underline
hi VertSplit    ctermfg=8    ctermbg=8    cterm=NONE
hi Visual       ctermfg=0    ctermbg=7
hi WarningMsg   ctermfg=5    ctermbg=8
hi WildMenu     ctermfg=7    ctermbg=6

hi Comment    ctermfg=3    ctermbg=NONE cterm=italic
hi Delimiter  ctermfg=NONE ctermbg=NONE cterm=NONE
hi Directory  ctermfg=NONE ctermbg=NONE cterm=NONE
hi Operator   ctermfg=NONE ctermbg=NONE cterm=NONE
hi PreProc    ctermfg=NONE ctermbg=NONE cterm=NONE
hi Type       ctermfg=NONE ctermbg=NONE cterm=NONE
hi Keyword    ctermfg=NONE ctermbg=NONE cterm=NONE
hi Function   ctermfg=NONE ctermbg=NONE cterm=NONE
hi String     ctermfg=NONE ctermbg=NONE cterm=NONE
hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
hi Statement  ctermfg=NONE ctermbg=NONE cterm=NONE
hi Constant   ctermfg=NONE ctermbg=NONE cterm=NONE
hi Number     ctermfg=NONE ctermbg=NONE cterm=NONE
hi Boolean    ctermfg=NONE ctermbg=NONE cterm=NONE
hi Special    ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
