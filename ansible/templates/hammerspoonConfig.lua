    -- HAMMERSPOON
-- Require Hammerspoon's window and hotkey modules
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local canvas = require "hs.canvas"
local windowfilter = require "hs.window.filter"

-- ########### VARIABLES ########### --

-- Create a window filter for window focus events
local wf = windowfilter.new():setDefaultFilter()

-- ########### FUNCTIONS ########### --

-- Function to focus on a specific application
function focusOn(appName)
    return function()
        local app = hs.application.find(appName)
        if app then
            app:activate()
        end
    end
end

-- Function to create or update the green border for the focused window
function updateFocusedWindowBorder()
  -- Delete the existing border if it exists
  if focusedWindowBorder then
      focusedWindowBorder:delete()
      focusedWindowBorder = nil
  end

  -- Get the currently focused window
  local fw = hs.window.focusedWindow()
  if fw then
      -- Get the frame of the focused window
      local frame = fw:frame()

      -- Define the border properties with corrected type
      focusedWindowBorder = canvas.new({x=frame.x-2, y=frame.y-2, w=frame.w+4, h=frame.h+4})
      focusedWindowBorder[1] = {
          type = "rectangle",
          action = "stroke",
          strokeColor = {green=1, alpha=1}, -- Green color
          strokeWidth = 5
      }
      focusedWindowBorder:level("floating")
      focusedWindowBorder:show()
  end
end

-- Function to cycle through windows of the same application, including proper cycling
function cycleWindowsOfSameApp()
  local focusedApp = window.focusedWindow():application() -- Get the currently focused application

  if focusedApp then
      local windows = focusedApp:allWindows() -- Get all windows of the application, including minimized
      local visibleWindows = hs.fnutils.filter(windows, function(win) return win:isVisible() end) -- Filter only visible windows

      if #visibleWindows > 1 then -- Ensure there are at least two windows to toggle between
          local focusedWindow = window.focusedWindow()
          local nextWindow = nil

          -- Find the next visible window to focus
          for i, win in ipairs(visibleWindows) do
              if win == focusedWindow then
                  nextWindow = visibleWindows[(i % #visibleWindows) + 1]
                  break
              end
          end

          -- If the next window is found, focus it
          if nextWindow then
              nextWindow:focus()
          else
              -- If no next window was found, focus the first window in the list
              visibleWindows[1]:focus()
          end
      end
  end
end

-- ########### WINDOW FILTERS ########### --

-- Set callbacks for window focus, unfocus, and destruction to manage the border
-- wf:subscribe({windowfilter.windowFocused, windowfilter.windowUnfocused, windowfilter.windowDestroyed}, function()
--   updateFocusedWindowBorder()
-- end)

-- ########### KEY BINDINGS ########### --

-- Binding Cmd + 1 to focus Chrome
hotkey.bind({"cmd"}, "1", focusOn("Brave"))

-- Binding Cmd + 2 to focus Visual Studio Code
hotkey.bind({"cmd"}, "2", focusOn("Code"))
-- hotkey.bind({"cmd"}, "2", focusOn("Zed"))

-- Binding Cmd + 3 to focus iTerm2
hotkey.bind({"cmd"}, "3", focusOn("iTerm2"))

-- Binding Cmd + 4 to focus 
hotkey.bind({"cmd"}, "4", focusOn(""))

-- Binding Cmd + 5 to focus Notion
hotkey.bind({"cmd"}, "5", focusOn("Notion"))


-- Bind Cmd + Ctrl + Tab to cycle through windows of the same application
hotkey.bind({"cmd", "ctrl"}, "tab", cycleWindowsOfSameApp)
