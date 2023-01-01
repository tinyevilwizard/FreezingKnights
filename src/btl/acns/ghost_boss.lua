local draw_attack_circle=function(self,act)
  local x,y,r,c,c2,line_lgt,half_line_lgt=act.target.pos.x,act.target.pos.y-6,self.t,act.target.dead and 12 or 8,act.target.dead and 1 or 2,4,2
  circ(x,y,r,c2)
  circ(x,y,r*2,c)
  circ(x,y,r*2,c)
  spr(act.target.dead and 133 or 132,x-4+rnd(split("-1,0,0,0,0,0,0,1")),y-6+rnd(split("-1,0,0,0,0,0,0,1")))
end
acns.ghost_boss_absorb=function(act)
  local a=new_acn(act,0,"absorb",function() return enm_acts(t,act) end)
  a.absorb_or_revive=function(act)
    local effect_obj=new_obj(
      function(self)
        draw_attack_circle(self,act)
      end,
      function(self)
        self.t-=2
        if self.t<=0 then
          if act.target.dead then
            act.target:heal(99)
            sfx"60"
            act:clear_acn_acc()
          else
            act.target:take_dmg(99,t,t)
            local heal_orb=new_obj(
              function(self)
                spr(self.anim_manager:current_spr(),self.pos.x-4,self.pos.y-8)
              end,
              function(self)
                self.anim_manager:load_next_frame()
                if mv(self,pos_clone(act.pos,0,1),self.spd) then
                  act:heal(act.absorb_heal_amount)
                  sfx"60"
                  act:clear_acn_acc()
                end
                self.spd+=0.01
              end,
              pos_clone(act.target.pos)
            )
            heal_orb.spd,heal_orb.anim_manager=0,new_anim_manager(new_anims"idle$128,5|129,5|130,5|131,5$t",heal_orb)
            act:set_acn_acc(heal_orb)
          end
        end
      end
    )
    effect_obj.t=240
    act:set_acn_acc(effect_obj)
  end

  return a
end

acns.ghost_boss_skulls=function(act)
  local a,skull_anim=new_acn(act,5,"skulls"),"idle$191,5|188,5|189,5|190,5$t"

  a.shoot_skulls=function()
    a.shoot_skull(ply1)
    a.shoot_skull(ply2)
  end

  a.shoot_skull=function(target)
    del(act.selected_acn.target_list,target)
    if rnd()>=0.5 then
      a.shoot_straight_skull(target)
    else
      a.shoot_bouncy_skull(target)
    end
    act:shake()
    sfx"58"
  end

  a.shoot_straight_skull=function(target)
    local y_vel=3
    new_enm_acn_projectile(act,178,new_spd"2.5|0.25|0.03",target,skull_anim,nil,enm_projectile_ptc,10,f,function(self)
      self.elv=max(self.elv+y_vel,0)
      y_vel-=0.25
    end)
  end

  a.shoot_bouncy_skull=function(target)
    local y_vel=3
    new_enm_acn_projectile(act,178,target==ply1 and 1.3 or 1.2,target,skull_anim,nil,enm_projectile_ptc,10,f,function(self)
      self.elv+=y_vel
      y_vel-=0.25
      if (self.elv<=0) y_vel=3
    end)
  end

  return a
end

acns.ghost_boss_stare=function(act)
  local a=new_acn(act,6,"stare")

  a.stare=function()
    local effect_obj=new_obj(
      function(self)
        draw_attack_circle(self,act)
      end,
      function(self)
        self.t-=2
        if self.t==0 then
          act:add_acn_acc(new_obj(
            nil,
            function(self)
              if (self.hb:update()) act.selected_acn:dmg_act(self.hb.colliding_with)
            end,
            pos_clone(act.target.pos),0,f,"attack|ply|8|8|t"
          ))
        end
      end
    )
    effect_obj.t=240
    act:set_acn_acc(effect_obj)
  end

  return a
end