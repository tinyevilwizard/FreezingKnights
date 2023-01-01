fading_out=f
local cols,cols2,data={0xfd,0xdf},{0xd1,0x1d},s_split"1,0b0000010000000000|1,0b1000000101000000|1,0b0100101001000000|1,0b0010011100100000|2,0b0101111001011011|1,0b1011010111100101|2,0b0000001001110010|2,0b0000010010100100|2,0b0000100000010100|2,0b0000000001000000"
ply1_pal=dget_to_table"armor,0|armor_dark,1|skin,2|skin_sdw,3|eyes,4|mouth,5|details,6"
ply2_pal=dget_to_table"armor,7|armor_dark,8|skin,9|skin_sdw,10|eyes,11|mouth,12|details,13"
ply1_upgrades=dget_to_table"swd1,28|swd2,29|shd1,30|shd2,31|bow1,32|bow2,33|stf1,34|stf2,35|g_swd1,36|bag1,38|ptn1,40"
ply2_upgrades=dget_to_table"swd1,42|swd2,43|shd1,44|shd2,45|bow1,46|bow2,47|stf1,48|stf2,49|g_swd1,50|bag1,52|ptn1,54"
ply1_hp=dget"56"
ply2_hp=dget"57"
max_potions=dget"60"
gold=dget"58"

function _init()
	poke(0x5f5c,255) --Prevents auto repeat for btnp().
	fade_in()
	new_delayed_event(100,function()
	  music"1"
	end)
end

function _update60()
  update_delayed_events()

  if btnp(confirm_btn) and not fading_out_end_scene then
    fading_out_end_scene=t
    fade_out(10,function()
      stats_screen_active=t
      fade_in(10)
    end)
  end

  if stats_screen_active and btnp(confirm_btn) and not fading_out_stats_screen then
    fade_out(10,function()
      fading_out_stats_screen=t
      load_cart"start"
    end)
  end
end

function _draw()
  if not stats_screen_active then
    cls(2)
    local y=8
    rectfill(0,0,128,y,cols2[1])
    for l in all(data) do
      fillp(l[2])
      rectfill(0,y,128,y+3,cols2[l[1]])
      y+=4
    end
    y=43
    fillp()
    for l in all(data) do
      fillp(l[2])
      rectfill(0,y,128,y+3,cols[l[1]])
      y+=4
    end
    fillp()

    circfill(108,58,12,15)

    pal(6,1)
    for coo in all(s_split"-23,12|0,13|30,12|50,20|56,24|73,24|104,24") do
      local mx,my=coo[1],coo[2]+30
      spr(96,mx,my,4,4)
      rectfill(mx,my+16,mx+32,my+32,1)
    end
    rectfill(0,70,128,128,1)
    pal()
    pal(1,0)
    spr(128,0,64,16,8)
    pal()
    ?"the end",4,120,7

  else
    cls(0)
    --line(64,0,64,128,14)
    --line(63,0,63,128,14)
    center_print("end results",8,7)
    line(39,15,86,15,7)
    center_print(dget"16">=1 and "dIFFICULTY: hard" or "dIFFICULTY: normal",22,6)
    for p in all({{48,ply1_pal,ply1_upgrades,ply1_hp},{88,ply2_pal,ply2_upgrades,ply2_hp}}) do
      y=p[1]
      upgrades=p[3]

      set_ply_colors(p[2])
      spr(64,60,y-14)
      pal()

      rect(34,y-4,93,y+19,13)

      x=36
      if upgrades.swd1==1 then
        if upgrades.swd2==1 then
          pal(5,2)
          pal(6,9)
        end
        spr(66,x,y)
        pal()
      else
        spr(73,x,y)
      end
      x+=12

      if upgrades.shd1==1 then
        if upgrades.shd2==1 then
          pal(5,2)
          pal(6,9)
        end
        spr(67,x,y)
        pal()
      else
        spr(73,x,y)
      end
      x+=12

      if upgrades.bow1==1 then
        if upgrades.bow2==1 then
          pal(5,2)
          pal(6,9)
        end
        spr(68,x,y)
        pal()
      else
        spr(73,x,y)
      end
      x+=12

      if upgrades.stf1==1 then
        if upgrades.stf2==1 then
          pal(5,2)
          pal(6,9)
        end
        spr(69,x,y)
        pal()
      else
        spr(73,x,y)
      end
      x+=12

      if upgrades.g_swd1==1 then
        spr(70,x,y)
        pal()
      else
        spr(73,x,y)
      end
      x+=12

      center_print("♥"..p[4],y+11,8,1)
    end

    print(potion_char..f_num(max_potions),33,116,14)
    print(money_char..f_num(gold,t),75,116,9)
  end
  process_fade()
end