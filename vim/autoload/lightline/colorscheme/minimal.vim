" =============================================================================
" Filename: autoload/lightline/colorscheme/one.vim
" Author: Zoltan Dalmadi
" License: MIT License
" Last Change: 2017/11/28 21:53:01.
" =============================================================================

" Common colors
let s:fg     = [ '#abb2bf', 145 ]
let s:blue   = [ '#61afef', 75 ]

let s:cyan   = [ '#56b6c2', 38 ]
let s:green  = [ '#98c379', 76 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#be5046', 168 ]
let s:yellow = [ '#e5c07b', 180 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}}

" Dark variant
let s:bg     = [ '#282c34', 235 ]
let s:gray1  = [ '#5c6370', 241 ]
let s:gray2  = [ '#2c323d', 235 ]
let s:gray3  = [ '#3e4452', 240 ]

let s:p.normal.left     = [ [ s:green, s:bg ], [ s:blue, s:bg ] ]
let s:p.normal.middle   = [ [ s:fg, s:bg ] ]
let s:p.inactive.left   = [ [ s:gray1,  s:bg ], [ s:gray1, s:bg ] ]
let s:p.inactive.middle = [ [ s:gray1, s:gray2 ] ]
let s:p.inactive.right  = [ [ s:gray1, s:bg ], [ s:gray1, s:bg ] ]
let s:p.insert.left     = [ [ s:blue, s:bg ], [ s:blue, s:bg ] ]
let s:p.replace.left    = [ [ s:red1, s:bg ], [ s:blue, s:bg ] ]
let s:p.visual.left     = [ [ s:yellow, s:bg ], [ s:blue, s:bg ] ]

" Common
let s:p.normal.right   = [ [ s:green, s:bg ], [ s:green, s:bg ] ]
let s:p.normal.error   = [ [ s:red2, s:bg ] ]
let s:p.normal.warning = [ [ s:yellow, s:bg ] ]
let s:p.insert.right   = [ [ s:blue, s:bg ], [ s:blue, s:bg ] ]
let s:p.replace.right  = [ [ s:red1, s:bg ], [ s:red1, s:bg ] ]
let s:p.visual.right   = [ [ s:purple, s:bg ], [ s:yellow, s:bg ] ]

let g:lightline#colorscheme#minimal#palette = lightline#colorscheme#flatten(s:p)
