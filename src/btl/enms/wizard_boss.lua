enms[100]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=50}
  a:set_acns"wizard_boss_chicken,wizard_boss_spell,wizard_boss_spike"
  a.wdt,a.hgt,a.name,a.gold,a.anim_manager=16,16,"ancient wizard",40,new_anim_manager(new_anims
    "idle$148,240|146,5|144,10|146,5|148,5|150,5|152,5|150,5|148,5|146,5|144,5|146,5|148,5|150,5|152,5|150,5|148,120|138,7|140,15|142,7|148,120|150,5|152,60|150,5|148,5|146,5|144,60|146,5|148,120|146,5|144,60|146,5|148,5|150,5|152,60|150,5$t$$t&dmg$174,30$$idle&die$174,60,die_shake|174,60,die_shake|174,60,die_shake&still_acn$148,60|172,3|192,3|194,60,exe_still_acn|192,3|148,10|148,100,set_done_acting&summon$146,5|196,60|196,60,summon_chicken|196,40,summon_chicken|196,50,summon_chicken|196,30,summon_chicken|196,60,summon_chicken|196,40,summon_chicken|196,50,summon_chicken|196,120,summon_chicken|196,1,set_done_acting&spell$148,60|172,3|192,3|194,60,spell_generator|194,40,shoot_spell|194,40,shoot_spell|194,40,shoot_spell|194,40,shoot_spell|194,40,shoot_spell|194,120,shoot_spell|192,3,clear_acn_acc|148,20|148,100,set_done_acting&spike$148,60|172,3|192,3|194,60|194,40,summon_1st_spike|194,40,summon_2nd_spike|194,12,summon_final_spike|194,60,clear_acn_acc|192,3|148,20|148,100,set_done_acting",a)

  a.die_event=a.die
  a.die_shake=function(self)
    sfx"61"
    self:shake()
  end
  a.die=function(self)
    btl_ended=t
    self:play_anim"die"
    music"-1"
    for e in all(enm_acts(f,self)) do
      e:die(t)
    end
    new_delayed_event(300,function()
      self:die_event()
      self.dead=t
      sfx"53"
    end)
  end

  return a
end

enms[101]=function(args)
  local a=enms[100](args)
  a:set_sts{hp=90}
  a.name,a.pwr_multi,a.anim_manager,a.pal_fn="eternal wizard",1.75,new_anim_manager(
    new_anims"idle$148,240|146,5|144,10|146,5|148,5|150,5|152,5|150,5|148,5|146,5|144,5|146,5|148,5|150,5|152,5|150,5|148,120|138,7|140,15|142,7|148,120|150,5|152,60|150,5|148,5|146,5|144,60|146,5|148,120|146,5|144,60|146,5|148,5|150,5|152,60|150,5$t$$t&dmg$174,30$$idle&die$174,60,die_shake|174,60,die_shake|174,60,die_shake&still_acn$148,60|172,3|192,3|194,60,exe_still_acn|192,3|148,10|148,100,set_done_acting&summon$146,5|196,60|196,30,summon_chicken|196,30,summon_chicken|196,40,summon_chicken|196,30,summon_chicken|196,30,summon_chicken|196,40,summon_chicken|196,30,summon_chicken|196,30,summon_chicken|196,30,summon_chicken|196,30,summon_chicken|196,30,summon_chicken|196,120,summon_chicken|196,1,set_done_acting&spell$148,60|172,3|192,3|194,60,spell_generator|194,30,shoot_spell|194,30,shoot_spell|194,30,shoot_spell|194,30,shoot_spell|194,30,shoot_spell|194,120,shoot_spell|192,3,clear_acn_acc|148,20|148,100,set_done_acting&spike$148,60|172,3|192,3|194,60|194,40,summon_1st_spike|194,40,summon_2nd_spike|194,15,summon_final_spike|194,30,clear_acn_acc|194,40,summon_1st_spike|194,40,summon_2nd_spike|194,12,summon_final_spike|194,60,clear_acn_acc|192,3|148,20|148,100,set_done_acting",a),function()
    pal(8,9)
    pal(1,2)
    pal(4,2)
    pal(2,4)
  end
  return a
end