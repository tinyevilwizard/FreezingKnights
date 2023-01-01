--start_game=f
snow_con=new_snow_controller()
bgr=new_bgr(8,0x10,0x01)
set_mode()

function _init()
	--poke(0x5f5c,255) --Prevents auto repeat for btnp().
	fade_in(110)
	new_delayed_event(10,function() music(0,nil,3) end)
	memcpy(0x4300,0x3100,0x100)
  memcpy(0x4400,0x3200,0x1100)
end

function _update60()
  if not intro1.done then
    intro1:update()
  elseif not intro2.done then
    intro2:update()
  elseif not intro3.done then
    intro3:update()
  else
    update_start_menu()
    new_pal_update()
    snow_con:update()
  end
  update_delayed_events()
end

function _draw()
  cls(0)
  if not intro1.done then
    intro1:draw()
  elseif not intro2.done then
    intro2:draw()
  elseif not intro3.done then
    intro3:draw()
  else
    bgr:draw()
    draw_start_menu()
    new_pal_draw()
  end
  process_fade()
end

