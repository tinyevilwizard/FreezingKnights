acns.give_potions=function(act)
  local a=new_acn(act,0,"give_potions")

  a.happy_jump=function(act)
    act:jump(1.25)
  end

  a.spawn_potions=function(act)
    local y_vel=0
    act:set_acn_acc(
      new_obj(
        function(self)
          sspr(91,24,5,7,self.pos.x-2,self.pos.y-7-self.elv)
        end,
        function(self)
          y_vel+=0.02
          self.elv=max(0,self.elv-y_vel)
        end,
        pos_clone(act.pos,-10),
        128,
        f,
        nil,
        function(self)
          sdw(self.pos.x,self.pos.y,8)
        end
      )
    )
  end

  a.add_potions=function(act)
    potions=max_potions
    sfx"60"
    act:set_acn_acc(new_obj(
      function()
        sm_tb(3,3,124,13,'pOTIONS RESTORED!')
      end
    ))
  end

  a.end_battle=function(act)
    btl_ended=t
    fade_out(120,function()
      btl_save()
      load_cart"map"
    end)
  end

  return a
end