bonfire={
  pos={x=65,y=85},
  ptcm_t=0,
  update=function(self)
    self.ptcm_t=(self.ptcm_t+1)%7
    if self.ptcm_t==0 then
      self.ptcm:fire("6,6,6,6,13|30,35,40,45,50,55,60,65,70|0.075,0.1,0.15,0.2,0.25|0.2,0.25,0.3,0.35|1,2|1,2,2,2|-0.00001",pos_clone(self.pos,0,-6))
      --self.ptcm:fire_bonfire_fire()
    end
    self.ptcm:update()
    self.anim_manager:load_next_frame()
  end,
  draw=function(self)
    ovalfill(self.pos.x-7,self.pos.y-6,self.pos.x+6,self.pos.y+1,15)
    self.ptcm:draw()
    spr(self.anim_manager:current_spr(),self.pos.x-4,self.pos.y-11)

    spr(48,self.pos.x-4,self.pos.y-8)
  end
}
bonfire.ptcm=new_ptc_manager(bonfire)
bonfire.anim_manager=new_anim_manager(new_anims "idle$49,10|50,10|51,10|52,10|53,10|54,10|55,10|56,10$t",bonfire)
bonfire.anim_manager:play("idle")