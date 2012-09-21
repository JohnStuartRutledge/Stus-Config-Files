" Vim syntax file
" Language:	Python
" Maintainer:	Neil Schemenauer <nas@python.ca>
" Last Change:	2009-10-13
" Credits:	Zvezdan Petkovic <zpetkovic@acm.org>
"		Neil Schemenauer <nas@python.ca>
"		Dmitry Vasiliev
"
"		This version is a major rewrite by Zvezdan Petkovic.
"
"		- introduced highlighting of doctests
"		- updated keywords, built-ins, and exceptions
"		- corrected regular expressions for
"
"		  * functions
"		  * decorators
"		  * strings
"		  * escapes
"		  * numbers
"		  * space error
"
"		- corrected synchronization
"		- more highlighting is ON by default, except
"		- space error highlighting is OFF by default
"
" Optional highlighting can be controlled using these variables.
"
"   let python_no_builtin_highlight      = 1
"   let python_no_doctest_code_highlight = 1
"   let python_no_doctest_highlight      = 1
"   let python_no_exception_highlight    = 1
"   let python_space_error_highlight     = 1
"
" All the options above can be switched on together.
"
"   let python_highlight_all = 1
"

" TODO: STUY:
"   - make the ** in *args and **kwargs colored white if inside parentheses
"   - Your triple quoted strings still seem a bit wonky
"   - fix all the conditional if statements in this file
"   - add syntax highlighting to regexpressions
"   - if a string starts with: u'' r'' then make the u and r blue
"   - make sure the word 'object' gets colored blue inside parentheses
"   - make sure special characters inside strings get colored purple, eg,
"         '%(x)' % {'x': 'some text'}
"         %s
"         %d


" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


if exists("python_highlight_all") && python_highlight_all != 0
  " Not override previously set options
  if !exists("python_highlight_builtins")
    if !exists("python_highlight_builtin_objs")
      let python_highlight_builtin_objs = 1
    endif
    if !exists("python_highlight_builtin_funcs")
      let python_highlight_builtin_funcs = 1
    endif
  endif
  if !exists("python_highlight_exceptions")
    let python_highlight_exceptions = 1
  endif
  if !exists("python_highlight_string_formatting")
    let python_highlight_string_formatting = 1
  endif
  if !exists("python_highlight_string_format")
    let python_highlight_string_format = 1
  endif
  if !exists("python_highlight_string_templates")
    let python_highlight_string_templates = 1
  endif
  if !exists("python_highlight_indent_errors")
    let python_highlight_indent_errors = 1
  endif
  if !exists("python_highlight_space_errors")
    let python_highlight_space_errors = 1
  endif
  if !exists("python_highlight_doctests")
    let python_highlight_doctests = 1
  endif
endif       


"-----------------------------------------------------------------------------
"
"-----------------------------------------------------------------------------
syn keyword pythonStatement	continue del exec global assert break with
syn keyword pythonStatement	lambda nonlocal pass print return yield
syn keyword pythonKeyword	def nextgroup=pythonFunction skipwhite
syn keyword pythonKeyword       class nextgroup=pythonClass skipwhite
syn keyword pythonConstant      None True False NotImplemented Ellipsis
syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__ 
syn keyword pythonConditional	if elif else
syn keyword pythonPreCondit     import from as
syn keyword pythonRepeat	for while
syn keyword pythonOperator	and in is not or
syn keyword pythonException	except finally raise try

" Comparison Operators
" <\=|>\=|\=\=|<|>|\!\=
"
" Assignment Operators
" \+\=|-\=|\*\=|/\=|//\=|%\=|&\=|\|\=|\^\=|>>\=|<<\=|\*\*\=
"
" Arithmatic Operators
" \+|\-|\*|\*\*|/|//|%|<<|>>|&|\||\^|~
"

"-----------------------------------------------------------------------------
" Extra Operators Inside Classes
"-----------------------------------------------------------------------------

syn match pythonExtraOperator
  \ "\%([~!^&|*/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\*\*\|\.\.\.\|\.\.\|::\|=\)" 
syn match pythonExtraPseudoOperator "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"

"-----------------------------------------------------------------------------
" Decorators
"-----------------------------------------------------------------------------

syn match pythonDecorator  "@" display nextgroup=pythonDottedName skipwhite
syn match pythonDottedName "[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*" display contained
syn match pythonDot        "\." display containedin=pythonDottedName

