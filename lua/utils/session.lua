local M = {}

local utils = require("utils")

local function inside_git_workdir()
  return vim.fn.trim(vim.fn.system("git rev-parse --is-inside-work-tree")) == "true"
end

local function get_session_file_dir()
  local base_session_dir = os.getenv("NEOVIM_SESSION_DIR")
  if base_session_dir == nil then
    utils.error("NEOVIM_SESSION_DIR not set")
    return nil
  else
    utils.info("NEOVIM_SESSION_DIR is " .. base_session_dir)
    if inside_git_workdir() then
      local repo_name = vim.fn.trim(vim.fn.system("basename `git rev-parse --show-toplevel`"))
      local session_dir = base_session_dir .. "/" .. repo_name
      if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, "p")
      end
      return session_dir
    else
      return base_session_dir
    end
  end
end

local function get_session_file_path()
  local session_dir = get_session_file_dir()
  if session_dir == nil then
    return nil
  elseif inside_git_workdir() then
    return vim.fn.trim(session_dir .. "/" .. vim.fn.system("git rev-parse --abbrev-ref HEAD"))
  else
    return session_dir .. "/" .. "Session.vim"
  end
end

local function make_session(session_name)
  local cmd = "mks! " .. session_name
  vim.cmd(cmd)
end

function M.save_session()
  local default_session_name = get_session_file_path()
  vim.ui.input({ prompt = "Input session name: ", default = default_session_name }, function(session_name)
    if session_name then
      make_session(session_name)
      utils.info("Session saved to " .. session_name)
    end
  end)
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function restore_session(prompt_bufnr, _)
  local session_dir = get_session_file_dir()
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local session_name = selection[1]:gsub("./", "")
    session_name = session_dir .. "/" .. session_name
    local cmd = "source " .. session_name
    vim.cmd(cmd)
    utils.info(session_name, "Session restored")
  end)
  return true
end

function M.restore_session()
  local opts = {
    attach_mappings = restore_session,
    prompt_title = "Select session ",
    cwd = get_session_file_dir(),
  }
  require("telescope.builtin").find_files(opts)
end

return M
