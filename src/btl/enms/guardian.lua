enms[40]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=12}
  a:set_acns"guardian_charge,guardian_laser"
  a.name,a.gold,a.elv,a.hover,a.anim_manager="guardian",10,16,t,
  new_anim_manager(
    new_anims"idle$169,100$t$$t&dmg$167,30,elevate_rnd$$idle&run$169,10$t&laser$168,60,start_laser|168,180,shoot_laser|169,1,elevate_rnd|169,100,set_done_acting&charge$168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|169,1,set_done_acting"
  ,a)
  a.elevate_rnd=function()
    a:elevate_to(rnd{4,16},.5)
  end
  return a
end

enms[41]=function(args)
  local a=enms[40](args)
  a:set_sts{hp=20}
  a.name,a.gold,a.pwr_multi,a.anim_manager,a.pal_fn="elite guardian",15,1.5,
  new_anim_manager(
    new_anims"idle$169,100$t$$t&dmg$167,30,elevate_rnd$$idle&run$169,10$t&laser$168,60,start_laser|168,180,shoot_laser|169,20|168,180,shoot_laser|169,1,elevate_rnd|169,100,set_done_acting&charge$168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|168,80,charge|169,1,come_back|169,1,elevate_rnd|169,1,set_done_acting"
  ,a),function()
    pal(6,13)
    pal(13,2)
    pal(5,1)
  end
  return a
end