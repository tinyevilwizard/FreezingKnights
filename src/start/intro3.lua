intro3={
  done=f,
  time=0,
  end_time=430,
  draw=function(self)
    cls(0)
    local y=40
    center_print("fEEDBACK | tESTING",y,7)
    line(20,y+7,108,y+7,7)

    y+=12
    center_print("aRTHURIA",y,13)
    y+=9
    center_print("pARTYBIRD",y,13)
    y+=9
    center_print("oHcURTAINS",y,13)
    y+=9
    center_print("sMELLYfISHsTIKS",y,13)
    y+=9
    center_print("PARAk00pa",y,13)
  end,
  update=function(self)
    if btnp(4,0) or btnp(5,0) or btnp(4,1) or btnp(5,1) then
      self.done=t
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