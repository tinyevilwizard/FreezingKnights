enms[70]=function(args)
  local a=new_btl_act(args)
  a:set_sts{hp=999}
  a:set_acns"give_potions"
  a.name,a.gold,a.anim_manager="chicken",0,
  new_anim_manager(
    new_anims"idle$187,30|188,30$t$$t&dmg$189,40,revenge$$idle&happy$189,120$$idle&give_potions$187,20|188,20,happy_jump|188,60,happy_jump|188,10,spawn_potions|188,20|187,10|187,60|187,10|187,60|187,10,add_potions|187,60|187,10|187,60|187,10|187,60|187,10|187,1000,end_battle"
  ,a)

  a.revenge=function()
    ply1:take_dmg(99)
    ply2:take_dmg(99)
  end

  a.die=function()
  end

  local accs_chickens_pos=s_split"100,98,126|92,72,125|76,68,126|104,62,126|116,108,191|70,94,125|64,112,126|48,62,125"
  for i=1,#accs_chickens_pos do
    add(map_accs,{spr=accs_chickens_pos[i][3],pos=new_pos(accs_chickens_pos[i][1],accs_chickens_pos[i][2]),
      draw=function(self)
        local x,y=self.pos.x,self.pos.y
        spr(self.spr,x-(8/2),y-8,8/8,2)
      end,
      draw_sdw=function(self)
        sdw(self.pos.x,self.pos.y,8,8)
      end
    })
  end

  ply1:set_acns"pet1,pet2,pet3,pet4,pet5,pet6,pet7"
  ply2:set_acns"pet1,pet2,pet3,pet4,pet5,pet6,pet7"

  return a
end