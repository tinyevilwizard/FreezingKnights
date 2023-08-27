init_enms_x_offset,map_x,final_boss_pal_fn=-8,0,function(self) pal(5,0) end
enms[400]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=200}
  a:set_acns"final_boss_sneak_spell,final_boss_shadows,final_boss_spell,final_boss_spike,final_boss_teleport,md_unprotect,md_pwr_down,md_protect,md_unprotect"
  a.name,a.die_event,a.body_hb.offset_pos,a.ui_hgt,a.two_turns,a.atk_pos,a.elv,a.wdt,a.hgt,a.atk_pos,a.anim_manager,a.pal_fn="corruption core",a.die,parse_pos"-5,10",26,t,pos_clone(a.spw,-16),14,32,32,pos_clone(a.spw,-18),new_anim_manager(
    new_anims"idle$128,30|132,30|136,30|140,30$t&die$140,240|192,180|196,240|196,2000&sneak_spell$140,60|192,2|200,2|196,40|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,25,shoot_spell|196,200,shoot_spell|192,10|140,10|140,20,set_done_acting&shadows$140,60|192,2|200,2|196,40|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,20,spawn_shadows|196,120,spawn_shadows|192,10|140,10|140,20,set_done_acting&spell$140,60|192,2|200,2|196,40|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,35,shoot_spell|196,60,shoot_spell|192,10|140,10|140,20,set_done_acting&spike$140,60|192,2|200,2|196,40|196,140,start_spike|192,10,clear_acn_acc|140,10|140,20,set_done_acting&teleport$140,60|192,2|200,2|196,20|196,120,teleport|192,10|140,60|192,2|200,2|196,40|196,60,shoot_spell|196,60,shoot_spell|196,60,shoot_spell|196,60,shoot_spell|192,10|140,60|192,2|200,2|196,20|196,120,teleport|192,10|140,10|140,20,set_done_acting&still_acn$140,60|192,2|200,2|196,40|196,60,exe_still_acn|192,10|140,10|140,20,set_done_acting"
  ,a),final_boss_pal_fn
  a.draw=function(self)
    self:global_draw()
    if not self.dead then
      self:draw_spr()
      spr(236,self.pos.x-16,self.pos.y-14,4,2)
    end
    pal()
  end
  a.die=function(self)
    btl_ended=t
    self:play_anim"die"
    music"-1"
    sfx"61"
    new_delayed_event(120,function()
      shake(440)
    end)
    new_delayed_event(640,function()
      self:die_event(t)
      self.dead=t
      self.ptcm:fire"1,5,13|50,60,70|0.1,0.2,0.4,0.5,0.6,0.8,1|0.6,0.8,1,1.2,1.4|10|2,3|-0.0001"
      sfx"53"
    end)
  end
  a.end_turn=function(self)
    if (not self.dead) self:play_anim"idle"
    self.acting=f
    if (self.played_second_turn) self:decrement_mods()
    btl_start_next_turn()
  end
  a.shoot_spell=function(self)
    new_enm_acn_projectile(self,183,new_spd"4|0.1|0.05",rnd{ply1,ply2},"idle$204,5|204,5|206,5|207,5$t",new_pos(self.pos.x-14,self.pos.y-20),nil,nil,t,nil,final_boss_pal_fn)
    sfx"58"
  end
  return a
end

function btl_start_next_turn()
  if (btl_ended) return
  local turn_act=btl_turn_act()
  if turn_act and turn_act.two_turns then
    if not turn_act.played_second_turn then
      btl_turn_act():start_turn()
      turn_act.played_second_turn=t
      return
    end
  end
  turn_act_index+=1
  if (turn_act_index>#acts) turn_act_index=1
  btl_turn_act().played_second_turn=f
  btl_turn_act():start_turn()
end

function handle_death()
  if #enm_acts()==0 then
    fade_out(400,function()
      load_cart"ending"
    end)
  elseif #ply_acts()==0 then
    btl_ended=t
    fade_out(120,function()
      fade_in()
      show_game_over=t
    end)
  end
end