"-----------------------------------------------------------------------------
" Functions & Function Parameters
"-----------------------------------------------------------------------------

syn match  pythonFunction   "\%(\%(def\s\|class\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=pythonVars
syn region pythonVars       start="(" end=")" contained contains=pythonParameters transparent keepend
syn match  pythonParameters "[^,]*" contained contains=pythonParam,pythonBrackets skipwhite
syn match  pythonParam      "=[^,]*" contained contains=pythonExtraOperator,pythonStatement,pythonNumber,pythonString skipwhite
syn match  pythonBrackets   "[(|)]" contained skipwhite

"-----------------------------------------------------------------------------
" Classes & Class Parameters
"-----------------------------------------------------------------------------

syn match pythonClass           "\%(\%(def\s\|class\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=pythonClassVars
syn region pythonClassVars      start="(" end=")" contained contains=pythonClassParameters transparent keepend
syn match pythonClassParameters "[^,]*" contained contains=pythonBrackets skipwhite

"-----------------------------------------------------------------------------
" Comments
"-----------------------------------------------------------------------------

syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
syn match   pythonRun		"\%^#!.*$"
syn match   pythonCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pythonTodo		TODO FIXME NOTE XXX contained

"-----------------------------------------------------------------------------
" Errors
"-----------------------------------------------------------------------------

syn match pythonError		"\<\d\+\D\+\>" display
syn match pythonError		"[$?]" display
syn match pythonError		"[&|]\{2,}" display
syn match pythonError		"[=]\{3,}" display  


" TODO: Mixing spaces and tabs also may be used for pretty formatting multiline
" statements. For now I don't know how to work around this.
if exists("python_highlight_indent_errors") && python_highlight_indent_errors != 0
  syn match pythonIndentError	"^\s*\( \t\|\t \)\s*\S"me=e-1 display
endif

" Trailing space errors
if exists("python_highlight_space_errors") && python_highlight_space_errors != 0
  syn match pythonSpaceError	"\s\+$" display
endif

"-----------------------------------------------------------------------------
" Strings
"-----------------------------------------------------------------------------

