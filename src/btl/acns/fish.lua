tutorial_step=0

acns.fish_tutorial=function(act)
  local a=new_acn(act,1,"tutorial")
  a.tutorial=function(act)
    tutorial_step+=1
    act:add_acn_acc(new_obj(
      function()
        if tutorial_step==1 then
          sm_tb(3,3,124,13,'eVADE ENEMY ATTACKS!')
          sm_tb(3,14,124,ply1.pal.armor_dark,'pRESS 🅾️ FOR KNIGHT A.',ply1.pal.armor)
          sm_tb(3,22,124,ply2.pal.armor_dark,'pRESS ❎ FOR KNIGHT B.',ply2.pal.armor)
        elseif tutorial_step==2 then
          sm_tb(3,3,124,13,'aCTIONS HAVE A COST!')
          sm_tb(3,14,124,13,'1♥ ▶ cOSTS 1 hp TO USE')
          sm_tb(3,22,124,13,'1'..potion_char..' ▶ cOSTS 1 POTION TO USE')
          sm_tb(3,30,124,13,'5'..money_char..' ▶ cOSTS 5 COINS TO USE')
        elseif tutorial_step==3 then
          sm_tb(3,3,124,13,'aCTIONS HAVE A POWER LEVEL!')
          sm_tb(3,14,124,13,'★     ▶ lOW DAMAGE')
          sm_tb(3,22,124,13,'★★   ▶ mEDIUM DAMAGE')
          sm_tb(3,30,124,13,'★★★ ▶ hIGH DAMAGE')
        elseif tutorial_step==4 then
          sm_tb(3,3,124,13,'aCTIONS HAVE A REACH!')
          sm_tb(3,14,124,13,'FRONT ▶ fRONT ROW ENEMY')
          sm_tb(3,22,124,13,'ANY   ▶ aNY ENEMY')
          sm_tb(3,30,124,13,'ALL   ▶ aLL ENEMIES')
        elseif tutorial_step==5 then
          sm_tb(3,3,124,13,'kEEP TRACK OF YOUR POTIONS!')
          sm_tb(3,14,124,13,'uSE A POTION ('..potion_char..') TO FULLY')
          sm_tb(3,22,124,13,'HEAL OR REVIVE A KNIGHT.')
        elseif tutorial_step==6 then
          sm_tb(3,3,124,13,'sEEK SAFE ZONES!')
          sm_tb(3,14,124,13,'rEACH ONE TO AUTOMATICALLY')
          sm_tb(3,22,124,13,'REFILL YOUR POTIONS AND SAVE')
          sm_tb(3,30,124,13,'YOUR PROGRESS.')
        else
          sm_tb(3,3,124,13,"...aRE WE FRIENDS NOW? :)")
        end
      end
    ))
  end
  a.speak=function()
    sfx"54"
  end
  a.shoot_bubble_p1=function(act)
    new_enm_acn_projectile(act,182,1.2,ply1)
    sfx"58"
  end
  a.shoot_bubble_p2=function(act)
    new_enm_acn_projectile(act,182,1.2,ply2)
    sfx"58"
  end
  return a
end

acns.fish_bubble=function(act)
  local a=new_acn(act,2,"bubble")
  a.shoot_bubble=function(act)
    new_enm_acn_projectile(act,182,1.2,act.target)
    sfx"58"
  end
  return a
end

acns.skip=function(act)
  return new_acn(act,2,"skip")
end