nnoremap <F4> :call <SID>RunPython()<CR>

func! s:RunPython()
        exec "w"
        exec "!python2 %"
endfunc

