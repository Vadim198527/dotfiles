function SetTimeOfDayColors()
    let currentHour = strftime("%H")
    echo "current hour " . currentHour

    if currentHour < 12
        let colorScheme = "tokyonight-night"
    else 
        let colorScheme = "catppuccin"
    endif

    echo "color scheme is " . colorScheme
    execute "colorscheme " . colorScheme
endfunction

function CheckFileType()
    if exists("b:countCheck") ==0
        let b:countCheck = 0
    endif
    let b:countCheck += 1
    if &filetype == "" && b:countCheck > 20
        echo "Olan"
        filetype detect
    endif
endfunction

