" Vim syntax file
" Language:     Gularen
" Author:       Noor Wachid
" URL:          https://github.com/noorwachid/vim-gularen/

if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim

" Inlines
syn match gularenComment "\~.*$" 

syn region gularenFSBold      start="\*" end="\*"
syn region gularenFSItalic    start="_" end="_"
syn region gularenFSMonospace start="`" end="`"

syn match gularenNumber "-*\d\+"
syn match gularenNumber "-*\d\+\.\d\+"

syn match gularenBreak "<\{1,2}"

syn match gularenSymbol "[a-z0-9-]" contained
syn match gularenResourceValue "\v(\[)@<=[^\]]+(\])@=" contained
syn match gularenResourceLabel "\v(\()@<=[^\)]+(\))@=" contained
syn match gularenResource "[!?]\?\[[^\]]\+\]\(([^)]\+)\)\?" contains=gularenResourceValue,gularenResourceLabel
syn match gularenFootnoteJumpMarker "\^\[[a-z0-9-]\+\]" contains=gularenSymbol
syn match gularenFootnoteDescribeMarker "^\t*=\[[a-z0-9-]\+\]" contains=gularenSymbol

syn cluster gularenInline contains=gularenComment,gularenFSBold,gularenFSItalic,gularenFSMonospace,gularenNumber,gularenBreak

" Blocks
syn match gularenChapter    "^\t*>>>.*$"    contains=@gularenInline
syn match gularenSection    "^\t*>>[^>].*$" contains=@gularenInline
syn match gularenSubsection "^\t*>[^>].*$"  contains=@gularenInline

syn match gularenListMarker "^\t*-[^-]"  contains=@gularenInline
syn match gularenListMarker "^\t*\d\+\." contains=@gularenInline

syn match gularenCheckListMarkerDone      contained "v"
syn match gularenCheckListMarkerCancelled contained "x"

syn match gularenCheckListMarker "^\t*\[[vx ]\]" contains=@gularenInline,gularenCheckListMarkerDone,gularenCheckListMarkerCancelled

syn match gularenCodeMarker "^\t*-\{3,} [a-z-]\+$" contained
syn match gularenCodeMarker "^\t*-\{3,}$"          contained
syn region gularenCode start="^\t*\z(-\{3,}\).*$" end="^\s*\z1\ze\s*$" keepend contains=gularenCodeMarker

syn match gularenPipe "|" contained
syn match gularenPipeConnector "---\+" contained
syn match gularenPipeConnector "--\+:" contained
syn match gularenPipeConnector ":-\+:" contained
syn match gularenPipeConnector ":--\+" contained
syn match gularenTable "^\t*|.*|$" contains=@gularenInline,gularenPipe,gularenPipeConnector

" Linkages
hi def link gularenNumber Number

hi def link gularenComment Comment

hi def link gularenChapter    htmlH1
hi def link gularenSection    htmlH2
hi def link gularenSubsection htmlH3

hi def link gularenBreak DiffRemoved

hi def link gularenListMarker Keyword
hi def link gularenCheckListMarker Delimiter
hi def link gularenCheckListMarkerDone DiffAdded
hi def link gularenCheckListMarkerCancelled DiffRemoved

hi def link gularenPipe Delimiter
hi def link gularenPipeConnector Delimiter

hi def link gularenFSBold      htmlBold
hi def link gularenFSItalic    htmlItalic
hi def link gularenFSMonospace String

hi def link gularenCode       String
hi def link gularenCodeMarker Delimiter

hi def link gularenSymbol                 Constant
hi def link gularenResource               Delimiter
hi def link gularenResourceValue          Underlined
hi def link gularenResourceLabel          String
hi def link gularenFootnoteJumpMarker     Delimiter
hi def link gularenFootnoteDescribeMarker Delimiter

let b:current_syntax = "gularen"
