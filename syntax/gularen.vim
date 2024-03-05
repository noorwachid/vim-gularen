" Vim syntax file
" Language:     Gularen
" Author:       Noor Wachid
" URL:          https://github.com/noorwachid/vim-gularen/

if exists("b:current_syntax")
	finish
endif

if !exists('g:gularen_minline')
	let g:gularen_minline = 50
endif

execute 'syn sync minlines=' . g:gularen_minline

runtime! syntax/html.vim
unlet! b:current_syntax

" Inlines
syn match gularenComment "\~.*$" 

syn region gularenFSBold      start="\*" end="\*"
syn region gularenFSItalic    start="_" end="_"
syn region gularenFSMonospace start="`" end="`"

syn match gularenNumber "-*\d\+"
syn match gularenNumber "-*\d\+\.\d\+"

syn match gularenAdmonNote      "^\t*<Note> "      containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmonHint      "^\t*<Hint> "      containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmonImportant "^\t*<Important> " containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmonWarning   "^\t*<Warning> "   containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmonSeeAlso   "^\t*<See also> "  containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmonTip       "^\t*<Tip> "       containedin=ALLBUT,gularenComment,gularenCode
syn match gularenAdmon          "^\t*<[^>]\+> "    containedin=ALLBUT,gularenComment,gularenCode

syn match gularenDateTime  "<[0-9-: ]\+>"  containedin=ALLBUT,gularenComment,gularenCode

syn match gularenBreak "<\{2,3}"
syn match gularenBreak "^\s*\*\*\*$"

syn match gularenSymbol "[a-z0-9-]"                            contained
syn match gularenResourceValue "\v(\[)@<=[^\]]+(\])@="         contained
syn match gularenResourceLabel "\v(\()@<=[^\)]+(\))@="         contained
syn match gularenResource "[!?]\?\[[^\]]\+\]\(([^)]\+)\)\?"    contains=gularenResourceValue,gularenResourceLabel
syn match gularenFootnoteJumpMarker "\^\[[a-z0-9-]\+\]"        contains=gularenSymbol
syn match gularenFootnoteDescribeMarker "^\t*=\[[a-z0-9-]\+\]" contains=gularenSymbol

syn match gularenInlineCodeValue "\v(\{)@<=[^\}]+(\})@=" contained
syn match gularenInlineCodeLabel "\v(\()@<=[^\)]+(\))@=" contained
syn match gularenInlineCode "{[^\]]\+}\(([^)]\+)\)\?"    contains=gularenInlineCodeLabel,gularenInlineCodeValue

syn cluster gularenInline contains=gularenComment,gularenFSBold,gularenFSItalic,gularenFSMonospace,gularenNumber,gularenBreak,gularenResource,gularenFootnoteJumpMarker

" Blocks
syn match gularenSubtitle   "^\t*> [^>].*$"  contained
syn match gularenChapter    "^\t*>>> .*$"    contains=@gularenInline skipnl nextgroup=gularenSubtitle
syn match gularenSection    "^\t*>> [^>].*$" contains=@gularenInline skipnl nextgroup=gularenSubtitle
syn match gularenSubsection "^\t*> [^>].*$"  contains=@gularenInline skipnl nextgroup=gularenSubtitle

syn match gularenListMarker "\v(^\t*(\d+\.|-) )"
syn match gularenList "\v(^\t*(\d+\.|-) )@<=.*$" contains=@gularenInline

syn match gularenCheckListMarkerDone      "v" contained containedin=gularenCheckListMarker
syn match gularenCheckListMarkerCancelled "x" contained containedin=gularenCheckListMarker

syn match gularenCheckListMarker "\v(^\t*\[[vx ]\] )"
syn match gularenCheckList "\v(^\t*\[[vx ]\] )@<=.*$" contains=@gularenInline

syn match gularenCodeMarker "^\t*-\{3,} [a-z0-9-]\+$" contained containedin=@gularen_codeblock_yaml " higher precedence because --- is valid yaml syntax
syn match gularenCodeMarker "^\t*-\{3,}$"             contained containedin=@gularen_codeblock_yaml
syn region gularenCode start="^\t*\z(-\{3,}\)$" end="^\t*\z1$"             keepend contains=gularenCodeMarker
syn region gularenCode start="^\t*\z(-\{3,}\) [a-z0-9-]\+$" end="^\t*\z1$" keepend contains=gularenCodeMarker

