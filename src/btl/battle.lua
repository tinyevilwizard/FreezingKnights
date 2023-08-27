--ply1,ply2=nil,nil
--show_game_over=f
mid_pos,potions,max_potions,gold,btl_ended,celebrate=parse_pos"60,81",dget"59",dget"60",dget"58",f,f
local turn_act_index,acts,btl_active,btl_intro_done,ply_spws,enm_spws=0,{},f,f,{parse_pos"20,90",parse_pos"28,72"},{
  parse_pos"75,81",
  parse_pos"83,72",
  parse_pos"91,90",
  parse_pos"100,81",
  parse_pos"108,72",
  parse_pos"116,90",
}

function btl_start()
  new_delayed_event(60,function() music("0",nil,3) end)
  btl_active,acts,ply1,ply2=t,{},
  new_btl_ply(
    confirm_btn,confirm_btn_lbl,player1_controller,
    dget_to_table"armor,0|armor_dark,1|skin,2|skin_sdw,3|eyes,4|mouth,5|details,6",
    dget_to_table"swd1,28|swd2,29|shd1,30|shd2,31|bow1,32|bow2,33|stf1,34|stf2,35|g_swd1,36|bag1,38|ptn1,40",
    {name="knight a",spw=ply_spws[1],sts={hp=dget"56"}}
  ),
  new_btl_ply(
    cancel_btn,cancel_btn_lbl,player2_controller,
    dget_to_table"armor,7|armor_dark,8|skin,9|skin_sdw,10|eyes,11|mouth,12|details,13",
    dget_to_table"swd1,42|swd2,43|shd1,44|shd2,45|bow1,46|bow2,47|stf1,48|stf2,49|g_swd1,50|bag1,52|ptn1,54",
    {name="knight b",spw=ply_spws[2],sts={hp=dget"57"}}
  )
  local btl_enms,btl_enms_ordered={},{}
  for k,v in next,split"20,21,22,23,24,25" do
    local enm_fn=enms[dget(v)]
    local enm=enm_fn and enm_fn {spw=enm_spws[k],act_in_front=btl_enms_ordered[k-3]}
    if enm then
      add(btl_enms,enm)
      btl_enms_ordered[k]=enm
    end
  end
  for e in all(btl_enms_ordered) do
    local x_offset=0
    if (#btl_enms_ordered<5) x_offset=(#btl_enms_ordered==1 and 33 or #btl_enms_ordered<=3 and 17 or #btl_enms_ordered<=4 and 8 or 0) + (init_enms_x_offset and init_enms_x_offset or 0)
    e.spw.x+=x_offset
    e.pos.x+=x_offset
    e.atk_pos.x+=x_offset
  end
  multi_add(acts,merge({ply1,ply2},btl_enms))
end

function btl_draw()
  if (not btl_active) return
  map:draw()
  btl_draw_objects()
  snow_con:draw()

  draw_ply_sts(3,ply1)
  draw_ply_sts(27,ply2)

  sm_tb(99,117,124,1)
  ? money_char,101,118,9
  ? f_num(gold,t),110,118,7

  sm_tb(75,117,96,1)
  ? potion_char,77,118,14
  ? f_num(potions),86,118,potions >= max_potions and 15 or 7

  local menu,hint=ply1.menu or ply2.menu,ply1.hint or ply2.hint
  if (menu) menu:draw()
  if (hint) sm_tb(3,3,124,btl_turn_act().pal.armor,hint)

  if show_game_over then
    cls()
    ?"game over",47,50,7
    ?confirm_btn_lbl.." rETRY (+2"..potion_char..")",34,70
    ?cancel_btn_lbl.." mAIN MENU",40,80
  end
end

function btl_update()
  if (not btl_active) return
  for a in all(acts) do
    a:update()
  end
  if not btl_intro_done then
    if ply1.intro_done and ply2.intro_done then
      btl_intro_done=t
      new_delayed_event(240,btl_start_next_turn)
    end
  end
  if show_game_over then
    if btnp(confirm_btn) then
      run()
    elseif btnp(cancel_btn) then
      load_cart"start"
    end
  end
end

function btl_start_next_turn()
  if (btl_ended) return
  turn_act_index+=1
  if (turn_act_index>#acts) turn_act_index=1
  btl_turn_act():start_turn()
end

function btl_draw_objects()
  local accs=accs()
  local sorted_objs=clone(merge(acts,accs,map_accs))
  sort(sorted_objs, function(a,b) return a.pos.y<b.pos.y end)
  draw_act_sec(sorted_objs,"draw_sdw")
  draw_act_sec(sorted_objs,"draw")
  draw_act_sec(sorted_objs,"draw_status_effects")
  draw_act_sec(sorted_objs,"draw_dmg_lbl")
end

function btl_turn_act()
  return acts[turn_act_index]
end

function btl_save()
  dset(58,gold)
  dset(59,potions)
end

function find_acts(inc_dead,type,only_front,act_to_exclude)
  list={}
  for a in all(acts) do
    if (a.type==type and (not a.dead or inc_dead) and (not only_front or not a:has_act_in_front())) add(list,a)
  end
  if (act_to_exclude) del(list,act_to_exclude)
  return list
end

function accs()
  local accs={}
  for a in all(acts) do
    if a.selected_acn then
      for b in all(a.selected_acn.accs) do
        add(accs,b)
      end
    end
  end
  return accs
end

function enm_acts(inc_dead,act_to_exclude)
  return find_acts(inc_dead,"enm",f,act_to_exclude)
end

function front_enm_acts(inc_dead)
  return find_acts(inc_dead,"enm",t)
end

function ply_acts(inc_dead)
  return find_acts(inc_dead,"ply")
end

function ply_defending()
  return btl_turn_act() and btl_turn_act().type=="enm"
end

function handle_death()
  if #enm_acts()==0 then
    btl_ended=t
    new_delayed_event(120,function()
      celebrate=t
      memcpy(0x3100,0x4300,0x100)
      memcpy(0x3200,0x4400,0x1100)
      ply1:heal(99)
      ply2:heal(99)
      sfx"60"
      music"50"
    end)
    fade_out(600,function()
      btl_save()
      load_cart"map"
    end)
  elseif #ply_acts()==0 then
    btl_ended=t
    fade_out(120,function()
      music(-1,1000)
      fade_in()
      show_game_over=t
      dset(59,dget"59"+2)
    end)
  end
end

function draw_act_sec(acts,draw_fn)
  for act in all(acts) do
    if (act[draw_fn]) act[draw_fn](act)
  end
end

function draw_ply_sts(x,ply)
  sm_tb(x,117,x+21,ply.pal.armor_dark)
  ? "♥",x+2,118,ply.pal.armor
  ? f_num(ply.active_sts.hp),x+11,118,ply.active_sts.hp >= ply.sts.hp and 15 or 7
end