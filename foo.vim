" Inform vim how to enable undercurl in wezterm
let &t_Cs = "\e[60m"
" Inform vim how to disable undercurl in wezterm (this disables all underline modes)
let &t_Ce = "\e[24m"

hi SpellBad   guisp=red    gui=undercurl term=underline cterm=undercurl
hi SpellCap   guisp=yellow gui=undercurl term=underline cterm=undercurl
hi SpellRare  guisp=blue   gui=undercurl term=underline cterm=undercurl
hi SpellLocal guisp=orange gui=undercurl term=underline cterm=undercurl

set spell

" A text with spellling mistake in vim. check that underline or undercurl are OK
