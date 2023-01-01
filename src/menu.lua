function new_menu(items,player,on_cancel,default,draw_hint)
  return {
    items=items,
    index=default or 1,
    player=player,
    on_cancel=on_cancel,
    draw_hint=draw_hint,
    update=function(self)
      local player=self.player
      if btnp(3,player) or (btnp(1,player) and not self.items[self.index].on_right) then
        self.index+=1
        if (self.index>#(self.items)) self.index=1
        sfx"54"
      elseif btnp(2,player) or (btnp(0,player) and not self.items[self.index].on_left) then
        self.index-=1
        if (self.index<=0) self.index=#(self.items)
        sfx"54"
      end

      self.hint=self.items[self.index].hint

      if btnp(confirm_btn,player) then
        on_confirm=self.items[self.index].on_confirm
        if on_confirm then
          on_confirm(self)
          sfx"56"
        end
      elseif btnp(0,player) then
        on_left=self.items[self.index].on_left
        if on_left then
          on_left(self)
          sfx"54"
        end
      elseif btnp(1,player) then
        on_right=self.items[self.index].on_right
        if on_right then
          on_right(self)
          sfx"54"
        end
      elseif btnp(cancel_btn,player) then
        if self.on_cancel then
          self:on_cancel()
          sfx"55"
        end
      end
    end,
    draw=function(self)
      for k,i in next,self.items do i:draw(k==self.index) end
      if (self.draw_hint) self:draw_hint()
    end,
    select_last=function(self)
      self.index=#self.items
    end
  }
end