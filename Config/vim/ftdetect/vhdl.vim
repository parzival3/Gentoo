augroup filetype_vhdl
	autocmd!

        autocmd BufNewFile,BufRead *.vhd   setfiletype vhdl
        autocmd BufNewFile,BufRead *.vhdl  setfiletype vhdl

	autocmd BufNewFile *.vhdl :call <SID>Createindent()
	autocmd BufNewFile *.vhd :call <SID>Createindent()

        autocmd Bufwritepre,filewritepre *.vhd  :call <SID>Updateindent() 
        autocmd Bufwritepre,filewritepre *.vhdl :call <SID>Updateindent() 

augroup END

func! s:Createindent()
	execute "0r ~/.vim/skeleton/skeleton-vhdl.vim"
	execute "1," . 2 . "g#File Name:\.\*#s#\#File Name: " .expand("%:t:r")
	execute "1," . 7 . "g#Created:\.\*#s#\#Created: " .strftime("%d\-%m\-%Y")
        execute "1," . 17
endfunc

func! s:Updateindent()
	execute "normal! mq"
	execute "1," . 10 . "g/Last Modified:.*/s//Last Modified: " .strftime("%c")
	execute "normal! `q"
endfunc