syn region pythonString	   start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
syn region pythonString	   start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
syn region pythonString	   start=+[bB]\="""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonString	   start=+[bB]\='''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn region pythonDocString start=+^\(\\\n\s*\)\@<!\s*"""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,pythonDocStringTitle,pythonEpydocMarkup,pythonEpydocTag,@Spell
syn region pythonDocString start=+^\(\\\n\s*\)\@<!\s*'''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,pythonDocStringTitle,pythonEpydocMarkup,pythonEpydocTag,@Spell
syn region pythonDocStringTitle  contained matchgroup=pythonDocString start=+"""+ matchgroup=pythonDocStringTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end=+"""+me=s-1,he=s-1 contains=pythonEpydocMarkup,@Spell 
syn region pythonDocStringTitle  contained matchgroup=pythonDocString start=+'''+ matchgroup=pythonDocStringTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end=+'''+me=s-1,he=s-1 contains=pythonEpydocMarkup,@Spell 
           

syn match  pythonEscape	     +\\[abfnrtv'"\\]+ display contained
syn match  pythonEscape	     "\\\o\o\=\o\="    display contained
syn match  pythonEscapeError "\\\o\{,2}[89]"   display contained
syn match  pythonEscape	     "\\x\x\{2}"       display contained
syn match  pythonEscapeError "\\x\x\=\X"       display contained
syn match  pythonEscape	     "\\$"
             
"-----------------------------------------------------------------------------
" Unicode strings
syn region pythonUniString  start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
syn region pythonUniString  start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
syn region pythonUniString  start=+[uU]"""+ end=+"""+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonUniString  start=+[uU]'''+ end=+'''+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn match  pythonUniEscape	"\\u\x\{4}" display contained
syn match  pythonUniEscapeError	"\\u\x\{,3}\X" display contained
syn match  pythonUniEscape	"\\U\x\{8}" display contained
syn match  pythonUniEscapeError	"\\U\x\{,7}\X" display contained
syn match  pythonUniEscape	"\\N{[A-Z ]\+}" display contained
syn match  pythonUniEscapeError	"\\N{[^A-Z ]\+}" display contained

"-----------------------------------------------------------------------------
" Raw strings
syn region pythonRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString	start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawString	start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn match pythonRawEscape	+\\['"]+ display transparent contained

"-----------------------------------------------------------------------------
" Unicode raw strings
syn region pythonUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
syn region pythonUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
syn region pythonUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn match  pythonUniRawEscape		"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  pythonUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

if exists("python_highlight_string_formatting") && python_highlight_string_formatting != 0
  " String formatting
  syn match pythonStrFormatting	"%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrFormatting	"%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_string_format") && python_highlight_string_format != 0
  " str.format syntax
  syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrFormat	"{\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)\(\.[a-zA-Z_][a-zA-Z0-9_]*\|\[\(\d\+\|[^!:\}]\+\)\]\)*\(![rs]\)\=\(:\({\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)}\|\([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*\(\.\d\+\)\=[bcdeEfFgGnoxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_string_templates") && python_highlight_string_templates != 0
  " String templates
  syn match pythonStrTemplate	"\$\$" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrTemplate	"\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrTemplate	"\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_doctests") && python_highlight_doctests != 0
  " DocTests
  syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
  syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained
endif
           

"-----------------------------------------------------------------------------
" Numbers
"-----------------------------------------------------------------------------

syn match   pythonHexError  "\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display
syn match   pythonHexNumber "\<0[xX]\x\+[lL]\=\>" display
syn match   pythonOctNumber "\<0[oO]\o\+[lL]\=\>" display
syn match   pythonBinNumber "\<0[bB][01]\+[lL]\=\>" display
syn match   pythonNumber    "\<\d\+[lLjJ]\=\>" display
syn match   pythonFloat     "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat     "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat     "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display
syn match   pythonOctError  "\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
syn match   pythonBinError  "\<0[bB][01]*[2-9]\d*[lL]\=\>" display


"-----------------------------------------------------------------------------
" Builtins
"-----------------------------------------------------------------------------

syn keyword pythonBuiltin	abs all any bin bool chr classmethod
syn keyword pythonBuiltin	compile complex delattr dict dir divmod
syn keyword pythonBuiltin	enumerate eval filter float format
syn keyword pythonBuiltin	frozenset getattr globals hasattr hash
syn keyword pythonBuiltin	help hex id input int isinstance
syn keyword pythonBuiltin	issubclass iter len list locals map max
syn keyword pythonBuiltin	min next object oct open ord pow print
syn keyword pythonBuiltin	property range repr reversed round set
syn keyword pythonBuiltin	setattr slice sorted staticmethod str
syn keyword pythonBuiltin	sum super tuple type vars zip __import__
" Python 2.6 only
syn keyword pythonBuiltin	basestring callable cmp execfile file
syn keyword pythonBuiltin	long raw_input reduce reload unichr
syn keyword pythonBuiltin	unicode xrange
" Python 3.0 only
syn keyword pythonBuiltin	ascii bytearray bytes exec memoryview
" non-essential built-in functions; Python 2.6 only
syn keyword pythonBuiltin	apply buffer coerce intern


"-----------------------------------------------------------------------------
" Exceptions
"-----------------------------------------------------------------------------
" From the 'Python Library Reference' class hierarchy at the bottom.
" http://docs.python.org/library/exceptions.html
if !exists("python_no_exception_highlight")
  " builtin base exceptions (only used as base classes for other exceptions)
  syn keyword pythonExceptions	BaseException Exception
  syn keyword pythonExceptions	ArithmeticError EnvironmentError
  syn keyword pythonExceptions	LookupError
  " builtin base exception removed in Python 3.0
  syn keyword pythonExceptions	StandardError
  " builtin exceptions (actually raised)
  syn keyword pythonExceptions	AssertionError AttributeError BufferError
  syn keyword pythonExceptions	EOFError FloatingPointError GeneratorExit
  syn keyword pythonExceptions	IOError ImportError IndentationError
  syn keyword pythonExceptions	IndexError KeyError KeyboardInterrupt
  syn keyword pythonExceptions	MemoryError NameError NotImplementedError
  syn keyword pythonExceptions	OSError OverflowError ReferenceError
  syn keyword pythonExceptions	RuntimeError StopIteration SyntaxError
  syn keyword pythonExceptions	SystemError SystemExit TabError TypeError
  syn keyword pythonExceptions	UnboundLocalError UnicodeError
  syn keyword pythonExceptions	UnicodeDecodeError UnicodeEncodeError
  syn keyword pythonExceptions	UnicodeTranslateError ValueError VMSError
  syn keyword pythonExceptions	WindowsError ZeroDivisionError
  " builtin warnings
  syn keyword pythonExceptions	BytesWarning DeprecationWarning FutureWarning
  syn keyword pythonExceptions	ImportWarning PendingDeprecationWarning
  syn keyword pythonExceptions	RuntimeWarning SyntaxWarning UnicodeWarning
  syn keyword pythonExceptions	UserWarning Warning
endif

if exists("python_space_error_highlight")
  " trailing whitespace
  syn match   pythonSpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   pythonSpaceError	display " \+\t"
  syn match   pythonSpaceError	display "\t\+ "
endif

"-----------------------------------------------------------------------------
"
"-----------------------------------------------------------------------------
" Do not spell doctests inside strings.
" Notice that the end of a string, either ''', or """, will end the contained
" doctest too.  Thus, we do *not* need to have it as an end pattern.
if !exists("python_no_doctest_highlight")
  if !exists("python_no_doctest_code_higlight")
    syn region pythonDoctest start="^\s*>>>\s" end="^\s*$" contained contains=ALLBUT,pythonDoctest,@Spell
    syn region pythonDoctestValue start=+^\s*\%(>>>\s\|\.\.\.\s\|"""\|'''\)\@!\S\++ end="$" contained
  else
    syn region pythonDoctest start="^\s*>>>" end="^\s*$" contained contains=@NoSpell
  endif
endif

"-----------------------------------------------------------------------------
"
"-----------------------------------------------------------------------------

" Sync at the beginning of class, function, or method definition.
syn sync match pythonSync grouphere NONE "^\s*\%(def\|class\)\s\+\h\w*\s*("


"-----------------------------------------------------------------------------
"
"-----------------------------------------------------------------------------
if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pythonStatement	   Statement
  HiLink pythonConditional	   Conditional
  HiLink pythonRepeat		   Repeat
  HiLink pythonOperator		   Operator
  HiLink pythonException	   Exception
  HiLink pythonPreCondit           Operator

  HiLink pythonDecorator	   Define
  HiLink pythonDottedName          Function
  HiLink pythonDot                 Normal

  HiLink pythonKeyword             Structure
  HiLink pythonFunction	           Function
  HiLink pythonComment	           Comment
  HiLink pythonCoding              Special
  HiLink pythonRun                 Special
  HiLink pythonTodo	           Todo
 
  HiLink pythonDocString           String
  HiLink pythonDocStringTitle      String

  HiLink pythonError	           Error
  HiLink pythonIndentError	   Error
  HiLink pythonSpaceError	   Error  

  HiLink pythonExtraOperator       Operator
  HiLink pythonExtraPseudoOperator Operator
  HiLink pythonClass               Normal
  HiLink pythonParameters          Identifier
  HiLink pythonParam               Normal
  HiLink pythonBrackets            Normal
  HiLink pythonClassParameters     InheritUnderlined
  
  HiLink pythonBuiltin             Builtin
  HiLink pythonBuiltinObj          Structure 

  " Not really a number, just set this to turn it purple
  HiLink pythonConstant            Number
   
  HiLink pythonString		   String
  HiLink pythonUniString	   String
  HiLink pythonRawString           String
  HiLink pythonUniRawString	   String

  HiLink pythonEscape		   Special
  HiLink pythonEscapeError	   Error
  HiLink pythonUniEscape	   Special
  HiLink pythonUniEscapeError	   Error
  HiLink pythonUniRawEscape	   Special
  HiLink pythonUniRawEscapeError   Error

  HiLink pythonStrFormatting       Special
  HiLink pythonStrFormat    	   Special
  HiLink pythonStrTemplate	   Special

  HiLink pythonDocTest	           Special
  HiLink pythonDocTest2		   Special
                              
  HiLink pythonNumber	           Number
  HiLink pythonHexNumber	   Number
  HiLink pythonOctNumber	   Number
  HiLink pythonBinNumber	   Number
  HiLink pythonFloat		   Float
  HiLink pythonOctError	           Error
  HiLink pythonHexError		   Error
  HiLink pythonBinError		   Error   


  if !exists("python_no_exception_highlight")
    HiLink pythonExceptions	Structure
  endif
  if exists("python_space_error_highlight")
    " HiLink pythonSpaceError	Error
  endif
  if !exists("python_no_doctest_highlight")
    HiLink pythonDoctest	Special
    HiLink pythonDoctestValue	Define
  endif

  delcommand HiLink
endif

let b:current_syntax = "python"

" vim:set sw=2 sts=2 ts=8 noet:
