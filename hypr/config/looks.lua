local style = require("config/txt_reader")


hl.config({
    general = {
        gaps_in     = style.gap,
        gaps_out    = style.gap,
        border_size = style.borderwidth,
        col = {
            active_border = {
                colors      = {style.bordercolor},
                angle       = 45},
            inactive_border = {
                colors      = {"rgba(139,0,0,0.0)"},
                angle       =45}
        },
        resize_on_border= false,
        allow_tearing   = true,
        layout          = "scrolling",
        snap = {
            enabled = false,
            border_overlap = true,
        },
    },
    decoration = {
        rounding        = style.radius, 
        rounding_power  = 2,
        active_opacity  = 1.0,
        inactive_opacity= 0.8,
        shadow = {
            enabled     = false,
            range       = 100,
            render_power= 100,
            color       = "rgba(0,0,0,1)",
        },
        blur = {
            enabled = true,
            size    = 7,
            passes  = 1,
            vibrancy= 0.1,
        },
    },
    animations = {
        enabled     = true,
    },
})

