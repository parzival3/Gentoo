nnoremap <buffer> <localleader>cc I--<esc>
nnoremap <leader>a : call <SID>CompileVhdl()<CR>

func! s:CompileVhdl()
	exec "w"
	exec "!ghdl -a --std=08 %"
        exec "rm -f :r.o .wrk"
endfunc

