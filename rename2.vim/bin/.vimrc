set ru
set nu
set cindent
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set showmatch
colorscheme desert
filetype plugin indent on
syntax on
set hlsearch

let Tlist_Auto_Open=0
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

set foldenable " turn on folding 
set foldmethod=syntax " make folding indent sensitive 
set foldlevel=100 " don't autofold anything (but I can still fold manually) 
set foldopen -=search " don't open folds when you search into them 
set foldopen -=undo " don't open folds when you undo stuff 
"-------------------------------------------------------
map <f2> :WMToggle<cr>
let g:winManagerWindowLayout = "FileExplorer,TagsExplorer|BufExplorer"

set selection=exclusive 
set selectmode=mouse,key 

