function new_merchant(args)
  local a=new_rest_actor(args)
  a.anim_manager=new_anim_manager(new_anims "hide$255,120$t$show_up&show_up$92,3|93,3|108,3|109,60|124,3|125,3$$idle&idle$125,100|77,10|125,400|77,10|125,5|77,10|125,400$t$$t",a)
  a.anim_manager:play("hide")

  a.pos_t=0
  a.pos_y_mod=0

  a.update=function(self)
    a:global_update()

    self.pos_t+=1

    if self.pos_t>600 then
      self.pos_t=0
    elseif self.pos_t>500 then
      self.pos_y_mod=1
    elseif self.pos_t>400 then
      self.pos_y_mod=2
    elseif self.pos_t>300 then
      self.pos_y_mod=3
    elseif self.pos_t>200 then
      self.pos_y_mod=2
    elseif self.pos_t>100 then
      self.pos_y_mod=1
    else
      self.pos_y_mod=0
    end
  end

  a.draw=function(self)
    sdw(self.pos.x,self.pos.y+36,14,8)
    x,y=self.pos.x,self.pos.y
    spr(74,x-8,y-24+self.pos_y_mod,2,4)
    spr(
      self.anim_manager:current_spr(),
      self.pos.x-(self.wdt/2),
      self.pos.y-self.hgt+1-self.elv+self.pos_y_mod
    )
    spr(120,self.pos.x-6,self.pos.y+8+self.pos_y_mod)
    spr(121,self.pos.x-1,self.pos.y+4+self.pos_y_mod)
  end

  return a
end