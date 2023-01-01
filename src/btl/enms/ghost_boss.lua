enms[200]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=50}
  a:set_acns"ghost_boss_absorb,ghost_boss_skulls,ghost_boss_skulls"
  a.wdt,a.hgt,a.name,a.gold,a.elv,a.hover,a.absorb_heal_amount,a.anim_manager,a.pal_fn=24,24,"hungry soul",70,3,t,5,new_anim_manager(
    new_anims "idle$141,240|160,8|141,3|163,5|141,10|160,8|141,3|163,5|141,240|160,8|141,3|163,120|141,3|160,5$t$$t&dmg$214,30|217,10|214,5|211,5|208,5|141,120$$idle&die$214,60,die_shake|214,60,die_shake|214,60,die_shake&absorb$141,5|208,10|211,5|214,5|217,240,absorb_or_revive|217,10|214,5|211,5|208,5|141,40|141,5,set_done_acting&skulls$141,20|163,8|141,5|220,40|166,1|169,60,shoot_skulls|166,5|160,5|141,40|163,8|141,5|220,40|166,1|169,60,shoot_skulls|166,5|160,5|141,40|163,8|141,5|220,40|166,1|169,60,shoot_skulls|166,5|160,5|141,60|141,40,set_done_acting"
  ,a),function()
    pal(14,5)
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

enms[201]=function(args)
  local a=enms[200](args)
  a:set_sts{hp=80}
  a:set_acns"ghost_boss_absorb,ghost_boss_skulls,ghost_boss_stare"
  a.name,a.gold,a.pwr_multi,a.absorb_heal_amount,a.anim_manager,a.pal_fn="starving soul",100,1.5,10,new_anim_manager(
    new_anims "idle$141,240|160,8|141,3|163,5|141,10|160,8|141,3|163,5|141,240|160,8|141,3|163,120|141,3|160,5$t$$t&dmg$214,30|217,10|214,5|211,5|208,5|141,120$$idle&die$214,60,die_shake|214,60,die_shake|214,60,die_shake&absorb$141,5|208,10|211,5|214,5|217,240,absorb_or_revive|217,10|214,5|211,5|208,5|141,40|141,5,set_done_acting&stare$141,5|208,10|211,5|214,5|217,130,stare|217,10,clear_acn_acc|214,5|211,5|208,5|141,40|141,5,set_done_acting&skulls$141,20|163,8|141,5|220,10|166,1|169,20,shoot_skulls|166,5|160,5|141,5|163,8|141,5|220,10|166,1|169,20,shoot_skulls|166,5|160,5|141,5|163,8|141,5|220,10|166,1|169,20,shoot_skulls|166,5|160,5|141,5|163,8|141,5|220,10|166,1|169,20,shoot_skulls|166,5|160,5|141,5|163,8|141,5|220,10|166,1|169,20,shoot_skulls|166,5|160,5|141,60|141,40,set_done_acting"
  ,a),function()
    pal(6,13)
    pal(13,2)
    pal(5,1)
  end
  return a
end