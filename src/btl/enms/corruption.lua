enms[60]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=15}
  a:set_acns"corruption_spike,corruption_spawn"
  a.name,a.wdt,a.hgt,a.ui_hgt,a.atk_pos,a.gold,a.anim_manager,a.pal_fn="corruption",16,16,8,pos_clone(a.spw,-14),12,new_anim_manager(
    new_anims"idle$192,240|224,10|228,5|198,40|228,5|224,5|192,240|228,10|224,5|192,5|228,10|224,5|192,5|228,10|224,5$t$$t&run$196,10|194,5$t&spike$192,20|224,10|228,10|198,10|228,3|224,3|230,3|999,74,bury_self|230,5|226,5,sneak_attack|192,20,set_done_acting&spawn$192,20|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,20|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,20|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,120|192,1,set_done_acting"
  ,a),function()
    pal(5,0)
    pal(2,1)
  end
  return a
end

enms[61]=function(args)
  local a=enms[60](args)
  a:set_sts{hp=18}
  a.name,a.gold,a.pwr_multi,a.anim_manager,a.pal_fn="evolving corruption",17,1.5,new_anim_manager(
    new_anims"idle$192,240|224,10|228,5|198,40|228,5|224,5|192,240|228,10|224,5|192,5|228,10|224,5|192,5|228,10|224,5$t$$t&run$196,10|194,5$t&spike$192,20|224,10|228,10|198,10|228,3|224,3|230,3|999,74,bury_self|230,5|226,5,sneak_attack|192,20,set_done_acting&spawn$192,20|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,5|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,5|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,5|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,5|224,10|228,3|198,3|232,3|200,40,spawn_small_corruption|228,5|224,5|192,120|192,1,set_done_acting"
  ,a),function()
    pal(5,0)
    pal(2,8)
  end
  return a
end