-- watch https://www.youtube.com/watch?v=bHtpLEoRKmg
-- vim: ts=4 sw=4 noet ai cindent syntax=lua
--[[
Conky, a system monitor, based on torsmo

Any original torsmo code is licensed under the BSD license

All code written since the fork of torsmo is licensed under the GPL

Please see COPYING for details

Copyright (c) 2004, Hannu Saransaari and Lauri Hakkarainen
Copyright (c) 2005-2012 Brenden Matthews, Philip Kovacs, et. al. (see AUTHORS)
All rights reserved.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

conky.config = {
    alignment = 'bottom_left',
    background = false,
    border_width = 1,
    cpu_avg_samples = 2,
	default_color = '8ec6f7',
    default_outline_color = 'white',
    default_shade_color = 'red',
    draw_borders = false,
    draw_graph_borders = true,
    draw_outline = false,
    draw_shades = false,
    use_xft = true,
    font = 'Courier:size=10:bold',
    gap_x = 70,
    gap_y = 65,
    minimum_height = 900,
	minimum_width = 900,
    net_avg_samples = 2,
--  no_buffers = true,
	double_buffer = true,
    out_to_console = false,
    out_to_stderr = false,
    extra_newline = false,
    own_window = true,
	own_window_transparent = true,
	own_window_argb_visual  = true,
	own_window_argb_value = 0,
    own_window_class = 'Conky',
    own_window_type = 'desktop',
    stippled_borders = 0,
    update_interval = 1.0,
    uppercase = false,
    use_spacer = 'none',
    show_graph_scale = false,
    show_graph_range = false,
	color1 = "8EC6F7", --blue
	color2 = "fb2503", --red
	color3 = "40d617", --green
	color4 = "31245c", --violet
	color5 = "dfd00f",  --yellow
	color6 = "ebbf3b",  --yellow
	color7 = "6D182D", --pink from screen
	lua_load = '~/.config/conky-configs/jarvis.lua',
	lua_draw_hook_post = 'clock_rings'
}

conky.text = [[
${color FFFFFF}${font Michroma:size=18}${goto 120}${voffset 500}${cpu cpu0}${font Courier:size=18}%
${color FFFFFF}${goto 120}${font Michroma:size=18}CPU
$color7${font Michroma:size=18}${goto 350}${voffset 200}${memperc}${font Courier:size=18}%
$color7${goto 350}${font Michroma:size=18}RAM
]]
