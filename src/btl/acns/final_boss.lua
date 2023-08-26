acns.final_boss_teleport=function(act)
  local a=new_acn(act,8,"teleport")
  a.teleport=function()
    fade_out(0,function()
      map_x,map_accs=(map_x+1)%3,{}
      ply1,ply2,map,ply1.spw,ply1.pos,ply2.spw,ply2.pos=ply2,ply1,new_map(map_x,0),ply2.spw,ply2.pos,ply1.spw,ply1.pos
      fade_in(60)
    end)
  end
  return a
end

acns.final_boss_spike=function(act)
  local a=new_acn(act,10,"spike")
  a.start_spike=function()
    for s in all({{pos_clone(act.pos,-27,-38),0,f},{pos_clone(act.pos,-33,-15),30,f},{pos_clone(act.target.pos,0,-2),60,t}}) do
      new_delayed_event(s[2],function()
        local obj=new_obj(
          function(self)
            for l in all(s_split"0,1|-1,1|-2,1|1,0|2,0") do
              line(act.pos.x-15,act.pos.y-27+l[1],self.pos.x,self.pos.y,l[2])
            end
          end,
          function(self)
            if not self.stop and mv(self,s[1],self.spd) and s[3] then
              self.stop=t
              shake()
              sfx"61"
              act.ptcm:fire_snow(self.pos)
              if (self.hb:update()) act.selected_acn:dmg_act(self.hb.colliding_with)
            end
          end,
          pos_clone(act.pos,-15,-27),
          0,
          f,
          "attack|ply|8|8|t"
        )
        obj.spd=new_spd"10|0|0.3"
        act:add_acn_acc(obj)
        sfx"58"
      end)
    end
  end
  return a
end

acns.final_boss_spell=function(act)
  return new_acn(act,8,"spell")
end

acns.final_boss_shadows=function(act)
  local a,previous_shadows_target,next_shadows_target=new_acn(act,4,"shadows"),ply1,ply2
  a.spawn_shadows=function()
    new_enm_acn_projectile(act,183,new_spd"2|0.1|0.02",next_shadows_target,"idle$999,55|223,20|222,10|221,1000",nil,nil,nil,f,nil,final_boss_pal_fn)
    new_enm_acn_projectile(act,183,new_spd"2|0.1|0.02",previous_shadows_target,"idle$999,1000$t",nil,nil,nil,f,function(self)
      self.hb.active=f
    end)
    previous_shadows_target,next_shadows_target=next_shadows_target,previous_shadows_target
  end
  return a
end

acns.final_boss_sneak_spell=function(act)
  local a=new_acn(act,8,"sneak_spell")
  a.shoot_spell=function()
    local target,spd=rnd{ply1,ply2},new_spd"3|0|0.02"
    new_enm_acn_projectile(act,220,spd,target,nil,new_pos(132,target.pos.y),nil,rnd{0,0,12},f,nil,final_boss_pal_fn)
    sfx"58"
  end
  return a
end