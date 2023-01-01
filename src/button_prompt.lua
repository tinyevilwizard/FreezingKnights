new_btn_prompt=function(text,pos,col)
  local anim_timer=0
  return {
    pos=pos,
    draw=function(self)
      spr(0,self.pos.x,self.pos.y+1)
      ? text,self.pos.x,self.pos.y+(anim_timer>50 and 1 or 0),col
      anim_timer=(anim_timer+1)%70
    end,
  }
end
