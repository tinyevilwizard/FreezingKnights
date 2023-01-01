new_pal_active=f

pals={
  {armor=12,armor_dark=1,details=8,skin=15,skin_sdw=14,eyes=3,mouth=2},
  {armor=8,armor_dark=2,details=12,skin=4,skin_sdw=2,eyes=9,mouth=14}
}
pal_active_player=1

pal_idxs={{armor=0,skin=0,eyes=0,details=0},{armor=1,skin=1,eyes=1,details=1}}
armor_colors={{armor=12,armor_dark=1},{armor=8,armor_dark=2},{armor=9,armor_dark=2},{armor=3,armor_dark=1},{armor=14,armor_dark=2},{armor=4,armor_dark=2},{armor=2,armor_dark=1},{armor=5,armor_dark=0}} --,{armor=11,armor_dark=3},{armor=5,armor_dark=0},{armor=0,armor_dark=5}}
skin_colors={{skin=15,skin_sdw=14,mouth=2},{skin=4,skin_sdw=2,mouth=8},{skin=14,skin_sdw=2,mouth=8},{skin=6,skin_sdw=13,mouth=2},{skin=13,skin_sdw=2,mouth=8},{skin=11,skin_sdw=3,mouth=2},{skin=12,skin_sdw=13,mouth=2},{skin=0,skin_sdw=0,mouth=2}}
eye_colors={{eyes=3},{eyes=9},{eyes=12},{eyes=5},{eyes=6},{eyes=13},{eyes=14},{eyes=2},{eyes=11},{eyes=4},{eyes=15},{eyes=8}}
details_colors={{details=8},{details=12},{details=13},{details=9},{details=3},{details=11},{details=14},{details=2},{details=4},{details=15},{details=0}}


active_item_idx=1
items=split "armor,skin,eyes,details,continue"

snow_controller=new_snow_controller()

knight_lbls={"knight a","knight b"}

pal_menu=nil

function save_palettes()
  dset(0,pals[1].armor)
  dset(1,pals[1].armor_dark)
  dset(2,pals[1].skin)
  dset(3,pals[1].skin_sdw)
  dset(4,pals[1].eyes)
  dset(5,pals[1].mouth)
  dset(6,pals[1].details)
  dset(7,pals[2].armor)
  dset(8,pals[2].armor_dark)
  dset(9,pals[2].skin)
  dset(10,pals[2].skin_sdw)
  dset(11,pals[2].eyes)
  dset(12,pals[2].mouth)
  dset(13,pals[2].details)
end

function select_last_pal_menu_index()
  pal_menu:select_last()
end

pal_armor_menu_item={
  on_left=function()
    pal_idxs[pal_active_player]["armor"]-=1
    update_colors()
  end,
  on_right=function()
    pal_idxs[pal_active_player]["armor"]+=1
    update_colors()
  end,
  on_confirm=function(self)
    self:select_last()
  end,
  draw=function(self,active)
    if active then
      center_print("⬅️ armor ➡️",65,pals[1].armor==pals[2].armor and 8 or 7,2)
    else
      center_print("armor",65,pals[1].armor==pals[2].armor and 2 or 13)
    end
  end
}

pal_skin_menu_item={
  on_left=function()
    pal_idxs[pal_active_player]["skin"]-=1
    update_colors()
  end,
  on_right=function()
    pal_idxs[pal_active_player]["skin"]+=1
    update_colors()
  end,
  on_confirm=function(self)
    self:select_last()
  end,
  draw=function(self,active)
    if active then
      center_print("⬅️ skin ➡️",75,7,2)
    else
      center_print("skin",75,13)
    end
  end
}

pal_eyes_menu_item={
  on_left=function()
    pal_idxs[pal_active_player]["eyes"]-=1
    update_colors()
  end,
  on_right=function()
    pal_idxs[pal_active_player]["eyes"]+=1
    update_colors()
  end,
  on_confirm=function(self)
    self:select_last()
  end,
  draw=function(self,active)
    if active then
      center_print("⬅️ eyes ➡️",85,7,2)
    else
      center_print("eyes",85,13)
    end
  end
}

pal_details_menu_item={
  on_left=function()
    pal_idxs[pal_active_player]["details"]-=1
    update_colors()
  end,
  on_right=function()
    pal_idxs[pal_active_player]["details"]+=1
    update_colors()
  end,
  on_confirm=function(self)
    self:select_last()
  end,
  draw=function(self,active)
    if active then
      center_print("⬅️ details ➡️",95,7,2)
    else
      center_print("details",95,13)
    end
  end
}

