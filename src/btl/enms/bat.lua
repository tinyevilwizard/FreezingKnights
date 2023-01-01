enms[30]=function(args)
  local a=new_btl_act(args)
  a:set_sts {hp=6}
  a:set_acns "bat_charge"
  a.name,a.gold,a.elv,a.anim_manager="bat",3,16,
  new_anim_manager(
    new_anims "idle$160,10|161,10|162,10$t$$t&dmg$163,30$$idle&run$160,10|161,10|162,4$t&charge$160,60,prepare_charge|160,5,charge|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,5|161,5|162,2|160,1,come_back|160,100,set_done_acting&sneak$166,60,prepare_sneak|166,5,start_sneak|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|165,1,tp_behind|166,5|164,5|170,2,sneak_attk|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|166,5|164,5|170,2|160,10,come_back|160,100,set_done_acting"
  ,a)
  return a
end

enms[31]=function(args)
  local a=enms[30](args)
  a:set_sts {hp=12}
  a:set_acns "bat_charge,bat_sneak"
  a.name,a.gold,a.pwr_multi,a.pal_fn="blood bat",10,1.75,function()
    pal(1,2)
    pal(9,8)
  end
  return a
end