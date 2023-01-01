function new_mle(act,pwr,anim,x_offset)
  local a=new_acn(act,pwr,anim)

  a.move=function(self)
    if not self.target_reached then
      self:run_to_target(pos_clone(act.target.atk_pos,x_offset or 0))
      self.acting=self.target_reached
    end
  end

  return a
end