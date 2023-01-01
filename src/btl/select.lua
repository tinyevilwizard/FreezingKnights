function new_select(items,act,player,on_cancel,multi_select,default)
  local index=default or 1
  return {
    update=function()
      if btnp(1,player) or btnp(3,player) then
        index+=1
        if (index>#items) index=1
        sfx"54"
      elseif btnp(0,player) or btnp(2,player) then
        index-=1
        if (index<=0) index=#items
        sfx"54"
      end

      act.hint=items[index].hint

      if btnp(confirm_btn,player) then
        action=items[multi_select and 1 or index].action
        if action then
          action()
          sfx"56"
        end
      elseif btnp(cancel_btn,player) then
        if on_cancel then
          on_cancel()
          sfx"55"
        end
      end
    end,
    draw=function()
      for k,i in next,items do i:draw(k==index or multi_select) end
    end
  }
end