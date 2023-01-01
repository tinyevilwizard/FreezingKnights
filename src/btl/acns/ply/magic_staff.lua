acns.staff=function(act,upgraded)
  local a=new_ran(act,3,"staff",pos_clone(mid_pos,-12))
  a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.multi_select,a.upgraded,a.prepare_staff,a.fire_staff,a.fire_staff_trigger_dmg=5,"5♥",45,57,"fire staff (ALL ○ ★)",enm_acts,t,upgraded,function()
    act:set_acn_acc(new_obj(function()
      sspr(88,8,8,1,act.pos.x-1,act:elv_y()-2)
      sspr(88,9,8,5,act.pos.x+7,act:elv_y()-4)
    end))
  end,function()
    local obj=new_obj(
      function(self)
        self.ptcm:draw()
      end,
      function(self)
        if self.fire_particles then
          self.ptcm:fire"8,9,10|20,30,40|0.8,1,1.2,1.4|-0.6,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.6|1|2,3|-0.0001"
          sfx"61"
        end
        self.ptcm:update()
      end,
      pos_clone(act.pos,12,-1)
    )
    obj.fire_particles=t
    act:add_acn_acc(obj)
  end,function()
    act.selected_acn.accs[2].fire_particles=f
    for a in all(enm_acts()) do
      act.selected_acn:dmg_act(a)
      if (act.selected_acn.upgraded) a:set_atk_mod(-2,2)
    end
  end

  return a
end

acns.staff2=function(act)
  local a=acns.staff(act,t)
  a.hint="f. staff+ (ALL ○ DEBUFF ○ ★)"
  return a
end