pal_random_menu_item={
  on_confirm=function()
    pal_idxs[pal_active_player]["armor"]=rnd{1,2,3,4,5,6,7,8}
    pal_idxs[pal_active_player]["skin"]=rnd{1,2,3,4,5,6,7,8}
    pal_idxs[pal_active_player]["eyes"]=rnd{1,2,3,4,5,6,7,8,9,10,11,12}
    pal_idxs[pal_active_player]["details"]=rnd{1,2,3,4,5,6,7,8,9,10,11}
    update_colors()
  end,
  on_left=function()
  end,
  on_right=function()
  end,
  draw=function(self,active)
    if active then
      center_print("○ randomize ○",107,7)
    else
      center_print("randomize",107,13)
    end
  end
}

pal_continue_menu_item={
  on_confirm=function()
    if pals[1].armor!=pals[2].armor then
      if pal_active_player==1 then
        init_p2_menu()
      else
        start_new_game()
      end
    end
  end,
  on_left=function()
  end,
  on_right=function()
  end,
  draw=function(self,active)
    if active then
      center_print("○ confirm ○",117,pals[1].armor==pals[2].armor and 8 or 7)
    else
      center_print("confirm",117,pals[1].armor==pals[2].armor and 2 or 12)
    end
  end
}

function init_p1_menu()
  pal_active_player=1
  pal_menu=new_menu(
    {pal_armor_menu_item,pal_skin_menu_item,pal_eyes_menu_item,pal_details_menu_item,pal_random_menu_item,pal_continue_menu_item},
    player1_controller,
    function()
      run()
    end
  )
end

function init_p2_menu()
  pal_active_player=2
  pal_menu=new_menu(
    {pal_armor_menu_item,pal_skin_menu_item,pal_eyes_menu_item,pal_details_menu_item,pal_random_menu_item,pal_continue_menu_item},
    player2_controller,
    function()
      init_p1_menu()
    end
  )
end

init_p1_menu()

function new_pal_update()
  if (not new_pal_active) return
  pal_menu:update()
end

function update_colors()
  pals[pal_active_player].armor=armor_colors[((pal_idxs[pal_active_player]["armor"])%#armor_colors)+1].armor
  pals[pal_active_player].armor_dark=armor_colors[(pal_idxs[pal_active_player]["armor"]%#armor_colors)+1].armor_dark

  pals[pal_active_player].skin=skin_colors[(pal_idxs[pal_active_player]["skin"]%#skin_colors)+1].skin
  pals[pal_active_player].skin_sdw=skin_colors[(pal_idxs[pal_active_player]["skin"]%#skin_colors)+1].skin_sdw
  pals[pal_active_player].mouth=skin_colors[(pal_idxs[pal_active_player]["skin"]%#skin_colors)+1].mouth

  pals[pal_active_player].eyes=eye_colors[(pal_idxs[pal_active_player]["eyes"]%#eye_colors)+1].eyes

  pals[pal_active_player].details=details_colors[(pal_idxs[pal_active_player]["details"]%#details_colors)+1].details
end

function new_pal_draw()
  if (not new_pal_active) return
  cls(0)

  snow_con:draw()

  --line(64,0,64,128,7)

  center_print("select "..knight_lbls[pal_active_player],7,7)

  p1_sspr_x,p1_sspr_y,p2_sspr_x,p2_sspr_y=32,0,32,0
  if pal_active_player==1 then
    fillp(0b1010010110100101)
    rectfill(19,17,60,58,0x5D)
    fillp()
    rect(19,17,60,58,7)
    p1_sspr_x,p1_sspr_y=8,0
  end
  set_ply_colors(pals[1])
  sspr(p1_sspr_x,p1_sspr_y,8,8,24,22,32,32)
  pal()

  if pal_active_player==2 then
    fillp(0b1010010110100101)
    rectfill(67,17,104,58,0x5D)
    fillp()
    rect(67,17,104,58,7)
    p2_sspr_x,p2_sspr_y=8,0
  end
  set_ply_colors(pals[2])
  sspr(p2_sspr_x,p2_sspr_y,8,8,72,22,32,32)
  pal()

  pal_menu:draw()
end