acns.g_bag=function(act)
  local a=new_ran(act,5,"gold_bag",pos_clone(act.spw,16))
  a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.available,a.throw_gold_bag="5"..money_char,44,89,"sneaky coin bag (ANY ○ ★★)",enm_acts,function()
    return gold>=5
  end,function()
    gold=max(gold-5,0)
    sfx"58"
    act:set_acn_acc(new_obj(
      function(self)
        spr(26,self.pos.x-4,self.pos.y-8)
      end,
      function(self)
        if mv(self,pos_clone(act.target.pos,0,-act.target.elv),4) then
          act.selected_acn:dmg_act(act.target)
          act:clear_acn_acc()
          act.target.ptcm:fire"9,10,15,4|18,20,22|-0.3,-0.2,-0.1,0,0.1,0.2,0.3|1,1.3,1.6,1.9,2.1|20|1|0.1"
        end
      end,
      act.pos
    ))
  end

  return a
end