acns.bow=function(act,upgraded)
  local a=new_ran(act,3,"bow",pos_clone(act.spw,16))
  a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.upgraded,a.shoot_arrow=1,"1♥",15,41,"bow (ANY ○ ★)",enm_acts,upgraded,function()
    act:set_acn_acc(new_obj(
      function(self) sspr(96,13,6,3,self.pos.x-4,self.pos.y-4) end,
      function(self)
        if mv(self,pos_clone(act.target.pos,0,-act.target.elv),5) then
          act.selected_acn:dmg_act(act.target)
          act:clear_acn_acc()
          if (act.selected_acn.upgraded) act:set_atk_mod(3,3)
        end
      end,
      act.pos
    ))
    sfx"58"
  end

  return a
end

acns.bow2=function(act)
  local a=acns.bow(act,t)
  a.hint="bow+ (ANY ○ BUFF ○ ★)"
  return a
end