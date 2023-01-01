acns={}

function new_acn(act,pwr,anim,act_set,return_after)
  acn={}
--acn.name=nil
--acn.act=nil
--acn.acting=f
--acn.done_acting=f
--acn.target_reached=f
--acn.started_return_to_spw
--acn.started_run_to_target=f
--acn.inc_dead=f
  acn.cost,acn.anim,acn.start_anim,acn.accs,acn.pwr,acn.act_set=0,anim,anim,{},pwr,act_set or ply_acts

  if return_after then
    acn.move=function(self)
      self.target_reached,self.acting=t,t
    end
  end

  acn.update=function(self)
    if (self.move) self:move()
    self:update_accs()
    self:update_anim(self.anim)
    self:update_finish()
  end

  acn.execute=function(self)
    self.done_acting,self.acting,self.target_reached,self.started_return_to_spw,self.started_run_to_target,self.anim=f,not self.move,f,f,f,self.start_anim
  end

  acn.finish=function(self)
    if self.move and not self.started_return_to_spw then
      act:start_mov(act.spw,2.5,"run")
      self.started_return_to_spw=t
    elseif not act.moving then
      self:pay_cost()
      act:end_turn()
    end
  end

  acn.draw_accs,acn.update_accs=function(self)
    for acc in all(self.accs) do
      if (acc.draw) acc:draw()
    end
  end,function(self)
    for acc in all(self.accs) do
      if (acc.pos and acc.flw_act) acc.pos=clone(act.pos)
      if (acc.update) acc:update()
    end
  end

  acn.run_to_target=function(self,pos)
    if not self.started_run_to_target then
      act:start_mov(pos,act.wlk_spd,"run")
      self.started_run_to_target=t
    end
    if (is_same_pos(act.pos,pos)) self.target_reached=t
  end

  acn.dmg_target=function(self)
    self:dmg_act(act.target)
  end

  acn.dmg_act=function(self,target_act)
    target_act:take_dmg(max(self.pwr*act.pwr_multi+act.atk_mod,0))
  end

  acn.pay_cost,acn.available,acn.set_done_acting=function(self)
    if (self.cost>0) act:take_dmg(self.cost,t)
  end,function(self)
    return self.cost<=0 or act.active_sts.hp>=self.cost
  end,function(act)
    act:clear_acn_acc()
    if (act.atk_hb) act.atk_hb:delete()
    act.selected_acn.done_acting=t
  end

  -- For use in action update function
  acn.update_anim,acn.update_finish=function(self,anim)
    if self.acting and not self.done_acting then
      act:play_or_continue_anim(anim)
    end
  end,function(self)
    if self.done_acting then
      self:finish()
    end
  end

  return acn
end