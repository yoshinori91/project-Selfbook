"release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"key bindings
"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" esc → <C-i>
noremap <C-i> <esc>
noremap! <C-i> <esc>
vnoremap <C-i> <esc>
" セミコロンとコロンを入れ替える
nnoremap ; :
nnoremap : ;
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" 矢印でウィンドウサイズを変更
nnoremap <Left>  <C-w>><CR>
noremap <Right> <C-w>><CR>
noremap <Up>    <C-w>-<CR>
noremap <Down>  <C-w>+<CR>
" 'で検索ハイライトを非表示にする
nnoremap ' :noh<CR>
" vを二回で行末まで選択
vnoremap v $h


set expandtab
set formatoptions-=ro
set number
set ic
set list
set smartcase
set hlsearch

set showmatch
set matchtime=3

set tabstop=4
set shiftwidth=4

" 前時代的スクリーンベルを無効化
set visualbell t_vb= 

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {
      \ "commands": ['GundoToggle'],
    \}}
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Flake8-vim'
NeoBundle 'hynek/vim-python-pep8-indent'


" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck

call neobundle#end()

set t_Co=256
syntax on
colorscheme jellybeans 
set cursorline

"jedi　ポップアップを開かない
autocmd FileType python setlocal completeopt-=preview

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=239
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" pep8 pyhton 文法チェック
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" pyflakes 保存時に自動でチェック
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10


" Jedi for python
NeoBundleLazy "davidhalter/jedi-vim", {
    \ "autoload": { "filetypes": [ "python", "python3", "djangohtml"] }}

if ! empty(neobundle#get("jedi-vim"))
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <Leader>j [jedi]
  xmap <Leader>j [jedi]

  let g:jedi#completions_command = "<C-N>"
  let g:jedi#goto_assignments_command = "[jedi]g"
  let g:jedi#goto_definitions_command = "[jedi]d"
  let g:jedi#documentation_command = "[jedi]K"
  let g:jedi#rename_command = "[jedi]r"
  let g:jedi#usages_command = "[jedi]n"
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  autocmd FileType python setlocal completeopt-=preview

  " for w/ neocomplete
  if ! empty(neobundle#get("neocomplete.vim"))
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplete#force_omni_input_patterns.python =
    \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  endif
endif
