-- MouseChaseSpaces - A Hammerspoon module to switch between spaces using keyboard shortcuts.
-- It binds Cmd+Ctrl + 1 to Cmd+Ctrl + n to switch to the corresponding space.
-- The module automatically populates a list of all available spaces and binds hotkeys to them.
-- It also includes a function to move the cursor to the center of the target space.

local M = {}

M.name = "MouseChaseSpaces"
M.version = "1.0"
M.author = "http://github.com/jeffchien"
M.license = "MIT - https://opensource.org/licenses/MIT"
M.logger = hs.logger.new("MouseChaseSpaces")

local option = {
    space_settle_delay = 0.35 -- Time in seconds for macOS to fully settle on the new space.
}

local spacesList = {}

local function moveCursorToActiveSpaceCenter(fromScreenID, toScreenID, fromSpaceID, toSpaceID)
    -- Wait for a brief moment to ensure macOS has fully updated the active space and its associated screen.
    if fromSpaceID == toSpaceID then
        return
    end

    hs.spaces.gotoSpace(toSpaceID)

    local settleTimer = nil
    settleTimer = hs.timer.doAfter(option.space_settle_delay, function()
        if settleTimer then
            settleTimer:stop()
        end

        if fromScreenID == toScreenID then
            return
        end

        local screenObj = hs.screen.find(toScreenID)
        local screenFrame = screenObj:frame()
        local relativeCenter = {
            x = screenFrame.w / 2,
            y = screenFrame.h / 2
        }
        hs.eventtap.leftClick(screenObj:localToAbsolute(relativeCenter))
    end)
end

local function prepareSpaceList()
    -- Populate the spacesList with the IDs of all spaces on all screens.
    -- It iterates through each screen, then through the spaces on that screen,
    -- and adds each space ID to the spacesList.  This allows for easy access
    -- to a list of all available spaces.
    for _, screenObj in ipairs(hs.screen.allScreens()) do
        for _, spaceID in ipairs(hs.spaces.allSpaces()[screenObj:getUUID()]) do
            table.insert(spacesList, spaceID)
        end
    end
end

local function prepareHotkeyHandler()
    -- Binds keyboard shortcuts (Cmd+Ctrl + 1 to Cmd+Ctrl + n) to switch between spaces.
    -- Each keybind corresponds to a space in the spacesList.
    for i = 1, #spacesList do -- bind key 1 - n for switching between spaces
        hs.hotkey.bind({ "cmd", "ctrl" }, tostring(i), function()
            -- Simulate the original space switch hotkey press
            local fromSpaceID = hs.spaces.focusedSpace()
            local toSpaceID = spacesList[i]

            local fromScreenID = 1
            local toScreenID = (i - 1) // 3 + 1
            local index = 1
            for index, value in ipairs(spacesList) do
                if value == fromSpaceID then
                    fromScreenID = (index - 1) // 3 + 1
                    break
                end
            end
            moveCursorToActiveSpaceCenter(fromScreenID, toScreenID, fromSpaceID, toSpaceID)
        end)
    end
end

function M:init()
    prepareSpaceList()
    prepareHotkeyHandler()
end

return M
