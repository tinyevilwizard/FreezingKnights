new_buff_debuff_acn=function(act,amt,dur,fn_name)
  local a=new_acn(act,0,"still_acn",enm_acts)
  a.exe_still_acn=function()
    sfx(amt>0 and 60 or 59)
    act.target[fn_name](act.target,amt,dur)
    act.target:shake()
    act.target.ptcm:fire(amt>0 and "12,1,13|22,24,26,28|-0.3,-0.2,-0.1,0,0.1,0.2,0.3|1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1|20|1|0.09" or "8,2,14|22,24,26,28|-0.3,-0.2,-0.1,0,0.1,0.2,0.3|1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1|20|1|0.09")
--    act:set_acn_acc(new_obj(function(self)
--      spr(amt>0 and 42 or 58,self.pos.x-4,self.pos.y-8-self.elv)
--    end,function(self)
--      self.elv+=amt>0 and 0.1 or -0.1
--    end,act.target.pos))
  end
  return a
end

acns.sm_protect,acns.md_protect,acns.sm_unprotect,acns.md_unprotect=function(act)
  return new_buff_debuff_acn(act,2,2,"set_def_mod")
end,function(act)
  return new_buff_debuff_acn(act,4,3,"set_def_mod")
end,function(act)
  local a=new_buff_debuff_acn(act,-2,2,"set_def_mod")
  a.act_set=ply_acts
  return a
end,function(act)
  local a=new_buff_debuff_acn(act,-4,3,"set_def_mod")
  a.act_set=ply_acts
  return a
end

acns.sm_pwr_up,acns.md_pwr_up,acns.sm_pwr_down,acns.md_pwr_down=function(act)
  return new_buff_debuff_acn(act,2,2,"set_atk_mod")
end,function(act)
  return new_buff_debuff_acn(act,4,3,"set_atk_mod")
end,function(act)
  local a=new_buff_debuff_acn(act,-2,2,"set_atk_mod")
  a.act_set=ply_acts
  return a
end,function(act)
  local a=new_buff_debuff_acn(act,-4,3,"set_atk_mod")
  a.act_set=ply_acts
  return a
end