acns.ghost_skull=function(act)
  local a,skull_anim=new_mle(act,4,"skull",30),"idle$191,5|188,5|189,5|190,5$t"

  a.shoot_skull=function()
    if rnd()>0.4 then
      new_enm_acn_projectile(act,178,new_spd"2.5|0.25|0.05",act.target,skull_anim,nil,enm_projectile_ptc)
    else
      local y_vel=3
      new_enm_acn_projectile(act,178,1.1,act.target,skull_anim,nil,enm_projectile_ptc,0,f,function(self)
        self.elv+=y_vel
        y_vel-=0.25
        if (self.elv<=0) y_vel=3
      end)
    end
    act:shake()
    sfx"58"
  end

  return a
end