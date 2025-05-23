let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.local/share/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +20 ~/dotfiles/nvim/.config/nvim/session.vim
badd +2 ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope.lua
badd +1 ~/dotfiles/nvim/.config/nvim/lua/vim-options.lua
badd +5 ~/dotfiles/nvim/.config/nvim/lua/plugins/leap.lua
badd +1 ~/Desktop/test/count_words.vim
badd +1 ~/dotfiles/nvim/.config/nvim/lua/plugins/neo-org.lua
argglobal
%argdel
edit ~/dotfiles/nvim/.config/nvim/lua/vim-options.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 30 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 137 + 84) / 168)
argglobal
enew
file NvimTree_1
balt ~/dotfiles/nvim/.config/nvim/session.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal nofen
lcd ~/dotfiles/nvim/.config/nvim/lua
wincmd w
argglobal
balt ~/dotfiles/nvim/.config/nvim/session.vim
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 52 - ((42 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 52
normal! 0
lcd ~/dotfiles/nvim/.config/nvim/lua
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 30 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 137 + 84) / 168)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
