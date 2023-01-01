acns.wizard_spell=function(act)
  local a=new_ran(act,3,"spell")
  a.shoot_spell=function(act,target)
    new_enm_acn_projectile(act,183,1.5,target or act.target,"idle$183,5|184,5|185,5|186,5$t")
    sfx"58"
  end
  a.shoot_spells=function()
    a.shoot_spell(act,ply1)
    a.shoot_spell(act,ply2)
  end
  return a
end

acns.wizard_spike=function(act)
  local a=new_mle(act,4,"spike")
  a.summon_spike=function()
    act.atk_hb=new_hitbox(act,"attack|ply|8|8|t|-9,0")
    local time=1
    act:set_acn_acc(new_obj(
      function()
        sspr(8,88,8,time,act.pos.x-13,act.pos.y-time)
        time=min(time+1.5,8)
      end
    ))
    act.ptcm:fire_snow(pos_clone(act.pos,-13))
    sfx"61"
  end
  return a
end

acns.wizard_chicken=function(act)
  local a=new_mle(act,3,"chicken",110)

  a.summon_chicken,a.chicken_sfx=function()
    new_enm_acn_projectile(act,183,1.6,act.target,"idle$178,5,chicken_sfx|179,5$t")
    new_enm_acn_projectile(act,183,1.6,act.target,"idle$132,5|133,5|134,5|133,5$t",pos_clone(act.pos,40),nil,nil,nil,nil,act.pal_fn)
  end,function()
    sfx"54"
  end

  return a
end