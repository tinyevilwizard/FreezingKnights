function new_btl_ply(btn,btn_lbl,player,player_pal,acns_data,args)
  local a=new_btl_act(args)
  a.name,a.type,a.pal,a.wlk_spd,a.pos,a.atk_pos,a.shake_cam_on_hit=args.name,"ply",player_pal,1.75,new_pos(-64,args.spw.y),pos_clone(args.spw,10),t
  --a.choosing=f
  --a.menu=nil
  a:set_sts(args.sts)
  a.action_btn_prompt,a.confirm_btn_prompt=new_btn_prompt(btn_lbl,pos_clone(args.spw,-40,-8),player_pal.armor),new_btn_prompt(confirm_btn_lbl,pos_clone(args.spw,-40,-8),player_pal.armor)
  a.anim_manager=new_anim_manager(
    new_anims "idle$5,60|6,10|5,300|6,10|5,5|6,10|5,200$t$$t&run$1,5|32,5|1,5|34,5$t&victory$4,20|2,20$t&think$18,60|19,10|18,300|19,10|18,5|19,10|18,200$t$$t&land$22,3$$idle&jump$20$t&fall$21$t&dmg$3,30|2,2|1,1$$idle&dead$17$t&sword$48,20,prepare_sword|50,2,swing_sword|51,30,stop_sword|51,100,set_done_acting&shield$5,40,prepare_shield|32,60,shield_bash|32,100,set_done_acting&shield_knock_back$3,40,knock_back_shield|3,100,set_done_acting&bow$37,60|38,40,shoot_arrow|38,100,set_done_acting&staff$5,40,prepare_staff|5,120,fire_staff|5,40,fire_staff_trigger_dmg|5,100,set_done_acting&gold_bag$48,40|51,40,throw_gold_bag|51,100,set_done_acting&g_sword$52,60,prepare_g_sword|53,60,stress_g_sword|35,2,swing_g_sword|36,30,stop_g_sword|36,100,set_done_acting&heal$16,40,hold_potion|16,20,consume_potion|16,100,set_done_acting&pet$54,10,pet_the_cat|33,10|54,10|33,10|54,10|33,10|54,10|33,10|54,10|33,10|33,1,set_done_acting",
    a
  )
  a.acns={}
  for d in all({{acns_data.swd1,acns_data.swd2==1 and acns.sword2 or acns.sword},{acns_data.shd1,acns_data.shd2==1 and acns.shield2 or acns.shield},{acns_data.bow1,acns_data.bow2==1 and acns.bow2 or acns.bow},{acns_data.stf1,acns_data.stf2==1 and acns.staff2 or acns.staff},{acns_data.g_swd1,acns.g_sword},{acns_data.bag1,acns.g_bag},{acns_data.ptn1,acns.potion}}) do
    if (d[1]==1) add(a.acns,d[2](a))
  end
  a.draw=function(self)
    set_ply_colors(self.pal)
    self:draw_spr()
    pal()
    self:global_draw()
    self.action_btn_prompt:draw()
    self.confirm_btn_prompt:draw()
  end
  a.update=function(self)
    self:global_update()
    if (self.menu) self.menu:update()

    if not self.intro_done then
      self:play_or_continue_anim "run"
      if mv(self,self.spw,1.25) then
        self.intro_done=t
        self:play_anim "idle"
      end
      return nil
    end

    if not self.dead and ply_defending() then
      if (btnp(btn,player) and not self.air) self:jump(2.75) -- Less heavy alt jump: 2.5
      mv(a.action_btn_prompt,pos_clone(self.spw,-16,-8),2)
    else
      mv(a.action_btn_prompt,pos_clone(self.spw,-40,-8),3)
    end

    if not self.dead and self.choosing then
      mv(a.confirm_btn_prompt,pos_clone(self.spw,-16,-8),2)
    else
      mv(a.confirm_btn_prompt,pos_clone(self.spw,-40,-8),3)
    end

    if celebrate then
      self:play_or_continue_anim"victory"
    elseif self.choosing then
      self:play_or_continue_anim"think"
    end
  end
  a.die=function(self)
    self.dead,self.body_hb.active=t,f
    self:play_or_continue_anim"dead"
    self:reset_mods()
    handle_death()
  end
  a.start_turn=function(self)
    if self.dead then
      btl_start_next_turn()
    else
      self.choosing=t
      self:new_actions_menu()
    end
  end
  a.close_menu=function(self,clear_hint)
    self.menu=nil
    if (clear_hint) self.hint=nil
  end
  a.new_actions_menu=function(self)
    local items = {}
    for a in all(self.acns) do
      add(items,{
        draw=function(self2,active)
          local lbl_c=7
          if active then
            if a:available() then
              pal(1,self.pal.armor)
              if (a.cost==self.active_sts.hp) lbl_c=13
            else
              pal(1,5)
              lbl_c=8
            end
            pal(6,7)
            pal(5,self.pal.armor_dark)
            self2.y_offset=min(self2.y_offset+2.5,11)
          else
            self2.y_offset=max(self2.y_offset-2.5,3)
          end
          rectfill(a.btn_x,self2.y_offset,a.btn_x+13,self2.y_offset+27,1)
          pal(13,0)
          spr(12,a.btn_x,self2.y_offset+28)
          spr(12,a.btn_x+6,self2.y_offset+28,1,1,t)
          spr(a.icon,a.btn_x+3,self2.y_offset+10,1,2)
          pal()
          if (active) then
            ? a.cost_str,a.btn_x+2,self2.y_offset+2,lbl_c
            sspr(101,8,3,5,a.btn_x+13,self2.y_offset+9)
            sspr(101,8,3,5,a.btn_x-2,self2.y_offset+9,3,5,t)
          end
        end,
        hint=a.hint,
        action=function()
          if a:available() then
            self.selected_acn=a
            self:close_menu()
            self:new_target_select_menu(a.act_set(a.inc_dead),a.multi_select)
          end
        end,
        y_offset=3,
      })
    end
    self.menu=new_select(items,self,player)
  end
  a.new_target_select_menu=function(self,act_set,multi_select)
    local items={}
    for a in all(act_set) do
      add(items,{
        draw=function(self2,active)
          if (active) sspr(96,8,5,5,a.pos.x-2,a:elv_y(t,t)-5)
        end,
        hint="target: "..(multi_select and "all" or a.name),
        action=function()
          self:attack_target(a)
          self:close_menu(t)
        end,
      })
    end
    self.menu=new_select(items,self,player,function()
      self:close_menu()
      self:new_actions_menu()
    end,multi_select)
  end
  a.body_hb.tag,a.body_hb.w,a.body_hb.h="ply",4,6
  return a
end
