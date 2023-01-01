acns.shield=function(act,upgraded)
  local a=new_mle(act,1,"shield",-10)
  a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.upgraded,a.prepare_shield,a.shield_bash,a.knock_back_shield=2,"2♥",14,25,"shield (FRONT ○ DEBUFF ○ ★)",front_enm_acts,upgraded,function()
    act:set_acn_acc(new_obj(function() sspr(80,0,4,6,act.pos.x+1,act:elv_y()-6) end))
    if (act.selected_acn.upgraded) act:set_def_mod(3,2)
  end,function()
    act:start_mov(pos_clone(act.target.pos,-4),3)
    act:add_acn_acc(new_obj(nil,
      function(self)
        if self.hb:update() then
          act.selected_acn:dmg_act(self.hb.colliding_with)
          act.target:set_def_mod(-2,2)
          act.selected_acn.anim="shield_knock_back"
        end
      end,
      act.pos,
      0,
      t,
      "attack|enm|8|8|t|2,0"
    ))
  end,function()
    act:jump(2,t)
    act:start_mov(pos_clone(act.target.pos,-30),1)
  end

  return a
end

acns.shield2=function(act)
  local a=acns.shield(act,t)
  a.hint="shield+ (FRONT ○ DEBUFF ○ ★)"
  return a
end