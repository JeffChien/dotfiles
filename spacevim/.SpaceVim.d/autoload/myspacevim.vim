function! myspacevim#before() abort

endfunction

function! myspacevim#after() abort
    set timeoutlen=250 "control menu popup delay
    set ignorecase     "less typing
endfunction
