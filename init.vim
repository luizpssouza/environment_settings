set guicursor=
set noshowmatch
set relativenumber
set hlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=10
set magic
set updatetime=750
set cursorline

if has('nvim')
	set inccommand=split
endif

set noshowmode
set clipboard+=unnamedplus
set t_Co=256


" Give more space for displaying messages.
set cmdheight=2

set shortmess+=c
set completeopt=menuone,noselect

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'SirVer/ultisnips'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'honza/vim-snippets'
Plug 'wincent/ferret'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'puremourning/vimspector'

Plug 'szw/vim-maximizer'

Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug '/home/mpaulson/personal/vim-be-good'
" Plug 'APZelos/blamer.nvim'
Plug 'terryma/vim-multiple-cursors'

" python
Plug 'jmcantrell/vim-virtualenv'
Plug 'w0rp/ale'

Plug 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plug 'cakebaker/scss-syntax.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'romainl/vim-qf'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_disable_lsp = 1

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_fixers = {
\  'typescript': ['prettier'],
\}
let g:ale_fix_on_save = 1

let g:gruvbox_contrast_dark = 'hard'

" --- The Greatest plugin of all time.  I am not bias
let g:vim_be_good_floating = 1

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1


lua << EOF
local nvim_lsp = require('lspconfig')

-- enable null-ls integration (optional)
require("null-ls").setup {}

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end
vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end
local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red gui=bold guifg=#ffb300
        hi LspReferenceText cterm=bold ctermbg=red gui=bold guifg=#ffb300
        hi LspReferenceWrite cterm=bold ctermbg=red gui=bold guifg=#ffb300
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
    end
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)

        -- define an alias
        vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")

        -- format on save
        vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")

        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            debug = true,
            disable_commands = false,
            enable_import_on_completion = true,
            import_all_timeout = 5000, -- ms

            -- eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint_d",
            eslint_config_fallback = nil,
            eslint_enable_diagnostics = true,

            -- formatting
            enable_formatting = true,
            formatter = "eslint_d",
            formatter_config_fallback = nil,

            -- parentheses completion
            complete_parens = true,
            signature_help_in_parens = true,

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = true,
            watch_dir = nil,
        }

        -- required to fix code action ranges
        ts_utils.setup_client(client)
    end
}

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}

local formatters = {
  --prettier = {command = "prettier-eslint", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}
EOF

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
" highlight link CompeDocumentation NormalFloat

let g:prettier#autoformat = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_ignore_case = 0
let g:completion_matching_smart_case = 1
let g:completion_sorting = "length"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

imap <expr> <C-<Space>> asd;lfk

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 50
" let g:netrw_localrmdir='rm -r'

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}


" ultisnips settings
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir='~/.config/nvim/UltiSnipsSnippets'


"normal maps
" nnoremap <leader>h :wincmd h<CR>
" nnoremap <leader>j :wincmd j<CR>
" nnoremap <leader>k :wincmd k<CR>
" nnoremap <leader>l :wincmd l<CR>
tnoremap <C-h> :TmuxNavigateLeft<cr>
tnoremap <C-j> :TmuxNavigateDown<cr>
tnoremap <C-k> :TmuxNavigateUp<cr>
tnoremap <C-l> :TmuxNavigateRight<cr>

nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap Y y$
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>y "*y
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 50<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>; A;<esc>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>ev :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <Leader>sv :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +100<CR>
nnoremap <Leader>- :vertical resize -100<CR>
nnoremap <Leader>wr :wincmd r<CR>
nnoremap <Leader>wj :wincmd J<CR>
nnoremap <Leader>wk :wincmd K<CR>
nnoremap <Leader>wl :wincmd L<CR>
nnoremap <Leader>wh :wincmd H<CR>
nnoremap <Leader>s :%s///gc<left><left><left><left>
" nnoremap <Leader>af <esc>ggVG=<C-o>
nnoremap <Leader>n @q
nnoremap <Leader>tm :vs +terminal<CR>i
nnoremap <Leader>cp :let @+ = expand("%")<CR>
nnoremap <Leader>ca ggVGy
nnoremap <Leader>m :MaximizerToggle<CR>
nnoremap <silent> <Leader>cf :clear<bar>silent exec "!cp '%:p' '%:p:h/%:t:r-copy.%:e'"<bar>redraw<bar>echo "Copied " . expand('%:t') . ' to ' . expand('%:t:r') . '-copy.' . expand('%:e')<cr>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gb :Git blame<CR>
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>  compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })
nnoremap <silent> <leader>gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <C-l> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>l <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ac <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-j> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>j <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>qf :TSLspFixCurrent<CR>
nnoremap <leader>af mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F:w<CR>
" nnoremap <CR> :nohl<CR>
vnoremap < <gv
vnoremap > >gv

nmap <leader>qq	<Plug>(qf_qf_toggle)
nmap gn		<Plug>(qf_qf_next)
nmap gp		<Plug>(qf_qf_previous)

" visual maps
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <C-r> "hy:%s/\C<C-r>h//gc<left><left><left>
vnoremap X "_d

" Insert maps
inoremap jj <esc>

"resolving control backspaces
inoremap <C-h> <C-w>
inoremap <C-BS> <C-h>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

if has('nvim')
  tnoremap <Leader>] <c-\><c-n>
  tnoremap <Leader>[ <c-\><c-n>
endif
