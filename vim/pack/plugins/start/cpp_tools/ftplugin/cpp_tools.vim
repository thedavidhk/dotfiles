command! OpenHeader call ft#cpp#OpenHeader()
command! OpenSource call ft#cpp#OpenSource()

let current_file_extension = expand("%:e")

if (current_file_extension == "cpp")
    nnoremap <F2> :e<CR>:OpenHeader<CR>
elseif (current_file_extension == "hpp" || current_file_extension == "h")
    nnoremap <F2> :e<CR>:OpenSource<CR>
endif
