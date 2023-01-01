level_selector={
  ply1_pal={armor=dget"0", armor_dark=dget"1", details=dget"6", skin=dget"2", skin_sdw=dget"3", eyes=dget"4", mouth=dget"5"},
  ply2_pal={armor=dget"7", armor_dark=dget"8", details=dget"13", skin=dget"9", skin_sdw=dget"10", eyes=dget"11", mouth=dget"12"},
  corruption_anim_t=0,
  init=function(self)
    self.current_level_id=dget"18"
    fade_in(20)
    self.selectable_levels={}
    for level in all(unordered_levels) do
      if level.id<=self.current_level_id then
        local mark_as_cleared=t
        if levels[self.current_level_id].cleared_exceptions_ids then
          for id in all(levels[self.current_level_id].cleared_exceptions_ids) do
            if (level.id==id) mark_as_cleared=f
          end
        end
        if (mark_as_cleared) mset(level.x,level.y,145)
      end
    end
    for id in all(levels[self.current_level_id].next_ids) do
      local level=levels[id]
      add(self.selectable_levels,level)
      if level.type==type_rest then
        mset(level.x,level.y,184)
      elseif level.type==type_battle then
        mset(level.x,level.y,183)
      elseif level.type==type_boss then
        mset(level.x,level.y,185)
      elseif level.type==type_final_boss then
        mset(level.x,level.y,192)
        mset(level.x+1,level.y,193)
        mset(level.x,level.y+1,208)
        mset(level.x+1,level.y+1,209)
      end
    end
    --self.selectable_levels=unordered_levels -- Uncomment to unable selecting any level
    fade_in(20,function()
      new_delayed_event(20, function()
        self:start()
      end)
    end)
  end,
  start=function(self)
    local items={}
    for l in all(self.selectable_levels) do
      add(items,{
        draw=function(self2,active)
          local offset_y=0
          self2.t=(self2.t+1)%60
          if (self2.t<=10) offset_y=1
          if active then
            sspr(96,8,6,5,l.x*8+1,l.y*8-6+offset_y)
          end
        end,
        on_confirm=function()
          if l.cart then
            self.menu=nil
            music(-1,1000)
            fade_out(20,function()
              load_level(l)
            end)
          end
        end,
        t=0
      })
    end
    self.menu=new_menu(
      items,
      player1_controller
    )
  end,
  update=function(self)
    if (self.menu) self.menu:update()
  end,
  draw=function(self)
    for y=0,15 do
      for x=0,15 do
        spr(mget(x,y),x*8,y*8)
      end
    end

    center_print("SELECT DESTINATION",4,1)

    if (levels[self.current_level_id].chars_reversed) then
      self:draw_reverse_players()
    else
      self:draw_players()
    end

    if (self.menu) self.menu:draw()

    snow_con:draw()

    if levels[self.current_level_id].corruption_y_base then
      self:draw_corruption()
    end
  end,
  draw_players=function(self)
    local current_level=levels[self.current_level_id]
    if current_level then
      spr(171,current_level.x*8-8,current_level.y*8-17,3,2)
      set_ply_colors(self.ply1_pal)
      spr(128,current_level.x*8-5,current_level.y*8-13)
      set_ply_colors(self.ply2_pal)
      spr(128,current_level.x*8+5,current_level.y*8-13)
      pal()
    end
  end,
  draw_reverse_players=function(self)
    local current_level=levels[self.current_level_id]
    if current_level then
      spr(226,current_level.x*8-8,current_level.y*8+9,3,2)
      set_ply_colors(self.ply1_pal)
      spr(128,current_level.x*8-5,current_level.y*8+13)
      set_ply_colors(self.ply2_pal)
      spr(128,current_level.x*8+5,current_level.y*8+13)
      pal()
    end
  end,
  draw_corruption=function(self)
    pal(5,0)
    self.corruption_anim_t=(self.corruption_anim_t+1)%120
    local base_y,anim_offset=levels[self.current_level_id].corruption_y_base,self.corruption_anim_t>=60 and 1 or 0
    for y=0,5 do
      for x=-1,3 do
        spr((x+y+anim_offset)%2==0 and 68 or 64,32*(x+(y%2==0 and 0.5 or 0)),16*y+base_y,4,4)
      end
    end
    pal()
  end
}

