local gl = require('galaxyline')
local gls = gl.section
local vim = vim
local extension = require('galaxyline.provider_extensions')

gl.short_line_list = {
    'LuaTree',
    'vista',
    'dbui',
    'startify',
    'term',
    'nerdtree',
    'fugitive',
    'fugitiveblame',
    'plug',
    'plugins'
}
VistaPlugin = extension.vista_nearest

local ProgFileTypes = {'lua', 'python', 'typescript', 'typescriptreact', 'react', 'javascript', 'javascriptreact', 'rust', 'go', 'html'}
-- for checking value in table
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


local function get_color()
    if vim.o.background == 'light' then
        return "#fff"
    end
    return "#353644"
end

local function get_color_bg()
    if vim.o.background == 'light' then
        return "#fff"
    end
    return "#282c34"
end

-- then change in colors line_bg = get_color_bg

local colors = {

    bg = "#282c34",
    line_bg = "#353644",
    fg = '#8FBCBB',
    fg_green = '#65a380',
    yellow = '#fabd2f',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#afd700',
    orange = '#FF8800',
    purple = '#5d4d7a',
    magenta = '#D100D1',
    blue = '#51afef';
    red = '#ec5f67'
}

local function file_readonly(readonly_icon)
  if vim.bo.filetype == 'help' then
    return ''
  end
  local icon = readonly_icon or ''
  if vim.bo.readonly == true then
    return " " .. icon .. " "
  end
  return ''
end
-- get current file name
local function get_current_file_name()
  -- local file = vim.fn.expand('%:t')
  local file = vim.fn.expand('%:f')
  if vim.fn.empty(file) == 1 then return '' end
  if string.len(file_readonly(readonly_icon)) ~= 0 then
    return file .. file_readonly(readonly_icon)
  end
  local icon = modified_icon or ''
  if vim.bo.modifiable then
    if vim.bo.modified then
      return file .. ' ' .. icon .. '  '
    end
  end
  return file .. ' '
end


local function lsp_status(status)
    shorter_stat = ''
    for match in string.gmatch(status, "[^%s]+")  do
        err_warn = string.find(match, "^[WE]%d+", 0)
        if not err_warn then
            shorter_stat = shorter_stat .. ' ' .. match
        end
    end
    return shorter_stat
end


local function get_coc_lsp()
  local status = vim.fn['coc#status']()
  if not status or status == '' then
      return ''
  end
  return lsp_status(status)
end


function get_diagnostic_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_coc_lsp()
    end
  return ''
end

local function get_current_func()
  local has_func, func_name = pcall(vim.api.nvim_buf_get_var,0,'coc_current_function')
  if not has_func then return end
      return func_name
  end

function get_function_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_current_func()
    end
  return ''
end

local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return ' '
    else
        return nil
    end
end

CocStatus = get_diagnostic_info
DebugInfo = get_debug_status
CocFunc = get_current_func
-- TreesitterContext = get_current_func_from_treesitter
TrailingWhiteSpace = trailing_whitespace

function has_file_type()
    local f_type = vim.bo.filetype
    if not f_type or f_type == '' then
        return false
    end
    return true
end

function has_file_prog_filetype()
    local f_type = vim.bo.filetype
    if not f_type or f_type == '' then
        return false
    end
    if has_value(ProgFileTypes, f_type) then
        return true
    end
    return false
end


local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local buffer_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return false
    end
    return true
end

gls.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    separator = " ",
    separator_highlight = {colors.magenta,colors.line_bg},
    highlight = {colors.magenta,colors.magenta}
  },
}

gls.left[2] = {
  ViMode = {
    provider = function()
      local mode_color = {
          n = colors.magenta,
          i = colors.blue,v=colors.magenta,[''] = colors.blue,V=colors.blue,
          c = colors.red,no = colors.magenta,s = colors.orange,S=colors.orange,
          [''] = colors.orange,ic = colors.yellow,R = colors.purple,Rv = colors.purple,
          cv = colors.red,ce=colors.red, r = colors.cyan,rm = colors.cyan, ['r?'] = colors.cyan,
          ['!']  = colors.green,t = colors.green,
          c  = colors.purple,
          ['r?'] = colors.red,
          ['r']  = colors.red,
          rm = colors.red,
          R  = colors.yellow,
          Rv = colors.magenta,
      }
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
      return '   '
    end,
    highlight = {colors.magenta,colors.line_bg,'bold'},
  },
}

gls.left[3] = {
    leftRounded = {
        provider = function()
            return ""
        end,
        condition = buffer_not_empty,
        highlight = {colors.purple,colors.line_bg}
    }
}


gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.purple},
  },
}

gls.left[5] = {
  FileName = {
    provider = {get_current_file_name},
    separator = " ",
    separator_highlight = {colors.purple,colors.line_bg},
    condition = buffer_not_empty,
    highlight = {colors.fg,colors.purple,'bold'}
  }
}

gls.left[6] = {
    FileSize = {
        provider = "FileSize",
        highlight = {colors.cyan,colors.line_bg,'bold'}
    }
}
gls.left[7] = {
  GitIcon = {
    provider = function() return '    ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.yellow,colors.line_bg},
  }
}

gls.left[8] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = " ",
    separator_highlight = {colors.fg,colors.line_bg},
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.fg,colors.line_bg,'bold'},
  }
}


local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 30 then
    return true
  end
  return false
end

gls.left[9] = {
  Space = {
    provider = function () return '' end
  }
}

gls.left[10] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '   ',
    highlight = {colors.green,colors.line_bg},
  }
}
gls.left[11] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '   ',
    highlight = {colors.orange,colors.line_bg},
  }
}
gls.left[12] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '   ',
    highlight = {colors.red,colors.line_bg},
  }
}

gls.left[13] = {
    TrailingWhiteSpace = {
     provider = TrailingWhiteSpace,
     icon = '   ',
     highlight = {colors.yellow,colors.line_bg},
    }
}

gls.left[14] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.line_bg}
  }
}
gls.left[15] = {
  Space = {
    provider = function () return '' end
  }
}
gls.left[16] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '   ',
    highlight = {colors.yellow,colors.line_bg},
  }
}


gls.right[1] = {
  LineInfo = {
    provider = 'LineColumn',
    condition = buffer_not_empty,
    separator_highlight = {colors.blue,colors.line_bg},
    highlight = {colors.fg,colors.line_bg},
  },
}
gls.right[2] = {
    ScrollBar = {
        provider = "ScrollBar",
        condition = buffer_not_empty,
        separator = " ",
        separator_highlight = {colors.blue,colors.line_bg},
        highlight = {colors.yellow, colors.line_bg}
    }
}

gls.right[3] = {
    rightRounded = {
        provider = function()
            return "▋"
        end,
        condition = buffer_empty,
        highlight = {colors.purple,colors.line_bg},
    }
}
