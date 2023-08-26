function new_btl_act(args)
  local act_in_front,dmg_pos_mod,dmg_pos_mod_counter,dmg_lbl,dmg_lbl_counter,dmg_y_speed,dmg_lbl_col,dmg_lbl_col_sdw,dmg_lbl_prefix,dmg_lbl_pos,hover_t=args.act_in_front,0,0,nil,0,0,9,2,"",parse_pos "0,0",rnd"120"
  local a={
--type="enm",
--name="",
    spw=args.spw,pos=clone(args.spw),
    atk_pos=pos_clone(args.spw,-10),
    pal_fn=args.pal_fn,
--invincible_t=0
--pwr_multi=1,
--hover=f
--def_mod=0,
--atk_mod=0,
--def_mod_turns=0,
--atk_mod_turns=0,
--mov_pos=nil,
--mov_anim=nil,
--mov_end_anim=nil,
--mov_end_event=nil,
--mov_spd=0,
--moving=f,
--target=nil,
--acting=f,
--intro_done=f,
--shake_cam_on_hit=f,
--sts=nil,
--active_sts=nil,
--y_vel=0,
--elv=0,
--target_elv=0
--elv_spd=0
--hgt=8,
--wdt=8,
--air=f,
--flip_x=f,
--accs={},
--selected_acn=nil,
--anim_manager=nil,
--dead=f,
--acns={},
--wlk_spd=1,
--body_hb=nil,
--atk_hb=nil,
--animate_jump=f,
--add_update=nil,
--ui_hgt=nil,
    global_draw=function(self)
      if (self.pal_fn) self:pal_fn()
      self.ptcm:draw()
    end,
    draw=function(self)
      self:global_draw()
      if (not self.dead) self:draw_spr()
      pal()
    end,
    global_update=function(self)
      self.anim_manager:load_next_frame()

      if self.moving then
        self.moving=not mv(self,self.mov_pos,self.mov_spd)
      end

      if self.elv_spd!=0 then
        self.elv=self.target_elv-self.elv>0 and min(self.elv+self.elv_spd,self.target_elv) or max(self.elv-self.elv_spd,self.target_elv)
      end

      dmg_pos_mod=0
      if dmg_pos_mod_counter>0 then
        dmg_pos_mod_counter-=1
        dmg_pos_mod=(split"-1,-1,1,1")[dmg_pos_mod_counter%4+1]
      end

      if self.invincible_t<=0 and not self.dead then
        self.body_hb.active=t
      else
        self.body_hb.active=f
        self.invincible_t=max(self.invincible_t-1,0)
      end

      if dmg_lbl then
        if dmg_y_speed>0 then
          dmg_lbl_pos.y-=dmg_y_speed
          dmg_y_speed-=2
          if (dmg_y_speed<0) dmg_y_speed=0
        end
        if dmg_lbl_counter>0 then
          dmg_lbl_counter-=1
        else
          dmg_lbl=nil
        end
      end

      if self.acting then
        self.selected_acn:update()
      end

      if self.air then
        self.elv=max(self.elv+self.y_vel,0)
        self.y_vel-=0.25 -- Less heavy alt jump: 0.2
        local anim
        if self.elv <= 0 then
          elv,self.air,anim=0,f,"land"
        elseif self.y_vel > 0 then
          anim="jump"
        else
          anim="fall"
        end
        if (anim and not self.dead and self.animate_jump) self:play_or_continue_anim(anim)
      end

      self.body_hb:update()

      if self.atk_hb then
        self.atk_hb:update()
        if self.atk_hb.colliding then
          self.selected_acn:dmg_act(self.atk_hb.colliding_with)
        end
      end

      self.ptcm:update()

      if (self.add_update) self:add_update()
    end,
    update=function(self)
      self:global_update()
    end,
    jump=function(self,y_vel,no_animation)
      if not self.air then
        self.air,self.y_vel,self.animate_jump=t,y_vel or 1.25,not no_animation
        self.ptcm:fire_snow()
        sfx(57,-2)
        sfx"57"
      end
    end,
    start_mov=function(self,pos,spd,anim)
      self.moving,self.mov_pos,self.mov_spd,self.mov_anim=t,clone(pos),spd,anim
      if (self.mov_anim) self:play_or_continue_anim(self.mov_anim)
    end,
    take_dmg=function(self,pwr,passive,prevent_award_money)
      local dmg=ceil(passive and pwr or max(pwr-self.def_mod,1))
      self.active_sts.hp-=dmg
      if not passive then
        if (self.y_vel>0) self.y_vel=0
        self:play_anim"dmg"
        self:shake()
        shake()
        self.invincible_t=60
        sfx"53"
      end
      self:dmg_label(dmg,14,2,"-")
      if self.active_sts.hp<=0 then
        self.active_sts.hp=0
        self:die(prevent_award_money)
      end
    end,
    heal=function(self,amt)
      self.active_sts.hp=min(self.active_sts.hp+amt,self.sts.hp)
      self:dmg_label(amt,12,1,"+")
      if self.dead then
        self.dead=f
        self:play_anim"idle"
      end
    end,
    die=function(self,prevent_award_money)
      self.dead=t
      self:reset_mods()
      if not prevent_award_money then
        local awarded_gold=ceil(self.gold*(dget"16">=1 and 0.75 or 1))
        gold=min(gold+awarded_gold,999)
        self:dmg_label(awarded_gold,9,1,money_char)
        self.gold=0
      end
      handle_death()
      sfx"62"
      shake(20)
      self.ptcm:fire"1,5,13|50,60,70|0.1,0.2,0.4,0.5,0.6,0.8,1|0.6,0.8,1,1.2,1.4|10|2,3|-0.0001"
    end,
    set_sts=function(self,sts)
      self.sts,self.active_sts=sts,clone(sts)
    end,
    start_turn=function(self)
      if self.dead then
        btl_start_next_turn()
      else
        new_delayed_event(60,function()
          self:exe_rnd_acn()
        end)
      end
    end,
    end_turn=function(self)
      if (not self.dead) self:play_anim"idle"
      self.acting=f
      self:decrement_mods()
      btl_start_next_turn()
    end,
    exe_rnd_acn=function(self)
      self.selected_acn=rnd(self.acns)
      self:attack_target(rnd(self.selected_acn.act_set()))
    end,
    attack_target=function(self,target)
      self.target,self.acting,self.choosing=target,t,f
      if (self.selected_acn) self.selected_acn:execute()
    end,
    draw_spr=function(self)
      hover_t=(hover_t+1)%200
      local hover_mod=self.hover and hover_t>100 and -1 or 0
      spr(
        self.anim_manager:current_spr(),
        self.pos.x-(self.wdt/2)+dmg_pos_mod,
        self:elv_y(t)+hover_mod,
        self.wdt/8,
        self.hgt/8
      )
    end,
    draw_accs=function(self)
      if (self.selected_acn) self.selected_acn:draw_accs()
    end,
    draw_sdw=function(self)
      if (self.type=="ply" or not self.dead) sdw(self.pos.x,self.pos.y,self.wdt)
    end,
    set_def_mod=function(self,amt,turns)
      if not self.dead then
        self.def_mod,self.def_mod_turns=amt,turns
      end
    end,
    set_atk_mod=function(self,amt,turns)
      if not self.dead then
        self.atk_mod,self.atk_mod_turns=amt,turns
      end
    end,
    reset_mods=function(self)
      self.def_mod,self.atk_mod=0,0
    end,
    decrement_mods=function(self)
      self.def_mod_turns,self.atk_mod_turns=max(self.def_mod_turns-1,0),max(self.atk_mod_turns-1,0)
      self.def_mod,self.atk_mod=self.def_mod_turns>0 and self.def_mod or 0,self.atk_mod_turns>0 and self.atk_mod or 0
    end,
    draw_status_effects=function(self)
      for s in all({{self.def_mod,88,self:elv_y()+2},{self.atk_mod,92,self:elv_y(t,t)-5}}) do
        local status=s[1]>0 and split "88,1,13" or s[1]<0 and split "92,2,8" or nil
        if status then
          local x=self.pos.x-4
          pal(1,status[2])
          pal(13,status[3])
          sspr(s[2],0,4,4,x,s[3])
          sspr(status[1],4,4,4,x+5,s[3])
          pal()
        end
      end
    end,
    draw_dmg_lbl=function()
      if dmg_lbl then
        b_print(dmg_lbl_prefix..f_num(dmg_lbl),dmg_lbl_pos.x,dmg_lbl_pos.y,dmg_lbl_col,dmg_lbl_col_sdw)
      end
    end,
    shake=function()
      dmg_pos_mod_counter=4
    end,
    dmg_label=function(self,pwr,c1,c2,prefix)
      dmg_lbl_prefix,dmg_lbl_counter,dmg_lbl,dmg_y_speed=prefix,45,pwr,4.5
      dmg_lbl_col,dmg_lbl_col_sdw=c1,c2
      dmg_lbl_pos.x,dmg_lbl_pos.y=self.pos.x-6,self:elv_y(t,t)
    end,
    has_act_in_front=function(self)
      return act_in_front and not act_in_front.dead
    end,
    set_acn_acc=function(self,acc)
      self.selected_acn.accs={acc}
    end,
    add_acn_acc=function(self,acc)
      add(self.selected_acn.accs,acc)
    end,
    clear_acn_acc=function(self,acc)
      for a in all(self.selected_acn.accs) do
        if (a.hb) a.hb:delete()
      end
      self.selected_acn.accs={}
    end,
    play_anim=function(self,anim)
      self.anim_manager:play(anim)
    end,
    play_or_continue_anim=function(self,anim)
      self.anim_manager:play_or_continue(anim)
    end,
    set_acns=function(self,str)
      self.acns={}
      for a in all(split(str)) do
        add(self.acns,acns[a](self))
      end
    end,
    elevate_to=function(self,elv,spd)
      self.target_elv,self.elv_spd=elv,spd
    end,
    elv_y=function(self,minus_hgt,use_ui_hgt)
      return self.pos.y-self.elv-(minus_hgt and ((use_ui_hgt and self.ui_hgt) and self.ui_hgt or self.hgt) or 0)
    end
  }
  set_vals(a,"type,enm|def_mod,0|atk_mod,0|def_mod_turns,0|atk_mod_turns,0|y_vel,0|elv,0|target_elv,0|elv_spd,0|pwr_multi,1|hgt,8|wdt,8|wlk_spd,1|gold,0|invincible_t,0")
  a.body_hb,a.ptcm=new_hitbox(a,"enm"),new_ptc_manager(a)
  return a
end