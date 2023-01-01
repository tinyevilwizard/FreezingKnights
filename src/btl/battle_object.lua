function new_obj(draw,update,pos,elv,flw_act,hb_data,draw_sdw)
  local obj={draw=draw,update=update,pos=pos and clone(pos) or new_pos(0,9999),elv=elv or 0,flw_act=flw_act}
  obj.hb,obj.ptcm,obj.draw_sdw=hb_data and new_hitbox(obj,hb_data),new_ptc_manager(obj),draw_sdw
  return obj
end

function new_enm_acn_projectile(act,sprite,spd,target,anims,pos,ptc_str,elv,prevent_sdw,add_update,pal_fn)
  local pos=pos or act.pos
  local obj=new_obj(
    function(self)
      if self.pos.x > -10 then
        self.ptcm:draw()
        if (self.pal_fn) self:pal_fn()
        spr(self.anim_manager and self.anim_manager:current_spr() or sprite,self.pos.x-4,self.pos.y-8-self.elv)
        pal()
      end
    end,
    function(self)
      if self.pos.x > -10 then
        if (self.anim_manager) self.anim_manager:play_or_continue"idle"
        if (self.hb:update()) act.selected_acn:dmg_act(self.hb.colliding_with)
        mv_ang(self,self.ang,self.spd)
        if (self.add_update) self:add_update()
        if (self.anim_manager) self.anim_manager:load_next_frame()
        if (self.pos.x <= -10) self.hb:delete()
        if ptc_str then
          if (not self.stop_ptc) self.ptcm:fire(ptc_str,pos_clone(self.pos,-1,-3-self.elv))
          self.ptcm:update()
        end
      end
    end,
    pos,
    elv or 0,
    f,
    "attack|ply|8|8|t",
    function(self)
      if (not prevent_sdw) sdw(self.pos.x,self.pos.y,8)
    end
  )
  obj.spd,obj.ang,obj.add_update,obj.pal_fn,obj.anim_manager=spd,ang_to({pos=pos},target.pos),add_update,pal_fn,anims and new_anim_manager(new_anims(anims),act)
  act:add_acn_acc(obj)
  return obj
end