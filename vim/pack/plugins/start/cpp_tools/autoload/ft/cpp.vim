" Open header file
function! ft#cpp#OpenHeader()
    let l:current_filetype = expand("%:e")

    " Check if current file is header
    if (l:current_filetype == "hpp" || l:current_filetype == "h")
        return
    endif

    let l:header_file = expand("%:p:r") . ".hpp"
    let l:alt_header_file = expand("%:p:r") . ".h"

    " If file with alternative extension exists, use it
    if filereadable(l:alt_header_file)
        let l:header_file = l:alt_header_file
    endif
    
    " Open header file on right side
    if (winnr("$") == 1) " There is only one window
        execute "rightbelow :vsplit " . l:header_file
    else
        execute "2 wincmd w"
        execute "edit " . l:header_file
    endif
endfunction

" Open source file
function! ft#cpp#OpenSource()
    let l:current_filetype = expand("%:e")

    " Check if current file is source
    if (l:current_filetype == "cpp")
        return
    endif

    let l:cpp_file = expand("%:p:r") . ".cpp"
    
    " Open header file on left side
    execute "1 wincmd w"
    if (winnr("$") == 1) " There is only one window
        execute "leftabove :vsplit " . l:cpp_file
    else
        execute "edit " . l:cpp_file
    endif
endfunction

function! ft#cpp#CreateDefinition()
    " Save line number
    let l:line_nr = line(".")

    " Create list of namespaces
    let l:namespaces = []
    let l:namespace_old = "0"
    let l:namespace_new = ""
    while (l:namespace_old != l:namespace_new)
        let l:namespace_old = l:namespace_new
        exe "normal! 0[{0/\\w {\<CR>"
        let l:namespace_new = expand("<cword>")
        if (l:namespace_new == "namespace" || l:namespace_new == "class")
            break
        endif
        let l:namespaces = [l:namespace_new] + l:namespaces
    endwhile
    " Go back to line
    exe "normal! " . l:line_nr . "gg"
    echo l:namespaces

    " Create definition
    " Copy line from header
    normal! yy
    call ft#cpp#OpenSource()
    " TODO: go to proper line
    for namespace in l:namespaces
        exe "normal! o" . namespace . "::\<ESC>"
    endfor
    normal p

endfunction
