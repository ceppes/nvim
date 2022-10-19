local M = {}

local function namefunction()
-- do something
end

local function namefunction2()
-- do something
end

function M.setup()
  namefunction()
  namefunction2()
end

return M
