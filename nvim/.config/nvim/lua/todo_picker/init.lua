-- todo_picker.nvim — минималистичный плагин задач с сохранением позиции
-- Автор: ChatGPT (OpenAI)
-- Лицензия: MIT

local M = {}

local default_opts = {
  todo_file = vim.fn.expand("/Users/chestnykh/Desktop/Obsid_vault/Tasks.md"),
  keymaps = {
    add  = "<localleader>ta",
    list = "<localleader>tt",
  },
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.keymap.set("n", M.opts.keymaps.add,  M.add_task,  { desc = "TodoPicker: добавить задачу" })
  vim.keymap.set("n", M.opts.keymaps.list, M.show_tasks, { desc = "TodoPicker: список задач" })
end

-- собрать задачи --------------------------------------------------------
local function collect_tasks()
  local tasks, path = {}, vim.fn.expand(M.opts.todo_file)
  if vim.fn.filereadable(path) == 1 then
    for i, line in ipairs(vim.fn.readfile(path)) do
      if line:match("%- %[[ xX]?%]") then tasks[#tasks+1] = { text = line, lnum = i } end
    end
  end
  return tasks, path
end

-- добавить задачу -------------------------------------------------------
function M.add_task()
  vim.ui.input({ prompt = "Новая задача: " }, function(input)
    if not input or input == "" then return end
    local ok, err = pcall(function()
      local fp = assert(io.open(vim.fn.expand(M.opts.todo_file), "a"))
      fp:write("- [ ] " .. input .. "\n"); fp:close()
    end)
    if ok then vim.notify("Добавлена задача: " .. input, vim.log.levels.INFO)
    else       vim.notify("Ошибка записи TODO: " .. err, vim.log.levels.ERROR) end
  end)
end

--------------------------------------------------------------------------
---@param preselect_lnum number|nil  номер строки, которую выделить после открытия
function M.show_tasks(preselect_lnum)
  if not pcall(require, "telescope") then vim.notify("Telescope не установлен", vim.log.levels.ERROR); return end
  local pickers, finders = require"telescope.pickers", require"telescope.finders"
  local conf  = require"telescope.config".values
  local previewers = require"telescope.previewers"
  local actions, action_state = require"telescope.actions", require"telescope.actions.state"

  local tasks, todo_path = collect_tasks()
  if #tasks == 0 then vim.notify("Файл TODO пуст", vim.log.levels.INFO); return end

  -- индекс для предварительного выбора
  local default_idx
  if preselect_lnum then
    for i, t in ipairs(tasks) do if t.lnum == preselect_lnum then default_idx = i; break end end
  end

  local function make_entry(item)
    return { value=item, display=item.text, ordinal=item.text, filename=todo_path, lnum=item.lnum }
  end

  pickers.new({}, {
    prompt_title = "Мои TODO",
    finder       = finders.new_table{ results=tasks, entry_maker=make_entry },
    sorter       = conf.generic_sorter({}),
    previewer    = previewers.vim_buffer_vimgrep.new({}, {}),
    default_selection_index = default_idx,
    attach_mappings = function(prompt_bufnr, map)
      local function write_lines(lines)
        local ok, err = pcall(vim.fn.writefile, lines, todo_path)
        if not ok then vim.notify("Запись TODO не удалась: " .. err, vim.log.levels.ERROR) end
      end
      local function reopen_at(lnum)
        actions.close(prompt_bufnr)
        vim.defer_fn(function() M.show_tasks(lnum) end, 15)
      end

      -- delete ---------------------------------------------------------
      map({"i","n"}, "<C-d>", function()
        local e = action_state.get_selected_entry(); if not e then return end
        local lines = vim.fn.readfile(todo_path); if e.lnum > #lines then return end
        table.remove(lines, e.lnum); write_lines(lines); reopen_at(e.lnum)
      end, { desc="Удалить задачу" })

      -- toggle ---------------------------------------------------------
      map({"i","n"}, "<C-l>", function()
        local e = action_state.get_selected_entry(); if not e then return end
        local lines = vim.fn.readfile(todo_path); local idx=e.lnum; if idx>#lines then return end
        local txt = lines[idx]
        if txt:match("%- %[[ ]%]") then lines[idx]=txt:gsub("%[ %]","[x]")
        elseif txt:match("%- %[[xX]%]") then lines[idx]=txt:gsub("%[x%]","[ ]"):gsub("%[X%]","[ ]")
        else vim.notify("Строка не выглядит как TODO", vim.log.levels.WARN); return end
        write_lines(lines); reopen_at(idx)
      end, { desc="Переключить статус" })

      -- enter ----------------------------------------------------------
      actions.select_default:replace(function()
        local e = action_state.get_selected_entry(); actions.close(prompt_bufnr)
        if not e then return end
        vim.schedule(function()
          vim.cmd("edit " .. vim.fn.fnameescape(todo_path))
          vim.api.nvim_win_set_cursor(0, { e.lnum, 0 }); vim.cmd("normal! zz")
        end)
      end)
      return true
    end,
  }):find()
end

return M
