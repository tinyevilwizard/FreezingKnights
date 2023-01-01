snow_con=new_snow_controller()
bgr=new_bgr(8,0x10,0x01)
map=new_map(dget"26",dget"27")

function _init()
	poke(0x5f5c,255) --Prevents auto repeat for btnp().
	fade_in()
	btl_start()
end

function _update60()
  btl_update()
  snow_con:update()
  update_delayed_events()
  update_shake()
end

function _draw()
  cls"0"
  bgr:draw()
	btl_draw()
  process_fade()
--for hb in all(hitboxes) do
--  hb:draw()
--end
end