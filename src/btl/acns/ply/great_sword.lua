acns.g_sword=function(act)
    local a=new_mle(act,16,"g_sword")
    a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set,a.prepare_g_sword,a.stress_g_sword,a.swing_g_sword,a.stop_g_sword=9,"9♥",46,73,"great sword (FRONT ○ ★★★)",front_enm_acts,function()
      act:set_acn_acc(new_obj(function() spr(8,act.pos.x-19,act.pos.y-5,2,1,t,f) end))
    end,function()
      act:shake()
      act.ptcm:fire_sweat()
      sfx"57"
    end,function()
      act:set_acn_acc(
        new_obj(function()
          spr(24,act.pos.x+2,act.pos.y-15,2,3)
          spr(55,act.pos.x-6,act.pos.y-15)
        end)
      )
    end,function()
      act:set_acn_acc(new_obj(function() spr(8,act.pos.x+2,act.pos.y-3,2,1) end))
      act.atk_hb=new_hitbox(act,"attack|enm|8|8|t|8,0")
    end

    return a
end