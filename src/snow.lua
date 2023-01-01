function new_snow_controller()
  local flakes={}
  for i=1,50 do
    add(flakes,new_snow_flake(rnd"0.75"+0.25,rnd(split"13,6,6,7,7,7,7,7,7,7,7,7,7,7")))
  end
  return {
    update=function()
      for f in all(flakes) do f:update(0.25) end
    end,
    draw=function()
      for f in all(flakes) do f:draw() end
    end
  }
end

function new_snow_flake(spd,col)
  local pos,x_mov=new_pos(rnd"200"-50,rnd"140"-15),0
  return {
    update=function(self,wind)
      x_mov+=rnd(split"-0.05,0,0,0,0,0,0.05")
      pos.y+=spd
      pos.x+=wind+x_mov
      if (pos.y>130) pos,x_mov=new_pos(rnd"200"-50,-4),0
    end,
    draw=function()
      pset(pos.x,pos.y,col)
    end
  }
end