syn match gularenPipe "|"              contained
syn match gularenPipeConnector "-\+"   contained
syn match gularenPipeConnector "-\+:"  contained
syn match gularenPipeConnector ":-\+:" contained
syn match gularenPipeConnector ":-\+"  contained
syn match gularenTable "^\t*|.*|$"    contains=@gularenInline,gularenPipe,gularenPipeConnector
syn match gularenTable "^\t*|-\+|$"   contains=@gularenInline,gularenPipe,gularenPipeConnector
syn match gularenTable "^\t*|-\+:|$"  contains=@gularenInline,gularenPipe,gularenPipeConnector
syn match gularenTable "^\t*|:-\+:|$" contains=@gularenInline,gularenPipe,gularenPipeConnector
syn match gularenTable "^\t*|:-\+|$"  contains=@gularenInline,gularenPipe,gularenPipeConnector

" Code blocks
" Credit to TPope
if !exists('g:gularen_codeblocks')
	let g:gularen_codeblocks = []
endif
let s:syntax_loaded = {}
for s:lang in map(copy(g:gularen_codeblocks),'matchstr(v:val,"[^=][a-z0-9-]*$")')
	if has_key(s:syntax_loaded, s:lang)
		continue
	endif

	syn case match
	exe 'syn include @gularen_codeblock_'.tr(s:lang,'-','_').' syntax/'.s:lang.'.vim'
	unlet! b:current_syntax
	let s:syntax_loaded[s:lang] = 1
endfor

let s:syntax_linked = {}
for s:lang in g:gularen_codeblocks
	if has_key(s:syntax_linked, s:lang)
		continue
	endif

	let s:otype = matchstr(s:lang, "^[a-z0-9-]*[^=]")
	let s:utype = matchstr(s:lang, "[^=][a-z0-9-]*$")

	exe 'syn region gularen_codeblock_'.tr(s:utype,'-','_').' start="^\t*\z(-\{3,}\) '.s:otype.'$" end="^\t*\z1$" keepend contains=gularenCodeMarker,@gularen_codeblock_'.tr(s:utype,'-','_')
	let s:syntax_linked[s:lang] = 1
endfor


" Linkages
hi def link gularenNumber Number

hi def link gularenComment Comment

hi def link gularenChapter    htmlH1
hi def link gularenSection    htmlH2
hi def link gularenSubsection htmlH3
hi def link gularenSubtitle   Delimiter

hi def link gularenBreak DiffRemoved

hi def link gularenListMarker               Keyword
hi def link gularenCheckListMarker          Delimiter
hi def link gularenCheckListMarkerDone      DiffAdded
hi def link gularenCheckListMarkerCancelled DiffRemoved

hi def link gularenPipe          Delimiter
hi def link gularenPipeConnector Delimiter

hi def link gularenFSBold      htmlBold
hi def link gularenFSItalic    htmlItalic
hi def link gularenFSMonospace String

hi def link gularenCode       String
hi def link gularenCodeMarker Delimiter

hi def link gularenInlineCodeValue String
hi def link gularenInlineCodeLabel String

hi def link gularenSymbol                 Constant
hi def link gularenResource               Delimiter
hi def link gularenResourceValue          Underlined
hi def link gularenResourceLabel          String
hi def link gularenFootnoteJumpMarker     Delimiter
hi def link gularenFootnoteDescribeMarker Delimiter

hi def link gularenAdmon          DiagnosticHint
hi def link gularenAdmonHint      DiagnosticHint
hi def link gularenAdmonImportant DiagnosticError
hi def link gularenAdmonWarning   DiagnosticWarn
hi def link gularenAdmonNote      htmlH1
hi def link gularenAdmonTip       htmlH2
hi def link gularenAdmonSeeAlso   htmlH3

hi def link gularenDateTime   DiagnosticWarn

let b:current_syntax = "gularen"
