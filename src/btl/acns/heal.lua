new_heal_acn=function(act,amt)
  local a=new_acn(act,0,"still_acn",enm_acts)
  a.exe_still_acn=function(act)
    act.target:heal(amt)
    sfx"60"
  end
  return a
end
acns.sm_heal,acns.md_heal=function(act)
  return new_heal_acn(act,5)
end,function(act)
  return new_heal_acn(act,10)
end