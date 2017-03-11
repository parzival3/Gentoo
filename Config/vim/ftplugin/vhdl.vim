augroup filetype_vhdl
	autocmd!

	autocmd FileType vhdl nnoremap <buffer> <localleader>c I--<esc>

	autocmd FileType vhdl setlocal foldlevel=0

	autocmd FileType vhdl nnoremap <leader>a : call <SID>CompileVhdl()<CR>
augroup END

func! s:CompileVhdl()
	exec "w"
	exec "!ghdl -a --std=08 %"
endfunc

