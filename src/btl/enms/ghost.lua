enms[20]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=12}
  a:set_acns "ghost_skull,ghost_skull,ghost_skull,ghost_skull,ghost_skull,ghost_skull,ghost_skull,sm_pwr_down,sm_unprotect"
  a.name,a.gold,a.elv,a.hover,a.anim_manager="wandering soul",8,3,t,new_anim_manager(
    new_anims "idle$144,250|144,250|144,250|144,250$$idle2$t&idle2$145,20|146,5|147,30|146,5|145,5$$idle&dmg$150,30$$idle&run$151,100$t&skull$144,40|147,20|149,40,shoot_skull|148,4|144,10|147,20|149,40,shoot_skull|148,4|144,20|144,10,set_done_acting&still_acn$144,20|145,60|151,60,exe_still_acn|151,100,set_done_acting"
  ,a)
  return a
end

enms[21]=function(args)
  local a=enms[20](args)
  a:set_sts{hp=15}
  a:set_acns"ghost_skull,ghost_skull,ghost_skull,ghost_skull,ghost_skull,md_pwr_down,md_unprotect"
  a.name,a.gold,a.pwr_multi,a.anim_manager,a.pal_fn="staring soul",12,1.5,new_anim_manager(
    new_anims"idle$144,250|144,250|144,250|144,250$$idle2$t&idle2$145,20|146,5|147,30|146,5|145,5$$idle&dmg$150,30$$idle&run$151,100$t&skull$144,40|147,20|149,10,shoot_skull|148,4|144,10|147,20|149,10,shoot_skull|148,4|144,10|147,10|149,20,shoot_skull|148,4|144,10|147,40|149,40,shoot_skull|148,4|144,20|144,10,set_done_acting&still_acn$144,20|145,60|151,60,exe_still_acn|151,100,set_done_acting"
  ,a),function()
    pal(6,13)
    pal(13,14)
  end
  return a
end