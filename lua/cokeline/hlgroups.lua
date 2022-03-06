local cmd = vim.cmd

---@class Hlgroup
---@field name  string
---@field gui   string
---@field guifg string
---@field guibg string
local Hlgroup = {}
Hlgroup.__index = Hlgroup

---Sets the highlight group, then returns a new `Hlgroup` table.
---@param name  string
---@param gui   string
---@param guifg string
---@param guibg string
---@return Hlgroup
Hlgroup.new = function(name, gui, guifg, guibg)
  -- Clear the highlight group before (re)defining it.
  cmd(("highlight clear %s"):format(name))
  cmd(
    ("highlight %s gui=%s guifg=%s guibg=%s"):format(name, gui, guifg, guibg)
  )

  local hlgroup = {
    name = name,
    gui = gui,
    guifg = guifg,
    guibg = guibg,
  }
  setmetatable(hlgroup, Hlgroup)
  return hlgroup
end

---Embeds some text in a highlight group.
---@param self Hlgroup
---@param text string
---@return string
Hlgroup.embed = function(self, text)
  return ("%%#%s#%s%%*"):format(self.name, text)
end

return {
  Hlgroup = Hlgroup,
}
