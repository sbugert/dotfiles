" http://www.danielbigham.ca/cgi-bin/document.pl?mode=Display&DocumentID=1053
" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

    let ascii_code = char2nr(a:character)
    if ascii_code >= 48 && ascii_code <= 57
        return 0
    elseif ascii_code >= 65 && ascii_code <= 90
        return 0
    elseif ascii_code >= 97 && ascii_code <= 122
        return 0
    elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
        return 0
    endif

    return 1

endfunction

" https://stackoverflow.com/a/6271254/1895395
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! Open_carbon(mode) range
  let l:encoded_text = ''
  if (a:mode == 0)
    let l:encoded_text = UrlEncode(join(getline(1,'$'), "\n"))
  else
    let l:encoded_text = UrlEncode(s:get_visual_selection())
  endif

  let l:uri = 'https://carbon.now.sh/?code=' . l:encoded_text
  call system("open '" . shellescape(l:uri, 1) . "'")
endfunction

command! -nargs=0 CarbonBuffer call Open_carbon(0)
command! -nargs=0 CarbonSelection call Open_carbon(1)

" nnoremap <leader>oc :CarbonBuffer<CR>
" vmap oc <ESC>:CarbonSelection<CR>
