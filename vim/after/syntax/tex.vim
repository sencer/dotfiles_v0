" syn region texDiffAdd start=/\\DIFaddbegin\zs/ end=/\ze\\DIFaddend/
" syn match texDiffConceal /\\DIF[a-z ]\+/ conceal
syn region texDiffAdd matchgroup=texDiffEnds start=/\\DIFaddbegin \\DIFadd{/ end=/}\\DIFaddend/ concealends
syn region texDiffDel matchgroup=texDiffEnds start=/\\DIFdelbegin \\DIFdel{/ end=/}\\DIFdelend/ concealends
hi link texDiffEnds Conceal
hi link texDiffAdd Underlined
hi link texDiffDel ErrorMsg
" syn region texDiffAdd matchgroup=Delimiter  start=/\\DIFaddbegin/ end=/\\DIFaddend/ concealends
" hi link texDiffAdd Underlined
