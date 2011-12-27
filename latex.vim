" set shiftwidth to 2
setlocal ai et sta sw=2 sts=2                          
" make german quotes easy
inoremap <buffer> " "`"'<LEFT><LEFT>
" indentation...mostly copied from vim-latex suite
setlocal indentexpr=GetTeXIndent()
setlocal indentkeys+=},=\\item,=\\bibitem

function GetTeXIndent()

    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " At the start of the file use zero indent.
    if lnum == 0 | return 0 
    endif

    let ind = indent(lnum)
    let line = getline(lnum)             " last line
    let cline = getline(v:lnum)          " current line

    " Do not change indentation of commented lines.
    if line =~ '^\s*%'
        return ind
    endif

    " Add a 'shiftwidth' after beginning of environments.
    if line =~ '^\s*\\begin{\(.*\)}'

        let ind = ind + &sw

    endif


    " Subtract a 'shiftwidth' when an environment ends
    if cline =~ '^\s*\\end' 

        " Remove another sw for item-environments
        if cline =~ 'itemize\|description\|enumerate\|thebibliography'
            let ind = ind - &sw
        endif

        let ind = ind - &sw
    endif

    " indent once after section and subsection
    " section reduces indent level exept the first section
    if line =~ '^\s*\\\(sub\)*section'
        let ind = ind + &sw
    endif

    if cline =~ '^\s*\\\(sub\)*section' 
        " find last (sub)*section
        " doesn't work if result of cursor is not assigned
        let foo = cursor(v:lnum, 1)
        let lastSection = search('^\s*\\\(sub\)*section', 'bWn')
        let foo = cursor(v:lnum, 1000)
        if lastSection > 0
            let lastSectionString = substitute(getline(lastSection), '{[^}]*}\|\s*', '', "g")
            while strlen(lastSectionString) >= strlen(substitute(cline, '{[^}]*}\|\s*', '', "g"))
                let ind = ind - &sw
                let lastSectionString = lastSectionString[3:]
            endwhile
        endif
    endif


    " Special treatment for 'item'
    " ----------------------------


    " '\item' or '\bibitem' itself:
    if cline =~ '^\s*\\\(bib\)\=item' && line !~ '\\begin'
        let ind = ind - &sw
    endif

    " lines following to '\item' are intented once again:
    if line =~ '^\s*\\\(bib\)\=item' 
        let ind = ind + &sw
    endif

    return ind
endfunction
