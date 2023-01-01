snow_con=new_snow_controller()
bgr=new_bgr(8,0x10,0x01)
map=new_map(dget"26",dget"27")

function _init()
	poke(0x5f5c,255) --Prevents auto repeat for btnp().
	rst:init()
	new_delayed_event(120,function() music(0,nil,7) end)
end

function _update60()
  rst:update()
  snow_con:update()
  update_delayed_events()
end

function _draw()
  cls(1)
  bgr:draw()
	rst:draw()
  process_fade()
end