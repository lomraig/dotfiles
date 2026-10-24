hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,

		border_size = 2,

		col = {
			active_border = {
				colors = { "rgba(0066ccff)" },
				angle = 45,
			},
		},
	},


	decoration = {
		rounding = 5,

		dim_special = 0.5,
	},
})

hl.curve("snap", { type = "bezier", points = { {0.2, 0.9}, {0.1, 1} } })

hl.animation({ leaf = "global",           enabled = true, speed = 1,   bezier = "snap" })
hl.animation({ leaf = "layers",           enabled = true, speed = 1,   bezier = "snap", style = "fade" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1, bezier = "snap", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "snap", style = "slidevert" })
