enms[300]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=90}
  a:set_acns"guardian_boss_shadows,guardian_boss_spawn_minis,guardian_boss_laser"
  a.name,a.elv,a.wdt,a.hgt,a.atk_pos,a.gold,a.shadows_anim,a.anim_manager,a.pal_fn="colossal guardian",-2,32,32,pos_clone(a.spw,-14),100,"0,-16,-32",new_anim_manager(
    new_anims"idle$136,180|140,5|192,120|140,5|136,5|132,120|136,10|140,10|192,120|140,10$t&dmg$128,30$$idle&die$136,60,die_shake|136,60,die_shake|136,60,die_shake&laser$136,20|140,5|196,60,start_laser|196,120,shoot_laser|196,120,shoot_laser|196,260,shoot_laser|192,5,clear_acn_acc|140,5|136,20|136,20,set_done_acting&spawn$136,20|140,5|196,40|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,150,spawn_mini|192,5|140,5|136,20|136,20,set_done_acting&shadows$136,20|140,10|192,30|140,5|136,5|200,40,enter_ground|200,440,spawn_shadows|192,5,enter_ground|140,5|136,20|136,20,set_done_acting"
  ,a),function(self)
    pal(4,0)
  end
  a.enter_ground=function(self)
    shake()
    self.ptcm:fire_snow()
  end
  a.die_event=a.die
  a.die_shake=function(self)
    sfx"61"
    self:shake()
  end
  a.die=function(self)
    btl_ended=t
    self:play_anim"die"
    music"-1"
    new_delayed_event(300,function()
      self:die_event()
      self.dead=t
      sfx"53"
    end)
  end
  return a
end

enms[301]=function(args)
  local a=enms[300](args)
  a:set_sts{hp=150}
  a:set_acns"guardian_boss_shadows,guardian_boss_spawn_minis,guardian_boss_laser,md_pwr_up,md_protect"
  a.name,a.pwr_multi,a.shadows_anim,a.anim_manager,a.pal_fn="elite c. guardian",1.5,"16,0,-16,-32",new_anim_manager(
    new_anims"idle$136,180|140,5|192,120|140,5|136,5|132,120|136,10|140,10|192,120|140,10$t&dmg$128,30$$idle&die$136,60,die_shake|136,60,die_shake|136,60,die_shake&laser$136,20|140,5|196,60,start_laser|196,80,shoot_laser|196,80,shoot_laser|196,80,shoot_laser|196,80,shoot_laser|196,260,shoot_laser|192,5,clear_acn_acc|140,5|136,20|136,20,set_done_acting&still_acn$136,20|140,5|196,40|196,40,exe_still_acn|192,5|140,5|136,20|136,20,set_done_acting&spawn$136,20|140,5|196,40|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,30,spawn_mini|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,40,spawn_mini|196,40,spawn_mini|196,20,spawn_mini|196,150,spawn_mini|192,5|140,5|136,20|136,20,set_done_acting&shadows$136,20|140,10|192,30|140,5|136,5|200,40,enter_ground|200,440,spawn_shadows|192,5,enter_ground|140,5|136,20|136,20,set_done_acting"
  ,a),function(self)
    pal(4,0)
    pal(6,13)
    pal(13,2)
    pal(5,1)
  end
  return a
end