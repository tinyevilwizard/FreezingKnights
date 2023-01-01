mode_lbl="1 player"
start_menu_active=t
start_menu_input_enabled=t
title_screen_done=f
potions_count=10
difficulty_mode=0

function set_mode()
  mode_lbl=player2_controller==1 and "2 players" or "1 player"
end

function swap_p2_controller()
  player2_controller=(player2_controller+1)%2
  save_settings()
end

function swap_confirm_btn()
  local tmp_btn,tmp_btn_lbl=confirm_btn,confirm_btn_lbl
  confirm_btn,confirm_btn_lbl=cancel_btn,cancel_btn_lbl
  cancel_btn,cancel_btn_lbl=tmp_btn,tmp_btn_lbl
  save_settings()
end

function save_settings()
  dset(17,player2_controller)
  dset(14,confirm_btn)
  dset(15,cancel_btn)
end

start_menu_items={
  {
    on_left=function()
      swap_p2_controller()
      set_mode()
    end,
    on_right=function()
      swap_p2_controller()
      set_mode()
    end,
     --on_confirm=function(self)
     --  self:select_last()
     --end,
    draw=function(self,active)
      if active then
        center_print("⬅️ mode: "..mode_lbl.." ➡️",81,7,2)
      else
        center_print("mode: "..mode_lbl,81,13)
      end
    end
  },
  {
    on_left=function()
      swap_confirm_btn()
    end,
    on_right=function()
      swap_confirm_btn()
    end,
     --on_confirm=function(self)
     --  self:select_last()
     --end,
    draw=function(self,active)
      if active then
        center_print("⬅️ confirm/cancel: "..confirm_btn_lbl.."/"..cancel_btn_lbl.." ➡️",93,7,2)
      else
        center_print("confirm/cancel: "..confirm_btn_lbl.."/"..cancel_btn_lbl,93,13)
      end
    end
  }
}

if dget"19"!=0 then
  add(start_menu_items,
    {
      on_left=function() end,
      on_right=function() end,
      on_confirm=function(self)
        continue_game()
      end,
      draw=function(self,active)
        if active then
          center_print("○ continue game ○",105,7)
        else
          center_print("continue game",105,12)
        end
      end
    }
  )
end

add(start_menu_items,
  {
    on_left=function() end,
    on_right=function() end,
    on_confirm=function(self)
      new_new_game_menu()
    end,
    draw=function(self,active)
      if active then
        center_print("○ new game ○",117,7)
      else
        center_print("new game",117,12)
      end
    end
  }
)

function new_start_menu()
  start_menu_menu=new_menu(
    start_menu_items,
    player1_controller,
    function()
      title_screen_done=f
    end,
    3
  )
end

new_start_menu()

new_game_menu_items={
  {
    on_left=function() end,
    on_right=function() end,
    on_confirm=function(self)
      potions_count=10
      difficulty_mode=0
      fade_out(10,function()
        new_pal_active=t
        start_menu_input_enabled=f
        start_menu_active=f
        fade_in(10)
      end)
    end,
    draw=function(self,active)
      if active then
        center_print("○ new game - normal ○",85,7)
      else
        center_print("new game - normal",85,12)
      end
      center_print("rECOMMENDED FOR NEW PLAYERS",95,6)
    end
  },
  {
    on_left=function() end,
    on_right=function() end,
    on_confirm=function(self)
      potions_count=5
      difficulty_mode=1
      fade_out(10,function()
        new_pal_active=t
        start_menu_input_enabled=f
        start_menu_active=f
        fade_in(10)
      end)
    end,
    draw=function(self,active)
      if active then
        center_print("○ new game - hard ○",107,7)
      else
        center_print("new game - hard",107,12)
      end
      center_print("lESS hp, POTIONS AND MONEY",117,6)
    end
  }
}

function new_new_game_menu()
  start_menu_menu=new_menu(
    new_game_menu_items,
    player1_controller,
    function()
      new_start_menu()
    end
  )
end

update_start_menu=function()
  if (not start_menu_input_enabled) return
  if title_screen_done then
    start_menu_menu:update()
  else
    if btnp(4) or btnp(5) then
      sfx"56"
      title_screen_done=t
    end
  end
end

draw_start_menu=function()
  if (not start_menu_active) return
  rectfill(0,50,128,128,0)
  snow_con:draw()
  spr(68,17,35,12,2)
  line(17,53,110,53,7)
  spr(101,23,56,11,2)
--  spr(4,36,51)
--  pal({[12]=8,[15]=4,[14]=2,[8]=12,[3]=9})
--  spr(4,81,51,1,1,t)
--  pal()
  if title_screen_done then
    start_menu_menu:draw()
  else
    center_print("🅾️/❎",83,6,2)
    center_print("press any to continue",93,6)
    center_print("TINYEVILWIZARD",112,13)
    center_print("mUSIC BY oHcURTAINS",119,13)
    ? version,2,2,1
  end
end

function new_save_file()
  dset(16,difficulty_mode)

  dset(18,0)
  dset(19,0)

  dset(56,10)
  dset(57,10)

  dset(58,0)
  dset(59,potions_count)
  dset(60,potions_count)

  dset(28,1)
  dset(29,0)
  dset(30,0)
  dset(31,0)
  dset(32,0)
  dset(33,0)
  dset(34,0)
  dset(35,0)
  dset(36,0)
  dset(37,0)
  dset(38,1)
  dset(39,0)
  dset(40,1)
  dset(41,0)

  dset(42,0)
  dset(43,0)
  dset(44,0)
  dset(45,0)
  dset(46,1)
  dset(47,0)
  dset(48,0)
  dset(49,0)
  dset(50,0)
  dset(51,0)
  dset(52,1)
  dset(53,0)
  dset(54,1)
  dset(55,0)
end

function start_new_game()
  music(-1,1000)
  fade_out(10,function()
    new_save_file()
    save_palettes()
    load_cart"map"
  end)
end

function continue_game()
  music(-1,1000)
  fade_out(10,function()
    dset(58,dget"61")
    dset(59,dget"62")
    load_level(levels[dget"19"])
  end)
end