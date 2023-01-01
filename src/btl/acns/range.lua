function new_ran(act,pwr,anim,pos)
  local a=new_acn(act,pwr,anim)
  a.pos,a.move=pos,function(self)
    if not self.target_reached then
      self:run_to_target(self.pos or mid_pos)
      self.acting=self.target_reached
    end
  end
  return a
end