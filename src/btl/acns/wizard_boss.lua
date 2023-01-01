acns.wizard_boss_chicken=function(act)
  local a=new_acn(act,3,"summon")
  a.summon_chicken=function()
    local target=rnd{ply1,ply2}
    new_enm_acn_projectile(act,181,1.6,target,rnd{"idle$178,5,chicken_sfx|179,5$t","idle$180,5,chicken_sfx|181,5$t","idle$132,5,chicken_sfx|133,5|134,5|133,5$t"},new_pos(130,target.pos.y))
  end
  a.chicken_sfx=function()
    sfx"54"
  end
  return a
end

acns.wizard_boss_spell=function(act)
  local a=new_acn(act,3,"spell")
  a.spell_generator=function()
    local obj=new_obj(
      function(self)
        spr(self.anim_manager:current_spr(),act.pos.x-8,act.pos.y-32,2,2)
      end,
      function(self)
        self.anim_manager:load_next_frame()
      end
    )
    obj.anim_manager=new_anim_manager(new_anims("idle$226,5|228,5|230,5|232,5$t"),act)
    sfx"59"
    act:add_acn_acc(obj)
  end
  a.shoot_spell=function()
    local target=rnd{ply1,ply2}
    new_enm_acn_projectile(act,183,2.2,target,"idle$183,5|184,5|185,5|186,5$t",new_pos(act.pos.x,act.pos.y-16),nil,nil,t)
    sfx"58"
  end
  return a
end

acns.wizard_boss_spike=function(act)
  local a=new_acn(act,5,"spike")
  a.summon_1st_spike=function(act)
    a.summon_small_spike(new_pos(72,act.pos.y))
  end
  a.summon_2nd_spike=function()
    a.summon_small_spike(new_pos(52,act.pos.y+(act.target.pos.y-act.pos.y)/2))
  end
  a.summon_small_spike=function(pos)
    local time=1
    act:set_acn_acc(new_obj(
      function()
        sspr(8,88,8,time,pos.x-4,pos.y-time)
        time=min(time+1.5,8)
      end
    ))
    act.ptcm:fire_snow(pos_clone(pos))
    sfx"61"
    shake()
  end

  a.summon_final_spike=function()
    local time,pos=1,act.target.pos
    act:set_acn_acc(new_obj(
      function(self)
        sspr(0,112,16,time,pos.x-8,pos.y-time)
        time=min(time+2,16)
      end,
      function(self)
        if (self.hb:update()) act.selected_acn:dmg_act(self.hb.colliding_with)
      end,
      pos,
      0,
      f,
      "attack|ply|8|9|t"
    ))
    act.ptcm:fire_snow(pos_clone(pos))
    sfx"61"
    shake(20)
  end

  return a
end