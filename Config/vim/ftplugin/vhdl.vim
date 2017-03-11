nnoremap <buffer> <localleader>cc I--<esc>
nnoremap <leader>a : call <SID>CompileVhdl()<CR>

func! s:CompileVhdl()
	exec "w"
	exec "!ghdl -a  %"
        exec "!rm -f :r.o .cf"
endfunc

