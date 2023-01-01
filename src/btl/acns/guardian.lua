acns.guardian_laser=function(act)
  local a=new_ran(act,6,"laser")
  a.start_laser=function()
    act:set_acn_acc(
      new_obj(function()
        spr(flr(time()*100)%2==0 and 181 or 180,act.pos.x-8,act:elv_y(t))
      end)
    )
  end
  a.shoot_laser=function()
    local ordered_targets,spd=rnd{{new_pos(32,50),new_pos(16,112)},{new_pos(16,112),new_pos(32,50)}},new_spd"0.75|0|0.025"
    act:add_acn_acc(
      new_obj(
        function(self)
          self.ptcm:draw()
          if (not self.stop_laser) line(act.pos.x-4,act:elv_y()-5,self.pos.x,self.pos.y,8)
        end,
        function(self)
          self.ptcm:update()
          if self.hb:update() and self.hb.colliding_with.elv<=0 then
            act.selected_acn:dmg_act(self.hb.colliding_with)
          end
          if mv(self,ordered_targets[2],spd) then
            self.stop_laser=t
          else
            sfx"56"
            self.ptcm:fire"6,6,6,6,13|30,35,40,45,50,55,60,65,70|0.075,0.1,0.15,0.2,0.25|0.2,0.25,0.3,0.35|1|1,2,2,2|-0.00001"
          end
        end,ordered_targets[1],nil,f,"attack|ply|8|1||0,5"
      )
    )
  end
  return a
end

acns.guardian_charge=function(act)
  local a=new_mle(act,5,"charge",100)
  a.charge,a.come_back=function()
    act:start_mov(new_pos(-10,act.target.pos.y),new_spd"4|0|0.075")
    act.atk_hb=new_hitbox(act)
  end,function()
    act.target=rnd{ply1,ply2}
    act.pos=new_pos(150,act.target.pos.y)
  end
  return a
end