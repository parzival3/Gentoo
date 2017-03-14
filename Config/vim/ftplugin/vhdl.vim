
nnoremap <buffer> <localleader>cc I--<esc>
nnoremap <leader>a : call <SID>CompileVhdl()<CR>

func! s:CompileVhdl()
	exec "w"
	exec "!ghdl -a  %"
        exec "!rm -f *.cf " . expand(":r") . ".o" 
endfunc

if ! exists("b:match_words")  &&  exists("loaded_matchit")
  let b:match_ignorecase=1
  let s:notend = '\%(\<end\s\+\)\@<!'
  let b:match_words =
    \ s:notend.'\<if\>:\<elsif\>:\<else\>:\<end\s\+if\>,'.
    \ s:notend.'\<case\>:\<when\>:\<end\s\+case\>,'.
    \ s:notend.'\<loop\>:\<end\s\+loop\>,'.
    \ s:notend.'\<for\>:\<end\s\+for\>,'.
    \ s:notend.'\<generate\>:\<end\s\+generate\>,'.
    \ s:notend.'\<record\>:\<end\s\+record\>,'.
    \ s:notend.'\<units\>:\<end\s\+units\>,'.
    \ s:notend.'\<process\>:\<end\s\+process\>,'.
    \ s:notend.'\<block\>:\<end\s\+block\>,'.
    \ s:notend.'\<function\>:\<end\s\+function\>,'.
    \ s:notend.'\<entity\>:\<end\s\+entity\>,'.
    \ s:notend.'\<component\>:\<end\s\+component\>,'.
    \ s:notend.'\<architecture\>:\<end\s\+architecture\>,'.
    \ s:notend.'\<package\>:\<end\s\+package\>,'.
    \ s:notend.'\<procedure\>:\<end\s\+procedure\>,'.
    \ s:notend.'\<configuration\>:\<end\s\+configuration\>'
endif

" count repeat
function! <SID>CountWrapper(cmd)
  let i = v:count1
  if a:cmd[0] == ":"
    while i > 0
      execute a:cmd
      let i = i - 1
    endwhile
  else
    execute "normal! gv\<Esc>"
    execute "normal ".i.a:cmd
    let curcol = col(".")
    let curline = line(".")
    normal! gv
    call cursor(curline, curcol)
  endif
endfunction



