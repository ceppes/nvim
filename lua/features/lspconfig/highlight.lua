-- Undercurl
-- test : echo -e "\e[4:3mTEST"

--tmux
--set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
--set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

vim.cmd.highlight("DiagnosticUnderlineError guisp=red gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineWarn guisp=orange gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineInfo guisp=yellow gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineHint guisp=green gui=undercurl")
