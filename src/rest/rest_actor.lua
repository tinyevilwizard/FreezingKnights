function new_rest_actor(args)
  local a={
    pos=args.pos,
    flip_x=args.flip_x,
    wdt=8,
    hgt=8,
    elv=args.elv or 0,
    global_update=function(self)
      self.anim_manager:load_next_frame()
    end,
    update=function(self)
      self:global_update()
    end,
    global_draw=function(self)

    end,
    draw=function(self)
      self:draw_sdw()
      self:draw_spr()
    end,
    draw_spr=function(self)
      spr(
        self.anim_manager:current_spr(),
        self.pos.x-(self.wdt/2),
        self.pos.y-self.hgt-self.elv,
        1,
        1,
        self.flip_x
      )
    end,
    draw_sdw=function(self)
      sdw(self.pos.x,self.pos.y,self.wdt,self.hgt)
    end,
  }
  return a
end