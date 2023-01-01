acns.guardian_boss_laser=function(act)
  local a=new_acn(act,6,"laser")
  a.start_laser=function()
    act:set_acn_acc(
      new_obj(function()
        spr(flr(time()*100)%2==0 and 255 or 239,act.pos.x-17,act:elv_y(t)+4)
      end)
    )
  end

  a.shoot_laser=function()
    local laser_start_point=pos_clone(act.pos,-24)
    local ordered_targets=rnd{{ply1.pos,ply2.pos,laser_start_point},{ply2.pos,ply1.pos,laser_start_point}}
    act:add_acn_acc(
      new_obj(function(self)
        self.ptcm:draw()
        if not self.stop_laser then
          line(act.pos.x-13,act:elv_y(t)+7,self.pos.x,self.pos.y,8)
        end
      end,
      function(self)
        self.ptcm:update()
        if not self.stop_laser then
          if self.hb:update() and self.hb.colliding_with.elv<=0 then
            act.selected_acn:dmg_act(self.hb.colliding_with)
          end
          if mv(self,ordered_targets[1],0.75) then
            deli(ordered_targets,1)
            if (#ordered_targets<=0) self.stop_laser=t
          end
          sfx"56"
          self.ptcm:fire"6,6,6,6,13|30,35,40,45,50,55,60,65,70|0.075,0.1,0.15,0.2,0.25|0.2,0.25,0.3,0.35|1|1,2,2,2|-0.00001"
        end
      end,laser_start_point,nil,f,"attack|ply|8|1||0,5")
    )
  end

  return a
end

acns.guardian_boss_spawn_minis=function(act)
  local a=new_acn(act,6,"spawn")
  a.spawn_mini=function()
    local target=rnd{ply1,ply2}
    local target_elv=rnd(split"4,4,4,16")
    new_enm_acn_projectile(act,223,rnd(split"2.5"),target,nil,new_pos(250,target.pos.y),nil,40,f,function(self)
      self.elv=max(self.elv-0.5,target_elv)
    end,act.pal_fn)
  end
  return a
end

acns.guardian_boss_shadows=function(act)
  local a=new_acn(act,6,"shadows")
  a.spawn_shadows=function()
    local delay=0
    for s in all(split(act.shadows_anim)) do
      a.spawn_shadow(ply1,new_pos(act.pos.x+s-24,ply1.pos.y),delay,(rnd{t,f}))
      a.spawn_shadow(ply2,new_pos(act.pos.x+s-24,ply2.pos.y),delay+30,(rnd{t,f}))
      delay+=60
    end
  end
  a.spawn_shadow=function(target,start_pos,delay,trigger)
    local t,reached_start_point,spd=0,f,new_spd"2.5|0.25|0.05"
    fake_sdw=new_obj(
      function(self)
        pal(2,0)
        if t<120+delay and reached_start_point and trigger then
          if (t<90) spr(206,self.pos.x-4,self.pos.y-8)
        else
          if trigger then
            if t>=136+delay then
              spr(204,self.pos.x-4,self.pos.y-8)
            elseif t>=133+delay then
              spr(205,self.pos.x-4,self.pos.y-8)
            elseif t>=130+delay then
              spr(206,self.pos.x-4,self.pos.y-8)
            end
          end
        end
        pal()
      end,
      function(self)
        t+=1
        if t<120+delay then
          reached_start_point=mv(self,start_pos,1.2)
        else
          if (not self.ang) self.ang=ang_to(self,target.pos)
          mv_ang(self,self.ang,spd)
        end
        if (self.hb and self.hb:update()) act.selected_acn:dmg_act(self.hb.colliding_with)
      end,
      pos_clone(act.pos),0,f,trigger and "attack|ply|8|8|t",
      function(self)
        sdw(self.pos.x,self.pos.y,8)
      end
    )
    act:add_acn_acc(fake_sdw)
  end
  return a
end