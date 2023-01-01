-- Code by OhCurtains ---------------------
function fadeintext(str,x,y,fsf)
  local colors={1,13,13,6,7}
  local colidx=flr(fsf/6)+1
  if colidx>#colors then colidx=#colors end
  local col=colors[colidx]
  print(str,x,y,col)
end
-- End - Code by OhCurtains ---------------

intro2={
  done=f,
  time=-60,
  end_time=330,
  draw=function(self)
    cls(1)

    -- Code by OhCurtains ---------------------
    local offset=self.time*3
    if offset>148 then offset=148 end

    rectfill(0,0,128,128,1)

    spr(202,56,60,2,2)

    spr(234,56-offset/8,58,2,2)
    spr(234,56+offset/8,58,2,2,true)
    rectfill(32,48,48,80,1)
    rectfill(80,48,112,80,1)

    spr(204,48,48,4,4)

    fadeintext(" mUSIC BY\noHcURTAINS",44,84,self.time-20)

    rect(47,47,80,80,7)
    -- End - Code by OhCurtains ---------------
  end,
  update=function(self)
    if btnp(4,0) or btnp(5,0) or btnp(4,1) or btnp(5,1) then
      self.done=t
      intro3.done=t
    end
    self.time+=1
    if self.time==self.end_time then
      fade_out(1,function()
        fade_in(70)
        self.done=t
      end)
    end
  end
}