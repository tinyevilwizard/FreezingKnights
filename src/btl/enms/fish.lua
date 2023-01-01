kill_all_enms=function()
  for e in all(enm_acts()) do
    e:die()
  end
end

enms[50]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=49}
  a:set_acns"fish_tutorial"
  a.die_event,a.name,a.gold,a.anim_manager=a.die,"tutorial fish",60,
  new_anim_manager(
    new_anims"idle$167,40|168,10|167,20|168,10|167,40|173,4|169,40|170,10|169,20|170,10|169,40|173,4$t$$t&dmg$171,30$$idle&run$167,10$t&tutorial$167,5,tutorial|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,5|172,5,speak|167,360|174,40|168,20,shoot_bubble_p1|167,60|174,40|168,20,shoot_bubble_p2|167,120|167,1,set_done_acting&bubble$167,10|174,40|168,20,shoot_bubble|167,80|167,1,set_done_acting"
  ,a)
  a.die=function(self)
    self:die_event()
    kill_all_enms()
  end
  return a
end

enms[51]=function(args)
  local a=enms[50](args)
  a:set_sts{hp=9}
  a:set_acns"fish_bubble"
  a.name,a.gold,a.die,a.pal_fn="rebellious fish",5,a.die_event,function()
    pal(12,9)
    pal(1,2)
    pal(2,1)
  end
  return a
end

enms[52]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=1}
  a:set_acns"skip"
  a.name,a.kill_all_enms,a.wdt,a.hgt,a.anim_manager='"skip tutorial" sign',kill_all_enms,16,16,new_anim_manager(new_anims"idle$130,1&dmg$130,1,kill_all_enms&skip$130,1,set_done_acting",a)
  return a
end