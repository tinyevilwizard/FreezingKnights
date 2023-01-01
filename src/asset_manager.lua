carts={
	{
		name="battle1.p8",
		cpy_sprs1=true,
		cpy_sprs2=true,
		cpy_map=true,
		cpy_sound=true
	},
	{
  	name="battle2.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=true,
  	cpy_map=true,
  	cpy_sound=true
  },
	{
  	name="battle3.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=true,
  	cpy_sound=true
  },
  {
  	name="boss1.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss2.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss3.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss4.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss5.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss6.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="boss7.p8",
  	cpy_sprs1=true,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="rest.p8",
  	cpy_sprs1=false,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="start.p8",
  	cpy_sprs1=false,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  },
  {
  	name="map.p8",
  	cpy_sprs1=false,
  	cpy_sprs2=false,
  	cpy_map=false,
  	cpy_sound=true
  }
}

cls()

? "press 🅾️ to copy assets data to"
? "game carts. (sprites, map,"
? "sounds)"
? ""
? "target carts: "
for cart in all(carts) do
  ? "- "..cart.name
end
? ""

done=false

function _update60()
  if btn(4) and not done then
    for cart in all(carts) do
      if cart.cpy_sprs1 then
        cstore(0x0,0x0,0x1000,cart.name) -- Sprites
        cstore(0x3000,0x3000,0x100,cart.name) -- Sprite flags (only used for maps in first half of sprites)
        ? "copied sprites to "..cart.name
      end
      if cart.cpy_sprs2 then
        cstore(0x1000,0x1000,0x1000,cart.name) -- Add. sprites (shared with map (bottom))
        ? "copied add. sprites to "..cart.name
      end
    	if cart.cpy_map then
    	  cstore(0x2000,0x2000,0x1000,cart.name) -- Map (top)
    	  ? "copied map to "..cart.name
    	end
--    	if cart.cpy_music then
--        cstore(0x3100,0x3100,0x100,cart.name) -- Music
--        ? "copied music to "..cart.name
--      end
      if cart.cpy_sound then
        first_non_music_sfx=53
        non_music_sfx_address=0x3200+first_non_music_sfx*68
        non_music_sfx_length=0x4300-non_music_sfx_address --0x02ec
        cstore(non_music_sfx_address,non_music_sfx_address,non_music_sfx_length,cart.name) -- Sound effects
        ? "copied sounds to "..cart.name
      end
    end
    ? "done!"
    ? ""
    done=true
  end
end