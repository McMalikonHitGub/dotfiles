local programs = require("config/programs")
hl.bind(programs.mainMod .. " + Q",                         hl.dsp.exec_cmd(programs.terminal))
hl.bind(programs.mainMod .. " + C",                         hl.dsp.window.close())
hl.bind(programs.mainMod .. " + M",                         hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(programs.mainMod .. " + E",                         hl.dsp.exec_cmd(programs.fileManager))
hl.bind(programs.mainMod .. " + V",                         hl.dsp.window.float({ action = "toggle" }))
hl.bind(programs.mainMod .. " + R",                         hl.dsp.exec_cmd(programs.menu))
hl.bind(programs.mainMod .. " + O",                         hl.dsp.exec_cmd("obsidian"))
hl.bind(programs.mainMod .. " + P",                         hl.dsp.window.pseudo())
hl.bind(programs.mainMod .. " + J",                         hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(programs.mainMod .. " + B",                         hl.dsp.exec_cmd(programs.browser))
hl.bind(programs.mainMod .. " + left",                      hl.dsp.focus({ direction = "left" }))
hl.bind(programs.mainMod .. " + right",                     hl.dsp.focus({ direction = "right" }))
hl.bind(programs.mainMod .. " + up",                        hl.dsp.focus({ direction = "up" }))
hl.bind(programs.mainMod .. " + down",                      hl.dsp.focus({ direction = "down" }))
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(programs.mainMod .. " + " .. key,               hl.dsp.focus({ workspace = i}))
    hl.bind(programs.mainMod .."+ SHIFT +" .. key,       hl.dsp.window.move({ workspace = i }))

end

hl.bind(programs.mainMod .. " + L ",                       hl.dsp.exec_cmd("/home/malik/.config/hypr/scripts/hyprlock.sh"))

hl.bind(programs.mainMod .. " + S",                         hl.dsp.workspace.toggle_special("magic"))
hl.bind(programs.mainMod .. " + SHIFT + S",                 hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(programs.mainMod .. " + mouse_down",                hl.dsp.focus({ workspace = "e+1" }))
hl.bind(programs.mainMod .. " + mouse_up",                  hl.dsp.focus({ workspace = "e-1" }))
hl.bind(programs.mainMod .. " + mouse:272",                 hl.dsp.window.drag(),   { mouse = true })
hl.bind(programs.mainMod .. " + mouse:273",                 hl.dsp.window.resize(), { mouse = true })
hl.bind("F3", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio/louder.sh"), { locked = true, repeating = true })
hl.bind("F2", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio/quieter.sh"),      { locked = true, repeating = true })
hl.bind("F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio/mute.sh"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness/brighter.sh"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness/darker.sh"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(programs.mainMod .. " + A", hl.dsp.exec_cmd("code"))
