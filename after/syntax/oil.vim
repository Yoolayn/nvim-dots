" highlights
syn match oilPerms /\v%([r-][w-][x-]){3}\s\d+%(\.\d+)?[a-z]?/ contains=oilR,oilW,oilX,oilSize
syn match oilR /r/ contained
syn match oilW /w/ contained
syn match oilX /x/ contained
syn match oilSize /\v\d+%(\.\d+)?[a-z]?/ contained

syn match oilDate /\v%([a-z]){3}\s%(\d){2}\s%(\d\d:\d\d){1}/

" colors
hi link oilR Identifier
hi link oilW diffDeleted
hi link oilX diffAdded
hi link oilSize diffAdded
hi link oilDate Directory
