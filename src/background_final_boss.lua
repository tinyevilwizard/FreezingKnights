function new_bgr(gradient_y,col1,col2)
  local meteors={}
  local cols,data={0x21,0x12},s_split"1,0b0000010000000000|1,0b1000000101000000|1,0b0100101001000000|1,0b0010011100100000|2,0b0101111001011011|1,0b1011010111100101|2,0b0000001001110010|2,0b0000010010100100|2,0b0000100000010100|2,0b0000000001000000"
  function new_meteor()
    local time,big=0,rnd{f,t}
    return {
      particles={},
      pos=new_pos(ceil(rnd(256)-128),0),
      particles_size=big and 2.5 or 1.25,
      size=big and 2 or 1,
      draw=function(self)
        self.pos.x+=big and 0.5 or 0.25
        self.pos.y+=big and 0.5 or 0.25
        if (self.pos.y>=90) del(meteors,self)
        for p in all(self.particles) do
          p:draw()
        end
        time=(time+1)%5
        circfill(self.pos.x,self.pos.y,self.size,1)
        if big then
          pset(self.pos.x+2,self.pos.y,8)
          pset(self.pos.x,self.pos.y+1,8)
        end
        if time==0 then
          add(self.particles,new_meteor_particle(self,pos_clone(self.pos),self.particles_size))
        end
      end
    }
  end
  function new_meteor_particle(meteor,pos,start_size)
    local size,c,time=start_size,7,0
    return {
      draw=function(self)
        circfill(pos.x,pos.y,size,1)
        size-=0.05
        time+=1
        if (time>=20) del(meteor.particles,self)
      end
    }
  end
  return {
    draw=function()
      local y=gradient_y
      rectfill(0,0,128,y,cols[1])
      rectfill(0,40,128,80,cols[2])
      for l in all(data) do
        fillp(l[2])
        rectfill(0,y,128,y+3,cols[l[1]])
        y+=4
      end
      fillp()
      for m in all(meteors) do
        m:draw()
      end
      if (rnd()>=0.9 and not btl_ended) add(meteors,new_meteor())
    end
  }
end