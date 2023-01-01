enms[10]=function(args)
  local a=new_btl_act(args)
  a:set_sts {hp=10}
  a:set_acns "wizard_chicken,wizard_spell"
  a.name,a.gold,a.anim_manager="evil wizard",5,new_anim_manager(new_anims "idle$128,120|129,5|130,40|129,5|128,7|129,5|130,7|129,5|128,2$t$$t&dmg$131,30$$idle&spike$130,30|136,1|135,10,summon_spike|131,100,set_done_acting&spell$135,60|136,2|137,5,shoot_spell|137,80|137,100,set_done_acting&run$132,5|133,5|134,5|133,5$t&still_acn$128,15,jump|128,30,jump|129,5|130,60|136,3|135,60,exe_still_acn|135,100,set_done_acting&chicken$0,40|0,200,summon_chicken|0,1,set_done_acting",a)
  return a
end

enms[11]=function(args)
  local a=enms[10](args)
  a:set_sts{hp=5}
  a:set_acns "sm_heal,sm_protect"
  a.name,a.gold,a.pal_fn="cheerful wizard",3,function()
    pal(8,3)
    pal(1,0)
    pal(2,1)
  end
  return a
end

enms[12]=function(args)
  local a=enms[10](args)
  a:set_sts{hp=15}
  a:set_acns"wizard_spike,wizard_spell,wizard_chicken"
  a.name,a.gold,a.pwr_multi,a.anim_manager,a.pal_fn="enlightened wizard",12,1.75,new_anim_manager(
    new_anims "idle$128,120|129,5|130,40|129,5|128,7|129,5|130,7|129,5|128,2$t$$t&dmg$131,30$$idle&spike$130,30|136,1|135,10,summon_spike|131,100,set_done_acting&spell$135,60|136,2|137,5,shoot_spell|137,40|136,5|135,10|137,5,shoot_spell|137,40|136,5|135,10|137,5,shoot_spell|137,80|137,100,set_done_acting&run$132,5|133,5|134,5|133,5$t&still_acn$130,60|136,3|135,60,exe_still_acn|135,100,set_done_acting&chicken$0,40|0,200,summon_chicken|0,200,summon_chicken|0,1,set_done_acting",
  a),function()
    pal(8,9)
    pal(1,2)
    pal(4,2)
    pal(2,4)
  end
  return a
end

enms[13]=function(args)
  local a=enms[10](args)
  a:set_sts{hp=12}
  a:set_acns "md_heal,md_protect,md_pwr_up"
  a.name,a.gold,a.pal_fn="laughing wizard",10,function()
    pal(8,12)
    pal(1,0)
    pal(2,1)
  end
  return a
end
