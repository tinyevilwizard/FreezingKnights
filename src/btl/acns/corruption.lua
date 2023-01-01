acns.corruption_spike=function(act)
  local a=new_acn(act,6,"spike",nil,t)

  a.bury_self,a.sneak_attack=function()
    act.ptcm:fire_snow()
    act:start_mov(act.target.pos,1.4)
    fake_sdw=new_obj(
      nil,
      function(self)
        mv_ang(self,self.ang,1.4)
      end,
      pos_clone(act.pos),0,f,nil,
      function(self)
        sdw(self.pos.x,self.pos.y,16)
      end
    )
    fake_sdw.ang=ang_to({pos=act.pos},act.target==ply1 and ply2.pos or ply1.pos)
    act:set_acn_acc(fake_sdw)
  end,function()
    act.atk_hb=new_hitbox(act,"attack|ply|8|8|t")
    shake()
    sfx"61"
    act.ptcm:fire_snow()
  end

  return a
end

acns.corruption_spawn=function(act)
  local a=new_acn(act,5,"spawn")

  a.spawn_small_corruption=function()
    act:shake()
    sfx"58"
    local y_vel,type,elv_reached=5,split(rnd(split("idle$206,10|222,5$t&1.35|0.5|0.025@idle$221,5|237,5|221,5|253,5$t&1|0.5|0.015@idle$220,5|204,5|220,5|254,5$t&1.65|0.5|0.025@idle$238,5|205,5$t&2|0.5|0.05","@")),"&"),f
    new_enm_acn_projectile(act,237,0.35,rnd{ply1,ply2},"idle$207,2|223,2|239,2|255,2$t",nil,enm_projectile_ptc,0,f,function(self)
      if not elv_reached then
        self.elv=max(self.elv+y_vel,0)
        y_vel-=0.25
        if self.elv<=0 then
          elv_reached,self.anim_manager,self.spd,self.stop_ptc=t,new_anim_manager(new_anims(type[1]),self),new_spd(type[2]),t
        end
      end
    end,function()
      pal(5,0)
    end)
  end

  return a
end