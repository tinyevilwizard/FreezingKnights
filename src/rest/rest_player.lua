function new_rest_player(name,player,player_pal,max_hp,acns_data,args,last_ply)
  local a=new_rest_actor(args)
  a.last_ply=last_ply
  a.player=player
  a.pal=player_pal
  if a.flip_x then
    a.confirm_btn_prompt=new_btn_prompt(confirm_btn_lbl,pos_clone(args.pos,56,-8),player_pal.armor)
  else
    a.confirm_btn_prompt=new_btn_prompt(confirm_btn_lbl,pos_clone(args.pos,-56,-8),player_pal.armor)
  end

  a.anim_manager=new_anim_manager(new_anims "idle$2,100|3,10|2,400|3,10|2,5|3,10|2,400|6,300|2,60|3,10|2,300|3,10|2,5|3,10|2,300|7,5|8,200|7,5$t$$t&think$4,60|5,10|4,300|5,5|4,5|5,5|4,200$t$$t&relax$6,20|20,60|16,60|18,4|19,120|18,4|16,60|17,6|16,180|20,60|20,60|16,120|18,4|19,120|18,4|16,20|2,40|2,1,end_relax",a)
  a.anim_manager:play("idle")
  a.max_hp=max_hp
  a.acns_data=acns_data
  a.update=function(self)
    self:global_update()
    if (self.menu) self.menu:update()

    if self.choosing then
      if a.flip_x then
        mv(a.confirm_btn_prompt,pos_clone(self.pos,9,-8),2)
      else
        mv(a.confirm_btn_prompt,pos_clone(self.pos,-16,-8),2)
      end
    else
      if a.flip_x then
        mv(a.confirm_btn_prompt,pos_clone(self.pos,48,-8),3)
      else
        mv(a.confirm_btn_prompt,pos_clone(self.pos,-56,-8),3)
      end
    end

    if self.relaxing and btnp(cancel_btn,self.player) then
      self:end_relax()
    end
  end
  a.draw=function(self)
    self:draw_sdw()
    set_ply_colors(self.pal)
    self:draw_spr()
    pal()
    self:global_draw()
    self.confirm_btn_prompt:draw()
    --self.confirm_btn_prompt:draw()
  end
  a.draw_sdw=function(self)
    if self.flip_x then
      sdw(self.pos.x+1,self.pos.y,self.wdt+4,self.hgt)
    else
      sdw(self.pos.x-2,self.pos.y,self.wdt+4,self.hgt)
    end
  end
  a.start_turn=function(self)
    self.anim_manager:play("think")
    self.choosing=t
    self:new_actions_menu()
  end
  a.relax=function(self)
    self.choosing=f
    self.relaxing=t
    self.anim_manager:play("relax")
  end
  a.end_relax=function(self)
    self.choosing=t
    self.relaxing=f
    self:start_turn()
  end

  a.new_actions_menu=function(self)
    local actions={}
    local x=7
    add(actions,{icon=11,hint=name..": buy equipment",btn_x=x,event=function()
      self:new_buy_menu()
    end})
    x+=16
    add(actions,{icon=12,hint=name..": buy upgrade",btn_x=x,event=function()
      self:new_upgrade_menu()
    end})
    x+=16
    add(actions,{icon=10,hint="sit and relax",btn_x=x,event=function()
      self:relax()
      self:close_menu()
    end})
    x+=16
    add(actions,{icon=14,btn_x=103,hint="confirm and continue",alt_pal=t,event=function()
      self:end_turn()
    end})

    local items={}
    for a in all(actions) do
      add(items,{
        hint=a.hint,
        draw=function(self2,active)
          if active then
            pal(1,self.pal.armor)
            pal(6,7)
            pal(5,self.pal.armor_dark)
          elseif a.alt_pal then
            pal(1,13)
            pal(5,1)
          end
          pal(13,0)
          spr(42,a.btn_x,11,1,2)
          spr(42,a.btn_x+8,11,1,2,t)
          spr(a.icon,a.btn_x+4,15,1,1,f,a.flip_y)
          pal()
          if (active) then
            sspr(101,8,3,5,a.btn_x+14,16)
            sspr(101,8,3,5,a.btn_x-1,16,3,5,t)
          end
        end,
        on_confirm=function()
          a.event()
        end,
      })
    end
    self.menu=new_menu(
      items,
      self.player,
      function(self2)
        if (self.last_ply) self:previous_turn()
      end,
      1,
      function(self2)
        sm_tb(3,3,124,self.pal.armor,self2.hint or "")
      end
    )
  end

  a.new_buy_menu=function(self)
    local actions={}
    local x=7

    swd1_cost=30
    add(actions,{icon=15,hint="buy weapon: sword ○ "..swd1_cost..money_char,desc0="bUY SWORD FOR "..name..".",desc1="dAMAGES ANY FRONT GROUNDED",desc2="ENEMY.",desc3="dAMAGE: ★★ ○ cOST: 1♥",btn_x=x,sold_out=function() return self.acns_data.swd1==1 end,available=function() return rst.gold>=swd1_cost end,event=function()
      pay_cost(swd1_cost)
      self.acns_data.swd1=1
    end})
    x+=16

    shd1_cost=30
    add(actions,{icon=27,hint="buy weapon: shield ○ "..shd1_cost..money_char,desc0="bUY SHIELD FOR "..name..".",desc1="dAMAGES ANY FRONT GROUNDED",desc2="ENEMY AND REDUCES DEFENSE.",desc3="dAMAGE: ★ ○ cOST: 2♥",btn_x=x,sold_out=function() return self.acns_data.shd1==1 end,available=function() return rst.gold>=shd1_cost end,event=function()
      pay_cost(shd1_cost)
      self.acns_data.shd1=1
    end})
    x+=16

    bow1_cost=30
    add(actions,{icon=26,hint="buy weapon: bow ○ "..bow1_cost..money_char,desc1="bUY BOW FOR "..name..".",desc2="dAMAGES ANY ENEMY.",desc3="dAMAGE: ★ ○ cOST: 1♥",btn_x=x,sold_out=function() return self.acns_data.bow1==1 end,available=function() return rst.gold>=bow1_cost end,event=function()
      pay_cost(bow1_cost)
      self.acns_data.bow1=1
    end})
    x+=16

    stf1_cost=50
    add(actions,{icon=31,hint="buy weapon: fire staff ○ "..stf1_cost..money_char,desc1="bUY FIRE STAFF FOR "..name..".",desc2="dAMAGES ALL ENEMIES.",desc3="dAMAGE: ★ ○ cOST: 5♥",btn_x=x,sold_out=function() return self.acns_data.stf1==1 end,available=function() return rst.gold>=stf1_cost end,event=function()
      pay_cost(stf1_cost)
      self.acns_data.stf1=1
    end})
    x+=16

    g_swd1_cost=125
    add(actions,{icon=30,hint="buy weapon: gr. sword ○ "..g_swd1_cost..money_char,desc0="bUY GREAT SWORD FOR "..name..".",desc1="dAMAGES ANY FRONT GROUNDED",desc2="ENEMY. eTREMELY HEAVY.",desc3="dAMAGE: ★★★ ○ cOST: 9♥",btn_x=x,sold_out=function() return self.acns_data.g_swd1==1 end,available=function() return rst.gold>=g_swd1_cost end,event=function()
      pay_cost(g_swd1_cost)
      self.acns_data.g_swd1=1
    end})
    x+=16

    add(actions,{icon=44,btn_x=103,hint="back to actions",not_action=t,alt_pal=t,sold_out=function() return f end,available=function() return t end,event=function()
      self:new_actions_menu()
    end})

    local items={}
    for a in all(actions) do
      add(items,{
        hint=a.hint,
        draw=function(self2,active)
          if active then
            if a:available() and not a:sold_out() then
              pal(1,self.pal.armor)
              pal(5,self.pal.armor_dark)
            else
              pal(1,5)
              pal(5,2)
            end
            pal(6,7)
          elseif a.alt_pal then
            pal(1,13)
            pal(5,1)
          end
          pal(13,0)
          spr(42,a.btn_x,11,1,2)
          spr(42,a.btn_x+8,11,1,2,t)
          if a:sold_out() then
            spr(46,a.btn_x+4,15,1,1,f,a.flip_y)
          else
            spr(a.icon,a.btn_x+4,15,1,1,f,a.flip_y)
            if (not a.not_action) sspr(98,13,3,3,a.btn_x+11,22)
          end
          pal()
          if (active) then
            sspr(101,8,3,5,a.btn_x+14,16)
            sspr(101,8,3,5,a.btn_x-1,16,3,5,t)
            if (a.desc0) sm_tb(3,82,124,self.pal.armor_dark,a.desc0 or "")
            if (a.desc1) sm_tb(3,90,124,self.pal.armor_dark,a.desc1 or "")
            if (a.desc2) sm_tb(3,98,124,self.pal.armor_dark,a.desc2 or "")
            if (a.desc3) sm_tb(3,106,124,self.pal.armor_dark,a.desc3 or "")
          end
        end,
        on_confirm=function()
          if a:available() and not a:sold_out() then
            a.event()
          end
        end,
      })
    end
    self.menu=new_menu(items,self.player,function(self2)
      self:new_actions_menu()
    end,1,function(self2)
      sm_tb(3,3,124,self.pal.armor,self2.hint or "")
    end)
  end

  a.new_upgrade_menu=function(self)
    local actions={}
    local x=7

    ptn_increase_cost=30
    max_total_ptn=dget"16">=1 and 10 or 20
    add(actions,{icon=29,hint="buy upgrade: potions ○ "..ptn_increase_cost..money_char,desc1="iNCREASES THE MAX AMOUNT OF",desc2=potion_char..". "..potion_char.." ARE REFILLED WHEN",desc3="REACHING A REST AREAS.",btn_x=x,sold_out=function() return rst.max_potions >= max_total_ptn end,available=function() return rst.gold>=ptn_increase_cost end,event=function()
      pay_cost(ptn_increase_cost)
      increase_max_potions()
    end})
    x+=16

    max_hp_increase_cost=15
    max_hp_limit=dget"16">=1 and 30 or 50
    add(actions,{icon=13,hint="buy upgrade: health ○ "..max_hp_increase_cost..money_char,desc1="iNCREASES "..name.."'S MAX",desc2="AMOUNT OF ♥. ♥ ARE RESTORED",desc3="AFTER AN ENCOUNTER.",btn_x=x,sold_out=function() return self.max_hp>=max_hp_limit end,available=function() return rst.gold>=max_hp_increase_cost end,event=function()
      pay_cost(max_hp_increase_cost)
      self.max_hp=min(max_hp_limit,self.max_hp+5)
    end})
    x+=16

    swd2_cost=60
    add(actions,{icon=15,hint="buy upgrade: sword+ ○ "..swd2_cost..money_char,desc2="rEQUIRES A SWORD.",desc3="iNCREASES DAMAGE.",btn_x=x,sold_out=function() return self.acns_data.swd2==1 end,available=function() return self.acns_data.swd1==1 and rst.gold>=swd2_cost end,event=function()
      pay_cost(swd2_cost)
      self.acns_data.swd2=1
    end})
    x+=16

    shd2_cost=60
    add(actions,{icon=27,hint="buy upgrade: shield+ ○ "..shd2_cost..money_char,desc1="rEQUIRES A SHIELD.",desc2="tEMPORARILY INCREASES",desc3="KNIGHT'S DEFENSE WHEN USED.",btn_x=x,sold_out=function() return self.acns_data.shd2==1 end,available=function() return self.acns_data.shd1==1 and rst.gold>=shd2_cost end,event=function()
      pay_cost(shd2_cost)
      self.acns_data.shd2=1
    end})
    x+=16

    bow2_cost=60
    add(actions,{icon=26,hint="buy upgrade: bow+ ○ "..bow2_cost..money_char,desc1="rEQUIRES A BOW.",desc2="tEMPORARILY INCREASES",desc3="KNIGHT'S ATTACK WHEN USED.",btn_x=x,sold_out=function() return self.acns_data.bow2==1 end,available=function() return self.acns_data.bow1==1 and rst.gold>=bow2_cost end,event=function()
      pay_cost(bow2_cost)
      self.acns_data.bow2=1
    end})
    x+=16

    stf2_cost=70
    add(actions,{icon=31,hint="buy upgrade: f. staff+ ○ "..stf2_cost..money_char,desc1="rEQUIRES A FIRE STAFF.",desc2="tEMPORARILY DECREASES ATTACK",desc3="FOR ALL ENEMIES WHEN USED.",btn_x=x,sold_out=function() return self.acns_data.stf2==1 end,available=function() return self.acns_data.stf1==1 and rst.gold>=stf2_cost end,event=function()
      pay_cost(stf2_cost)
      self.acns_data.stf2=1
    end})
    x+=16

    add(actions,{icon=44,btn_x=103,hint="back to actions",alt_pal=t,sold_out=function() return f end,available=function() return t end,event=function()
      self:new_actions_menu()
    end})

    local items={}
    for a in all(actions) do
      add(items,{
        hint=a.hint,
        draw=function(self2,active)
          if active then
            if a:available() and not a:sold_out() then
              pal(1,self.pal.armor)
              pal(5,self.pal.armor_dark)
            else
              pal(1,5)
              pal(5,2)
            end
            pal(6,7)
          elseif a.alt_pal then
            pal(1,13)
            pal(5,1)
          end
          pal(13,0)
          spr(42,a.btn_x,11,1,2)
          spr(42,a.btn_x+8,11,1,2,t)
          if a:sold_out() then
            spr(46,a.btn_x+4,15,1,1,f,a.flip_y)
          else
            spr(a.icon,a.btn_x+4,15,1,1,f,a.flip_y)
          end
          if (not a.alt_pal and a.available) sspr(101,13,3,3,a.btn_x+11,22)
          pal()
          if (active) then
            sspr(101,8,3,5,a.btn_x+14,16)
            sspr(101,8,3,5,a.btn_x-1,16,3,5,t)
            if (a.desc1) sm_tb(3,90,124,self.pal.armor_dark,a.desc1 or "")
            if (a.desc2) sm_tb(3,98,124,self.pal.armor_dark,a.desc2 or "")
            if (a.desc3) sm_tb(3,106,124,self.pal.armor_dark,a.desc3 or "")
          end
        end,
        on_confirm=function()
          if a:available() and not a:sold_out() then
            a.event()
          end
        end,
      })
    end
    self.menu=new_menu(items,self.player,function(self2)
      self:new_actions_menu()
    end,1,function(self2)
      sm_tb(3,3,124,self.pal.armor,self2.hint or "")
    end)
  end

  a.close_menu=function(self)
    self.menu=nil
  end

  a.end_turn=function(self)
    self:close_menu()
    self.choosing=f
    rest_turn_done()
    self.anim_manager:play("idle")
  end

  a.previous_turn=function(self)
    self:close_menu()
    self.choosing=f
    previous_rest_turn()
    self.anim_manager:play("idle")
  end

  return a
end