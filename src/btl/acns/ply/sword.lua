acns.sword=function(act)
    local a=new_mle(act,5,"sword")
    a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.prepare_sword,a.swing_sword,a.stop_sword=1,"1♥",13,9,"sword (FRONT ○ ★★)",front_enm_acts,function()
      act:set_acn_acc(new_obj(function() spr(7,act.pos.x-11,act.pos.y-9,1,1,t,t) end))
    end,function()
      act:set_acn_acc(
        new_obj(function()
          local x,y=act.pos.x,act.pos.y
          spr(23,x+2,y-10,1,2)
          spr(55,x-6,y-10)
        end)
      )
    end,function()
      act:set_acn_acc(new_obj(function() spr(7,act.pos.x+2,act.pos.y-4) end))
      act.atk_hb=new_hitbox(act,"attack|enm|8|8|t|8,0")
    end

    return a
end

acns.sword2=function(act)
  local a=acns.sword(act)
  a.hint,a.pwr="sword+ (FRONT ○ ★★)",7
  return a
end