intro1={
  done=f,
  time=0,
  end_time=430,
  draw=function(self)
    cls(0)
    spr(128,32,24,8,8)
    ? "TINYEVILWIZARD",36,90,13
  end,
  update=function(self)
    if btnp(4,0) or btnp(5,0) or btnp(4,1) or btnp(5,1) then
      self.done=t
      intro2.done=t
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