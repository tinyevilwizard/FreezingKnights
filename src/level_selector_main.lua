snow_con=new_snow_controller()

function _init()
	poke(0x5f5c,255) --Prevents auto repeat for btnp().
	level_selector:init()
	new_delayed_event(60,function() music(0,nil,3) end)
end

function _update60()
  level_selector:update()
  snow_con:update()
  update_delayed_events()
end

function _draw()
  cls(1)
	level_selector:draw()
  process_fade()
end