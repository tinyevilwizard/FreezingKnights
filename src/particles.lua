enm_projectile_ptc="6|5,6,7|0,0.05,0.1,0.15|0.05,0.1,0.15,-0.05,-0.1,-0.15|1|1,1.25,1.5,1.75,2|0.01"

function new_ptc_manager(act)
  local ptcs={}
  return {
    update=function()
      for ptc in all(ptcs) do
        ptc:update()
        if (ptc.dead) del(ptcs,ptc)
      end
    end,
    draw=function()
      for ptc in all(ptcs) do ptc:draw() end
    end,

    -- t[1] -> colors | t[2] -> lifespans | t[3] -> x powers | t[4] -> y powers | t[5] -> amounts | t[6] -> init size | t[7] -> gravity
    fire=function(self,data,pos)
      local t=s_split(data)
      local amt=rnd(t[5])
      for i=1,amt do
        add(ptcs,new_ptc(rnd(t[1]),rnd(t[2]),rnd(t[3]),rnd(t[4]),rnd(t[6]),rnd(t[7]),pos or act.elv_y and new_pos(act.pos.x,act:elv_y()) or act.pos))
      end
    end,
    fire_snow=function(self,pos)
      self:fire("6,15|18,20,22|-0.1,-0.2,-0.3,-0.4,0.1,0.2,0.3,0.4|0.8,1,1.2|3,4|1|0.1",pos or act.pos)
    end,
    fire_sweat=function(self)
      self:fire("12|14,16,18|-0.1,-0.2,-0.3,-0.4,0.1,0.2,0.3,0.4|0.6,0.7,0.8,0.9,1|3,4|1|0.1",pos_clone(act.pos,0,-6))
    end
  }
end

function new_ptc(col,lp,x_pwr,y_pwr,size,gra,pos)
  local pos,x_vel,y_vel,tm,lp,gra,size=clone(pos),x_pwr,y_pwr,0,lp,gra,size
  return {
    dead=f,
    update=function(self)
      pos.x+=x_vel
      pos.y-=y_vel
      y_vel-=gra
      tm+=1
      self.dead,size=tm>=lp,max(0,size-0.05)
    end,
    draw=function()
      circfill(pos.x,pos.y,size,col)
    end
  }
end