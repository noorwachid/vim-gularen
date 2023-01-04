vim9script

# Vim syntax file
# Language:     Gularen
# Author:       Noor Wachid <noorwach@yahoo.com>
# URL:          https://github.com/noorwachid/gularen/
# Licence:      MIT
# Remarks:      Vim 9

if exists("b:current_syntax")
  finish
endif

# NOTE: This is from modification of markdown and asciidoc file
# TODO: Remove redundant code 
# TODO: Implement link specification

syn sync minlines=50
syn sync linebreaks=1
syn case ignore

syn match gularenValid '[<>]\c[a-z/$!]\@!' transparent contains=NONE
syn match gularenValid '&\%(#\=\w*;\)\@!' transparent contains=NONE

syn match gularenLineStart "^[<@]\@!" nextgroup=@gularenBlock,htmlSpecialChar

syn cluster gularenBlock  contains=gularenDocument,gularenPart,gularenChapter,gularenSection,gularenSubsection,gularenSubsubsection,gularenSegment,gularenBlockquote,gularenListMarker,gularenTaskListMarker,gularenOrderedListMarker,gularenCodeBlock,gularenRule
syn cluster gularenInline contains=gularenLineBreak,gularenLinkText,gularenItalic,gularenBold,gularenCode,gularenEscape,@htmlTop,gularenError,gularenValid

syn keyword gularenTodo contained TODO FIXME NOTE
syn match gularenComment "#.*$" contains=gularenTodo

syn region gularenDocument      matchgroup=gularenDocumentDelimiter      start=" \{,}>>>\s"   end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenPart          matchgroup=gularenPartDelimiter          start=" \{,}>>\s"    end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenChapter       matchgroup=gularenChapterDelimiter       start=" \{,}>>>->\s" end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenSection       matchgroup=gularenSectionDelimiter       start=" \{,}>>->\s"  end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenSubsection    matchgroup=gularenSubsectionDelimiter    start=" \{,}>->\s"   end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenSubsubsection matchgroup=gularenSubsubsectionDelimiter start=" \{,}->\s"    end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained
syn region gularenSegment       matchgroup=gularenSegmentDelimiter       start=" \{,}>\s"     end="#*\s*$" keepend oneline contains=@gularenInline,gularenAutomaticLink contained

syn match gularenBlockquote "/\%(\s\|$\)" contained nextgroup=@gularenBlock

syn region gularenCodeBlock start="^\n\( \{4,}\|\t\)" end="^\ze \{,3}\S.*$" keepend

syn match gularenListMarker "\%(\t\| \{0,4\}\)\*\%(\s\+\S\)\@=" contained
syn match gularenOrderedListMarker "\%(\t\| \{0,4}\)\<\d\+\.\%(\s\+\S\)\@=" contained
syn match gularenOrderedListMarker "\%(\t\| \{0,4}\)\.\.\%(\s\+\S\)\@=" contained
syn match gularenTaskListMarkerDone contained "v"
syn match gularenTaskListMarkerCanceled contained "x"
syn match gularenTaskListMarker "\%(\t\| \{0,4\}\)\[\( \|v\|x\)\]\%(\s\+\S\)\@=" contains=gularenTaskListMarkerDone,gularenTaskListMarkerCanceled

syn match gularenRule "\* *\* *\*[ *]*$" contained
syn match gularenRule "- *- *-[ -]*$" contained

syn match gularenLineBreak " \{2,\}$"

syn region gularenIdDeclaration matchgroup=gularenLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=gularenUrl skipwhite
syn match gularenUrl "\S\+"     nextgroup=gularenUrlTitle skipwhite contained
syn region gularenUrl           matchgroup=gularenUrlDelimiter start="<" end=">" oneline keepend nextgroup=gularenUrlTitle skipwhite contained
syn region gularenUrlTitle      matchgroup=gularenUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region gularenUrlTitle      matchgroup=gularenUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region gularenUrlTitle      matchgroup=gularenUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region gularenLinkText      matchgroup=gularenLinkTextDelimiter start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=gularenLink,gularenId skipwhite contains=@gularenInline,gularenLineStart
syn region gularenLink          matchgroup=gularenLinkDelimiter start="(" end=")" contains=gularenUrl keepend contained
syn region gularenId            matchgroup=gularenIdDelimiter start="\[" end="\]" keepend contained
syn region gularenAutomaticLink matchgroup=gularenUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

