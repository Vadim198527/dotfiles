-- todo_picker.nvim — минималистичный плагин для учёта задач в Markdown
-- Автор: ChatGPT (OpenAI)
-- Лицензия: MIT

local M = {}

---@class TodoPickerOptions
---@field todo_file string Путь к Markdown‑файлу, куда будут записываться задачи
---@field keymaps table<string,string> Таблица с горячими клавишами (add/list)
local default_opts = {
  todo_file = vim.fn.expand("~/todo.md"),
  keymaps = {
    add = "<leader>ta", -- добавить задачу
    list = "<leader>tt", -- показать список задач
  },
}

---@param opts TodoPickerOptions|nil
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.keymap.set("n", M.opts.keymaps.add, M.add_task,  { desc = "TodoPicker: добавить задачу" })
  vim.keymap.set("n", M.opts.keymaps.list, M.show_tasks, { desc = "TodoPicker: список задач" })
end

-- Внутренняя функция: собираем все строки‑задачи из markdown‑файла
---@return string[]
function M._collect_tasks()
  local path = vim.fn.expand(M.opts.todo_file)
  local tasks = {}
  if vim.fn.filereadable(path) == 1 then
    for line in io.lines(path) do
      if line:match("%- %[[ xX]?%]") then -- "- [ ]" или "- [x]"
        table.insert(tasks, line)
      end
    end
  end
  return tasks
end

-- Добавить новую задачу через vim.ui.input
function M.add_task()
  vim.ui.input({ prompt = "Новая задача: " }, function(input)
    if input == nil or input == "" then return end
    local ok, err = pcall(function()
      local file = assert(io.open(vim.fn.expand(M.opts.todo_file), "a"))
      file:write("- [ ] " .. input .. "\n")
      file:close()
    end)
    if ok then
      vim.notify("Добавлена задача: " .. input, vim.log.levels.INFO)
    else
      vim.notify("Ошибка записи TODO: " .. err, vim.log.levels.ERROR)
    end
  end)
end

-- Показать список задач через Telescope
function M.show_tasks()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope не установлен", vim.log.levels.ERROR)
    return
  end
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf    = require "telescope.config".values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local tasks = M._collect_tasks()
  if #tasks == 0 then
    vim.notify("Файл TODO пуст", vim.log.levels.INFO)
    return
  end

  pickers.new({}, {
    prompt_title = "Мои TODO",
    finder       = finders.new_table { results = tasks },
    sorter       = conf.generic_sorter({}),
    attach_mappings = function(bufnr, map)
      actions.select_default:replace(function()
        actions.close(bufnr)
        local entry = action_state.get_selected_entry()
        if entry then
          vim.notify(entry[1], vim.log.levels.INFO)
        end
      end)
      return true
    end,
  }):find()
end

return M
