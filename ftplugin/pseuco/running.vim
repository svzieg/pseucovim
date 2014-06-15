
if !exists("g:pseuco_command")
    let g:pseuco_command = "pseuco"
endif


function! PseucoCompileAndRun()
    silent !clear
    execute "!" . g:pseuco_command . " -i " . fnamemodify(bufname("%"),":p")
endfunction

"Define the Commands
command! PseucoCompileAndRun :call PseucoCompileAndRun()
