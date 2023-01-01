local pet_the_cat_fns=s_split"1,138,9,pet|2,137,25,cheerfully pet|3,136,41,eagerly pet|4,135,57,elegantly pet|5,134,73,politely pet|6,133,89,bravely pet|7,132,105,gracefully pet"

for i=1,#pet_the_cat_fns do
  local fn=pet_the_cat_fns[i]
  acns["pet"..fn[1]]=function(act)
    local a=new_mle(act,0,"pet",2)
    a.cost,a.cost_str,a.icon,a.btn_x,a.hint,a.act_set=0,"0♥",fn[2],fn[3],fn[4],front_enm_acts

    a.pet_the_cat=function(act)
      act:heal(99)
      act.target:play_anim("happy")
      sfx"60"
    end

    return a
  end
end