require("checkmate").setup({
  enabled = true,
  list_continuation = false,
  todo_count_position = "inline",
  files = { "*.md" },
  ui = {
    picker = "snacks",
  },
  todo_states = {
    -- unchecked = { marker = "󰋙" },
    -- checked = { marker = "󰫈" },
    -- cancelled = { marker = "󰫊", markdown = "#", type = "complete" },
    -- in_progress = { marker = "󰁘", markdown = "-", type = "incomplete" },
    -- important = { marker = "", markdown = "!", type = "incomplete" },
    -- pending = { marker = "󱃲", markdown = "@", type = "inactive" },
    -- blocked = { marker = "󰛡", markdown = "#", type = "inactive" },
    unchecked = { marker = "[ ]", order = 1 },
    checked = { marker = "[X]", order = 2 },
    important = { marker = "[!]", markdown = "!", type = "incomplete" },
    cancelled = { marker = "[#]", markdown = "#", type = "complete" },
    ongoing = { marker = "[-]", markdown = "-", type = "incomplete" },
    pending = { marker = "[@]", markdown = "@", type = "inactive" },
  },
  metadata = {
    pending = {
      style = { fg = "#c1a387", bg = "#5d4f40", bold = true },
      on_add = function(todo)
        require("checkmate").set_todo_state(todo, "pending")
      end,
      on_remove = function(todo)
        require("checkmate").set_todo_state(todo, "unchecked")
      end,
      get_value = function()
        return "INSERT REASON"
      end,
      jump_to_on_insert = "value",
      select_on_insert = true,
    },
    project = {
      aliases = { "pro", "proj" },
      style = { fg = "#f8e2a0", bold = true, reverse = true },
    },
    done = {
      aliases = { "completed", "finished" },
      style = { fg = "#ace1af", reverse = true },
      get_value = function()
        return tostring(os.date("%y-%m-%d %H:%M"))
      end,
      key = "<leader>td",
      on_add = function(todo)
        require("checkmate").set_todo_state(todo, "checked")
      end,
      on_remove = function(todo)
        require("checkmate").set_todo_state(todo, "unchecked")
      end,
      sort_order = 30,
    },
    pri = {
      aliases = { "priority" },
      key = "<leader>tp",
      style = function(context)
        local value = context.value:lower()
        if value == "high" then
          return { fg = "#e86045", bold = true, reverse = true }
        elseif value == "mid" then
          return { fg = "#e68d53", reverse = true }
        elseif value == "low" then
          return { fg = "#c1a387", reverse = true }
        else -- fallback
          return { fg = "#afd2e9" }
        end
      end,
      get_value = function()
        return "mid" -- Default priority
      end,
      choices = function()
        return { "low", "medium", "high" }
      end,
      sort_order = 10,
      jump_to_on_insert = "value",
      select_on_insert = true,
    },
  },
  keys = {
    ["<leader>tf"] = { rhs = "<cmd>Checkmate select_todo<CR>", desc = "Pick todo items", modes = { "n" } },
    ["<leader>tp"] = { rhs = "<cmd>Checkmate metadata toggle pri<CR>", desc = "Toggle 'priority' tag", modes = { "n" } },
    ["<leader>td"] = { rhs = "<cmd>Checkmate metadata toggle done<CR>", desc = "Toggle 'done' tag", modes = { "n" } },
    ["<leader>t@"] = { "<cmd>Checkmate metadata toggle pending<CR>", "Toggle 'pending' tag", { "n" } },
    ["<leader>t#"] = { "<cmd>lua require('checkmate').toggle('cancelled')<CR>", "Set item to 'cancelled'", { "n" } },
    ["<leader>t-"] = {
      rhs = "<cmd>lua require('checkmate').toggle('ongoing')<CR>",
      desc = "Set item to 'ongoing'",
      modes = { "n" },
    },
    ["<leader>t!"] = {
      rhs = "<cmd>lua require('checkmate').toggle('important')<CR>",
      desc = "Set item to 'important'",
      modes = { "n" },
    },
  },
  style = {
    CheckmateUncheckedMarker = { bold = false },
    CheckmateCheckedMarker = { fg = "#6b6055", bold = false },
    CheckmateCheckedMainContent = { fg = "#6b6055", strikethrough = true },
    CheckmateCancelledMarker = { fg = "#e86045" },
    CheckmateCancelledMainContent = { fg = "#e86045", strikethrough = true },
    CheckmateImportantMarker = { fg = "#e86045" },
    CheckmateImportantMainContent = { fg = "#e86045" },
    CheckmatePendingMarker = { fg = "#c1a387", bg = "#4c4134" },
    CheckmatePendingMainContent = { fg = "#c1a387", bg = "#4c4134" },
    CheckmateOngoingMarker = { fg = "#ace1af" },
    CheckmateOngoingMainContent = { fg = "#ace1af" },
    CheckmateTodoCountIndicator = { fg = "#f8e2a0" },
  },
})
