local timer = vim.uv.new_timer()
local cwd = vim.fn.getcwd()
local search_dirs = { cwd }

local extra_search_reldirs = os.getenv("NVIM_SEARCH_RELDIRS")
if extra_search_reldirs ~= nil then
  local i = 1 -- don't hesitate to override cwd initially set if relative search_dirs are specified
  for w in extra_search_reldirs:gmatch("([^,]+)") do
    search_dirs[i] = cwd .. "/" .. w
    i = i + 1
  end
end

local extra_search_dirs = os.getenv("NVIM_SEARCH_DIRS")
if extra_search_dirs ~= nil then
  local i = #search_dirs + 1
  for w in extra_search_dirs:gmatch("([^,]+)") do
    search_dirs[i] = w
    i = i + 1
  end
end

if timer ~= nil then
  timer:start(
    1000,
    0,
    vim.schedule_wrap(function()
      vim.api.nvim_echo({
        { "NVIM_SEARCH_DIRS: " .. (extra_search_dirs or "") },
        { "NVIM_SEARCH_RELDIRS: " .. (extra_search_reldirs or "") },
        { "\n\nsearch_dirs: \n" .. table.concat(search_dirs, "\n") },
      }, true, {})
    end)
  )
end

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- add a keymap to browse plugin files
    -- stylua: ignore
    {
      "<leader>fs",
      function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-l>"] = actions.results_scrolling_right,
            ["<C-h>"] = actions.results_scrolling_left,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
          search_dirs = search_dirs,
        },
      },
    }
  end,
}
