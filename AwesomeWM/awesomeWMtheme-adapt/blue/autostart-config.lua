-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- utils
	--awful.spawn.with_shell("pulseaudio")
	awful.spawn.with_shell("nm-applet")
	awful.spawn.with_shell("xrdb -merge ~/.Xdefaults")

	-- gtk setting deamon
	awful.spawn.with_shell("unity-settings-daemon")

	-- keyboard layouts
	awful.spawn.with_shell("kbdd")
	awful.spawn.with_shell("sleep 1 && bash ~/Documents/scripts/kbdd-setup.sh")

	-- apps
	awful.spawn.with_shell("clipflap")
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart
