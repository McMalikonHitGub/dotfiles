local programs = require("config/programs")
hl.bind(programs.mainMod .. " + 0xff0d", hl.dsp.exec_cmd("qs ipc call floatingWindow toggle"))
hl.bind(programs.mainMod .. " + 0xff1b", hl.dsp.exec_cmd("qs ipc call floatingWindow back"))
