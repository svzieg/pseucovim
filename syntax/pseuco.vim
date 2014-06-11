" vim syntax File " Language: Pseuco
" Maintainer: Sven Ziegler <ziggo1879@gmail.com>
" URL: 
" Last Change: 2014-06-11


" Quit when a syntax file was already loaded
if !exists("main_syntax")
    if version < 600
        syntax clear
    elseif exists("b:current_syntax")
        finish
    endif 

    "we define it here so that included files can test for it
    let main_syntax='pseuco'
    syn region pseucoFold start="{" end="}" transparent fold
endif 
"
" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ PseucoHiLink hi link <args>
else
  command! -nargs=+ PseucoHiLink hi def link <args>
endif

" some characters that cannot be in a pseuco program (outside a string)
" TODO: Add some :D
"

" keyword definitions
syn keyword pseucoExternals         import 
syn keyword pseucoConditional       if else select
syn keyword pseucoLabel             default
syn keyword pseucoBoolean           true false
syn keyword pseucoConstant          null
syn keyword pseucoLoop              while for do
syn keyword pseucoType              boolean int string agent mutex void
syn keyword pseucoBranch            break continue 
syn keyword pseucoExpression        println
syn keyword pseucoPrimitiveStmt     join lock unlock waitForContition signal signalAll return
syn keyword pseucoAgent             mainagent

syn match pseucoChannel             "\<boolchan\>[0-9]*"
syn match pseucoChannel             "\<intchan\>[0-9]*"
syn match pseucoChannel             "\<stringchan\>[0-9]*"

syn region pseucoLabelRegion        transparent matchgroup=pseucoLabel start="\<case\>" matchgroup=NONE end=":" contains=pseucoNumber

syn cluster pseucoTop add=pseucoExternals,pseucoConditional,pseucoLabel,pseucoBranch,pseucoBoolean,pseucoType,pseucoLoop,pseucoExpression,pseucoPrimitiveStmt,pseucoAgent,pseicoChannel,pseucoLabelRegion

"Comments
syn keyword pseucoTodo		 contained TODO FIXME XXX
if exists("pseuco_comment_strings")
  syn region  pseucoCommentString    contained start=+"+ end=+"+ end=+$+ end=+\*/+me=s-1,he=s-1 contains=pseucoSpecial,pseucoCommentStar,pseucoSpecialChar,@Spell
  syn region  pseucoComment2String   contained start=+"+	end=+$\|"+  contains=pseucoSpecial,pseucoSpecialChar,@Spell
  syn match   pseucoCommentCharacter contained "'\\[^']\{1,6\}'" contains=pseucoSpecialChar
  syn match   pseucoCommentCharacter contained "'\\''" contains=pseucoSpecialChar
  syn match   pseucoCommentCharacter contained "'[^\\]'"
  syn cluster pseucoCommentSpecial add=pseucoCommentString,pseucoCommentCharacter,pseucoNumber
  syn cluster pseucoCommentSpecial2 add=pseucoComment2String,pseucoCommentCharacter,pseucoNumber
endif
syn region  pseucoComment		 start="/\*"  end="\*/" contains=@pseucoCommentSpecial,pseucoTodo,@Spell
syn match   pseucoCommentStar	 contained "^\s*\*[^/]"me=e-1
syn match   pseucoCommentStar	 contained "^\s*\*$"
syn match   pseucoLineComment	 "//.*" contains=@pseucoCommentSpecial2,pseucoTodo,@Spell
PseucoHiLink pseucoCommentString pseucoString
PseucoHiLink pseucoComment2String pseucoString
PseucoHiLink pseucoCommentCharacter pseucoCharacter
syn cluster pseucoTop add=pseucoComment,pseucoLineComment


"Documentation JAVA like
"
if !exists("pseuco_ignore_pseucodoc") && main_syntax != 'jsp'
  syntax case ignore
  syntax spell default

  syn region  pseucoDocComment	start="/\*\*"  end="\*/" keepend contains=pseucoCommentTitle,@pseucoHtml,pseucoDocTags,pseucoDocSeeTag,pseucoTodo,@Spell
  syn region  pseucoCommentTitle	contained matchgroup=pseucoDocComment start="/\*\*"   matchgroup=pseucoCommentTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1 contains=@pseucoHtml,pseucoCommentStar,pseucoTodo,@Spell,pseucoDocTags,pseucoDocSeeTag

  syn region pseucoDocTags	 contained start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}"
  syn match  pseucoDocTags	 contained "@\(param\|exception\|throws\|since\)\s\+\S\+" contains=pseucoDocParam
  syn match  pseucoDocParam	 contained "\s\S\+"
  syn match  pseucoDocTags	 contained "@\(version\|author\|return\|deprecated\|serial\|serialField\|serialData\)\>"
  syn region pseucoDocSeeTag	 contained matchgroup=pseucoDocTags start="@see\s\+" matchgroup=NONE end="\_."re=e-1 contains=pseucoDocSeeTagParam
  syn match  pseucoDocSeeTagParam  contained @"\_[^"]\+"\|<a\s\+\_.\{-}</a>\|\(\k\|\.\)*\(#\k\+\((\_[^)]\+)\)\=\)\=@ extend
  syntax case match
