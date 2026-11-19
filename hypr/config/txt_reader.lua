local radius_file =         assert(io.open("/home/malik/.config/hypr/config/radius.txt", "r"))
local radius =              radius_file:read("*a"):gsub("%s+$", "")

local bordercolor_file =    assert(io.open("/home/malik/.config/hypr/config/bordercolor.txt", "r"))

local gap_file =            assert(io.open("/home/malik/.config/hypr/config/gap.txt", "r"))
local gap =                 gap_file:read("*a"):gsub("%s+$", "")

local borderwidth_file =    assert(io.open("/home/malik/.config/hypr/config/borderwidth.txt", "r"))
local borderwidth =         borderwidth_file:read("*a"):gsub("%s+$", "")

local widgetcolor_file =    assert(io.open("/home/malik/.config/hypr/config/widgetcolor.txt", "r"))

local textcolor_file =      assert(io.open("/home/malik/.config/hypr/config/textcolor.txt", "r"))


local style = {
    radius =        tonumber(radius),
    bordercolor =   bordercolor_file:read("*a"):gsub("%s+$", ""),
    gap =           tonumber(gap) ,
    borderwidth =   tonumber(borderwidth),
    widgetcolor =   widgetcolor_file:read("*a"):gsub("%s+$", ""),
    textcolor =     textcolor_file:read("*a"):gsub("%s+$", "")
}

radius_file:close()
bordercolor_file:close()
gap_file:close()
borderwidth_file:close()
widgetcolor_file:close()
textcolor_file:close()



return style
