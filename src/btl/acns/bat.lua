acns.bat_charge=function(act)
  local a=new_mle(act,4,"charge",70)
  a.prepare_charge,a.charge,a.come_back=function()
    a.target_elv=rnd(split"4,4,14")
    act:elevate_to(a.target_elv,.1)
    act:start_mov(pos_clone(act.pos,2),.05)
  end,function()
    act:elevate_to(a.target_elv,0.65)
    act:start_mov(new_pos(-10,act.target.pos.y),new_spd"3|0.15|0.15")
    act.atk_hb=new_hitbox(act)
    sfx"61"
  end,function()
    act:elevate_to(16,.25)
    act.pos.x=136
  end
  return a
end

acns.bat_sneak=function(act)
  local a=new_mle(act,3,"sneak",70)
  a.prepare_sneak,a.start_sneak,a.tp_behind,a.sneak_attk,a.come_back=function()
    act:elevate_to(12,.1)
    act:start_mov(pos_clone(act.pos,-2),.1)
  end,function()
    act:elevate_to(1,.25)
    act:start_mov(new_pos(132,act.target.pos.y),2)
    act.atk_hb=new_hitbox(act)
    sfx"61"
  end,function()
    act.pos.x=-6
  end,function()
    act:start_mov(new_pos(132,act.target.pos.y),1)
  end,function()
    act:elevate_to(16,.25)
  end
  return a
end