endif

" match the special comment /**/
syn match   pseucoComment		 "/\*\*/"


" Strings and constants
syn match   pseucoSpecialError	 contained "\\."
syn match   pseucoSpecialCharError contained "[^']"
syn match   pseucoSpecialChar	 contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region  pseucoString		start=+"+ end=+"+ end=+$+ contains=pseucoSpecialChar,pseucoSpecialError,@Spell
" next line disabled, it can cause a crash for a long line
"syn match   pseucoStringError	  +"\([^"\\]\|\\.\)*$+
syn match   pseucoCharacter	 "'[^']*'" contains=pseucoSpecialChar,pseucoSpecialCharError
syn match   pseucoCharacter	 "'\\''" contains=pseucoSpecialChar
syn match   pseucoCharacter	 "'[^\\]'"
syn match   pseucoNumber		 "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   pseucoNumber		 "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   pseucoNumber		 "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   pseucoNumber		 "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" unicode characters
syn match   pseucoSpecial "\\u\d\{4\}"

syn cluster pseucoTop add=pseucoString,pseucoCharacter,pseucoNumber,pseucoSpecial,pseucoStringError



" catch errors caused by wrong parenthesis
syn region  pseucoParenT	transparent matchgroup=pseucoParen  start="("  end=")" contains=@pseucoTop,pseucoParenT1
syn region  pseucoParenT1 transparent matchgroup=pseucoParen1 start="(" end=")" contains=@pseucoTop,pseucoParenT2 contained
syn region  pseucoParenT2 transparent matchgroup=pseucoParen2 start="(" end=")" contains=@pseucoTop,pseucoParenT  contained
syn match   pseucoParenError	 ")"
" catch errors caused by wrong square parenthesis
syn region  pseucoParenT	transparent matchgroup=pseucoParen  start="\["  end="\]" contains=@pseucoTop,pseucoParenT1
syn region  pseucoParenT1 transparent matchgroup=pseucoParen1 start="\[" end="\]" contains=@pseucoTop,pseucoParenT2 contained
syn region  pseucoParenT2 transparent matchgroup=pseucoParen2 start="\[" end="\]" contains=@pseucoTop,pseucoParenT  contained
syn match   pseucoParenError	 "\]"

PseucoHiLink pseucoParenError	pseucoError


" The default highlighting.
if version >= 508 || !exists("did_java_syn_inits")
  if version < 508
    let did_java_syn_inits = 1
  endif
  pseucoHiLink pseucoBranch			Conditional
  pseucoHiLink pseucoUserLabelRef		pseucoUserLabel
  pseucoHiLink pseucoLabel			Label
  pseucoHiLink pseucoUserLabel		Label
  pseucoHiLink pseucoConditional		Conditional
  pseucoHiLink pseucoLoop			Repeat
  pseucoHiLink pseucoStorageClass		StorageClass
  pseucoHiLink pseucoMethodDecl		pseucoStorageClass
  pseucoHiLink pseucoClassDecl		pseucoStorageClass
  pseucoHiLink pseucoScopeDecl		pseucoStorageClass
  pseucoHiLink pseucoBoolean		Boolean
  pseucoHiLink pseucoSpecial		Special
  pseucoHiLink pseucoSpecialError		Error
  pseucoHiLink pseucoSpecialCharError	Error
  pseucoHiLink pseucoString			String
  pseucoHiLink pseucoCharacter		Character
  pseucoHiLink pseucoSpecialChar		SpecialChar
  pseucoHiLink pseucoNumber			Number
  pseucoHiLink pseucoError			Error
  pseucoHiLink pseucoStringError		Error
  pseucoHiLink pseucoStatement		Statement
  pseucoHiLink pseucoComment		Comment
  pseucoHiLink pseucoDocComment		Comment
  pseucoHiLink pseucoLineComment		Comment
  pseucoHiLink pseucoConstant		Constant
  pseucoHiLink pseucoTodo			Todo

  pseucoHiLink pseucoCommentTitle		SpecialComment
  pseucoHiLink pseucoDocTags		Special
  pseucoHiLink pseucoDocParam		Function
  pseucoHiLink pseucoDocSeeTagParam		Function
  pseucoHiLink pseucoCommentStar		pseucoComment

  pseucoHiLink pseucoType			Type
  pseucoHiLink pseucoExternal		Include
endif

delcommand PseucoHiLink

let b:current_syntax = "pseuco"

if main_syntax == 'pseuco'
  unlet main_syntax
endif

let b:spell_options="contained"


" vim: ts=8
