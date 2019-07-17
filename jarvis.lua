settings_table = {
    {
        -- Edit this table to customise your rings.
        -- You can create more rings simply by adding more elements to settings_table.
        -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
        name='time',
        -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
        arg='%I.%M',
        -- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
        max=12,
        -- "bg_colour" is the colour of the base ring.
        bg_colour=0xFFFFFF,
        -- "bg_alpha" is the alpha value of the base ring.
        bg_alpha=0.1,
        -- "fg_colour" is the colour of the indicator part of the ring.
        fg_colour=0xFFFFFF,
        -- "fg_alpha" is the alpha value of the indicator part of the ring.
        fg_alpha=0.2,
        -- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
        x=100, y=150,
        -- "radius" is the radius of the ring.
        radius=0,
        -- "thickness" is the thickness of the ring, centred around the radius.
        thickness=5,
        -- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
        start_angle=0,
        -- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
        end_angle=360
    },
           {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0x49d3fc,
        bg_alpha=0.4,
        fg_colour=0xffffff,
        fg_alpha=0.8,
        x=296, y=652,
        radius=120,
        thickness=30,
        start_angle=-110,
        end_angle=43
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
	bg_colour=0x0,
        bg_alpha=0.8,
	fg_colour=0xa3294b,
        fg_alpha=0.8,
        x=296, y=652,
        radius=109,
        thickness=6,
        start_angle=45,
        end_angle=90
    },
    
   {
        name='cpu',
        arg='cpu2',
        max=100,
	bg_colour=0x49d3fc,
        bg_alpha=0.4,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=296, y=652,
        radius=116,
        thickness=6,
        start_angle=45,
        end_angle=90
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
	bg_colour=0x49d3fc,
        bg_alpha=0.4,
        fg_colour=0xa3294b,
        fg_alpha=0.8,
        x=296, y=652,
        radius=124,
        thickness=6,
        start_angle=45,
        end_angle=90
    },
    {
        name='cpu',
        arg='cpu4',
        max=100,
	bg_colour=0x49d3fc,
        bg_alpha=0.4,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=296, y=652,
        radius=132,
        thickness=6,
        start_angle=45,
        end_angle=90
    },
--[[memory]]
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0x49d3fc,
        bg_alpha=0.4,
        fg_colour=0xebbf3b,
        fg_alpha=0.8,
        x=296, y=652,
        radius=130,
        thickness=10,
        start_angle=92,
        end_angle=248
    },
}




clock_x=100
clock_y=150


require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    
    -- Draw indicator ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)        
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0
        
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
        
        value=tonumber(str)
        pct=(value or 0)/pt['max']
        
        draw_ring(cr,pct,pt)
    end
    
    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    
    local cr=cairo_create(cs)    
    --test
    cairo_surface_destroy(cs)

    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)
    
    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
    end
    
	cairo_destroy(cr)
end
