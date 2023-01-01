hitboxes={}

-- data example: "attack|enm,ply|8|32|t|8,0" and "attack||8|32|"
function new_hitbox(act,data)
  local t=split(data or "attack|ply|8|8|t","|")
  local hb={
    tag=t[1] or '',
    tag_triggers=split(t[2]) or {},
    act=act,
    w=t[3] or act.wdt,
    h=t[4] or act.hgt,
    offset_pos=parse_pos(t[6] or "0,0"),
    flw_act=t,
    del_on_trigger=is_present(t[5]),
--colliding_with=nil,
--colliding=f,
    active=t,
--draw=function(self)
--c=8
--if (self.colliding) c=12
--if (not self.active) c=6
--local p=self:pos()
--rect(p.x-self.w/2,p.y,p.x+self.w/2,p.y-self.h,c)
--end,
    update=function(self)
      self.colliding=f
      self.colliding_with=nil

      if self.active then
        local hbs=clone(hitboxes)
        del(hbs,self)
        for hb in all(hbs) do
          if (self:check_collision(hb)) then
            self.colliding,self.colliding_with=t,hb.act
            if (self.del_on_trigger) self:delete()
          end
        end
      end
      return self.colliding
    end,
    check_collision=function(self,hb)
      local p1,p2,check=self:pos(),hb:pos(),f
      for tag in all(self.tag_triggers) do
        if (hb.tag==tag and hb.active) check=t
      end
      return (check and abs(self.act.pos.y-hb.act.pos.y) < 8 and (p1.x < p2.x + hb.w) and (p1.x + self.w > p2.x) and (p1.y < p2.y + hb.h) and (p1.y + self.h > p2.y))
    end,
    pos=function(self)
      return pos_clone(self.act.pos,self.offset_pos.x,-self.act.elv+self.offset_pos.y)
    end,
    delete=function(self)
      del(hitboxes,self)
      self.active=f
    end
  }
  add(hitboxes,hb)
  return hb
end