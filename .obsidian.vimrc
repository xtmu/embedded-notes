 " commenting out the visual line navigation out as it fails navigating notes with embeds

 " Have j and k navigate visual lines rather than logical ones, normal mode
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" use logical line navigation in visual mode
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" clear highlights
nmap <F5> :nohl

" Emulate Original gt and gT https://vimhelp.org/tabpage.txt.html#gt
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
nmap gt :nextTab
nmap gT :prevTab

" Emulate Original Folding command https://vimhelp.org/fold.txt.html#fold-commands
exmap unfoldall obcommand editor:unfold-all
exmap togglefold obcommand editor:toggle-fold
exmap foldall obcommand editor:fold-all
exmap foldless obcommand editor:fold-less
exmap foldmore obcommand editor:fold-more
nmap zo :togglefold
nmap zc :togglefold
nmap za :foldall
nmap zm :togglefold
" nmap zm :foldmore
nmap zM :foldall
" nmap zr :foldless
nmap zr :unfoldall

" spell check
exmap contextMenu obcommand editor:context-menu
nmap z= :contextMenu
vmap z= :contextMenu

exmap wq obcommand workspace:close
exmap q obcommand workspace:close

exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft

exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop

exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom

exmap vsplit obcommand workspace:split-vertical
nmap <C-w>v :vsplit

exmap split obcommand workspace:split-horizontal
nmap <C-w>s :split

" Yank to system clipboard
set clipboard=unnamed
set tabstop=4

" Have j and k navigate visual lines rather than logical ones
" nmap j gj
" nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $
" Quickly remove search highlights
" nmap <F9> :nohl

# ctrl+d
nmap <C-d> yyP

" Yank to system clipboard
" set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <A-s> :back
" nmap <C-i> :back
exmap forward obcommand app:go-forward
nmap <A-d> :forward
" nmap <C-o> :forward

" quit
nmap <C-q> :q

" surround
"
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

