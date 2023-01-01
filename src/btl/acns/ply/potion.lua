acns.potion=function(act)
  local a=new_acn(act,0,"heal")
  a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.inc_dead,a.available,a.hold_potion,a.consume_potion="1"..potion_char,47,105,"healing potion (PARTY MEMBER)",ply_acts,t,function()
    return potions>0
  end,function()
    potions-=1
    act:set_acn_acc(new_obj(function() sspr(91,24,5,7,act.pos.x+4,act.pos.y-9) end))
  end,function()
    act:clear_acn_acc()
    act.target:heal(99)
    sfx"60"
  end
  return a
end