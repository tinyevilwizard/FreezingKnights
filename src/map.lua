--[[
  SPRITE FLAGS:
      |            MAP TILE             |                     MAP ACCESSORY
    --|---------------------------------|----------------------------------------------------------
    0 | N/A                             | Set as map accessory and set size to 8px tall, 8px wide
    1 | N/A                             | Set as map accessory and set size to 16px tall, 8px wide
    2 | N/A                             | Set as map accessory and set size to 24px tall, 8px wide
    3 | N/A                             | Set as map accessory and set size to 24px tall, 16px wide
    4 | Unused                          | Prevent shadow under map accessory
    5 | Render tile at lower position   | Corrupted map accessory
    6 | Render tile at higher position  | Unused
    7 | Render a column underneath tile | Render a column underneath map accessory
]]
map_accs={}
function new_map(mx,my)
  local map,btl_map_x_offset,btl_map_y_offset={},mx*10,my*16
  for y=btl_map_y_offset,15+btl_map_y_offset do
    local align_x_offset=8*(y%2)
    for x=btl_map_x_offset,9+btl_map_x_offset do
      local sprite,gx,gy=mget(x,y),((x%10-2)*16)+align_x_offset+8,y%16*4+48+7
      for fl=0,3 do
        local w,h_units,corrupted=fl==3 and 16 or 8,min(fl,2),fget(sprite,5)
        if fget(sprite,fl) then
          local acc={spr=sprite,pos=new_pos(gx,gy),
            draw=function(self)
              local x,y=self.pos.x,self.pos.y
              if (corrupted) pal(5,0)
              spr(self.spr,x-(w/2),y-8-(8*h_units),w/8,1+h_units)
              pal()
            end,
            draw_sdw=function(self)
              if (not fget(self.spr,4)) sdw(self.pos.x,self.pos.y,w,8)
            end
          }
          add(map_accs,acc)
          sprite=fget(sprite,7) and 64 or 66
        end
      end

      if sprite!=0 then
        add(map,{x=((x%10-2)*16)+align_x_offset,y=y%16*4+48-(fget(sprite,6) and 16 or 0)+(fget(sprite,5) and 8 or 0),column=fget(sprite,7),spr=sprite})
      end
    end
  end
  return {
    draw=function(self)
      for p in all(map) do
        local px,py,pspr=p.x,p.y,p.spr
        if p.column then
          rectfill(px,py+7,px+7,py+65,6)
          rectfill(px+8,py+7,px+15,py+65,13)
        end
        spr(pspr,px+4,py)
        spr(pspr,px,py+2)
        spr(pspr,px+8,py+2)
        spr(pspr,px+4,py+4)
      end
    end
  }
end