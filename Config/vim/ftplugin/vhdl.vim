"Settaggi principali
setlocal omnifunc=syntaxcomplete#Complete
setlocal errorformat=**\ Error:\ %f(%l):\ %m

let &statusline="%f%< %y[%{&fileencoding}/%{&encoding}/%{&termencoding}][%{&fileformat}](%n)%m%r%w %a%=%b 0x%B  L:%l/%L, C:%-7(%c%V%) %P"

"Abbreviazioni 
iabbr dt downto
iabbr sig signal
iabbr gen generate
iabbr ot others
iabbr sl std_logic
iabbr slv std_logic_vector
iabbr uns unsigned
iabbr toi to_integer
iabbr tos to_unsigned
iabbr tou to_unsigned
iabbr pm =>
iabbr mp <=

"Bind keys
nnoremap <buffer> <localleader>cc I--<esc>
nnoremap <silent> <Leader>hd  :split ~/.vim/ftplugin/vhdl.vim <CR>
nnoremap <leader>a : call <SID>CompileVhdl()<CR>
nnoremap <leader>pm c$=> 
nnoremap <F4> : call <SID>CompileVhdl()<CR>
nnoremap <F5> :w<CR>:make<CR>
nnoremap <F6> :make view<CR> 
nnoremap <F7> :make clean<CR>
nnoremap <F9> :cprev<CR>
nnoremap <F10> :cnext<CR>
nnoremap <F2> :clist<CR>

func! s:CompileVhdl()
	exec "w"
	exec "!ghdl -a  %"
        exec "!rm -f *.cf *.o" 
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