var concealends = ''

if has('conceal')
  concealends = ' concealends'
endif

exe 'syn region gularenBold   matchgroup=gularenBoldDelimiter   start="\*\S\@="        end="\S\@<=\*\|^$"       skip="\\\*" contains=gularenLineStart,@Spell' .. concealends
exe 'syn region gularenItalic matchgroup=gularenItalicDelimiter start="\w\@<!_\S\@="   end="\S\@<=_\w\@!\|^$"   skip="\\_"  contains=gularenLineStart,@Spell' .. concealends

syn region gularenCode matchgroup=gularenCodeDelimiter start="`" end="`" keepend contains=gularenLineStart

syn match gularenFootnote           "\^\[[^\]]\+\]"
syn match gularenFootnoteDefinition "^=\[[^\]]\+\]"
syn match gularenAdmonition         "^<!> \<\u\+\>"

syn match gularenEscape "\\[][\\`*_{}()<>#+.!-]"
syn match gularenError  "\w\@<=_\w\@="

hi def link gularenTodo                   Todo
hi def link gularenComment                Comment

hi def link gularenDocument               htmlH6
hi def link gularenPart                   htmlH6
hi def link gularenChapter                htmlH1
hi def link gularenSection                htmlH2
hi def link gularenSubsection             htmlH3
hi def link gularenSubsubsection          htmlH4
hi def link gularenSegment                htmlH5
hi def link gularenDocumentDelimiter      gularenHeadingDelimiter
hi def link gularenPartDelimiter          gularenHeadingDelimiter
hi def link gularenChapterDelimiter       gularenHeadingDelimiter
hi def link gularenSectionDelimiter       gularenHeadingDelimiter
hi def link gularenSubsectionDelimiter    gularenHeadingDelimiter
hi def link gularenSubsubsectionDelimiter gularenHeadingDelimiter
hi def link gularenSegmentDelimiter       gularenHeadingDelimiter
hi def link gularenHeadingDelimiter       markdownHeadingDelimiter
hi def link gularenOrderedListMarker      gularenListMarker
hi def link gularenListMarker             htmlTagName
hi def link gularenTaskListMarker         Braces
hi def      gularenTaskListMarkerDone     ctermfg=green
hi def      gularenTaskListMarkerCanceled ctermfg=red

hi def link gularenBlockquote             Comment
hi def link gularenRule                   PreProc

hi def link gularenFootnote               Typedef
hi def link gularenFootnoteDefinition     Typedef
hi def link gularenAdmonition             Typedef

hi def link gularenLinkText               htmlLink
hi def link gularenIdDeclaration          Typedef
hi def link gularenId                     Type
hi def link gularenAutomaticLink          gularenUrl
hi def link gularenUrl                    Float
hi def link gularenUrlTitle               String
hi def link gularenIdDelimiter            gularenLinkDelimiter
hi def link gularenUrlDelimiter           htmlTag
hi def link gularenUrlTitleDelimiter      Delimiter

hi def link gularenItalicDelimiter        htmlItalic
hi def link gularenItalic                 htmlItalic
hi def link gularenBoldDelimiter          htmlBold
hi def link gularenBold                   htmlBold
hi def link gularenCodeDelimiter          Delimiter
hi def link gularenCode                   markdownCode
hi def link gularenCodeBlock              markdownCodeBlock

hi def link gularenEscape                 Special
hi def link gularenError                  Error

b:current_syntax = "gularen"

# vim:set sw=2:
