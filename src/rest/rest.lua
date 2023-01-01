rst={
  turn=0,
  potions=dget"60",
  max_potions=dget"60",
  gold=dget"58",
  ply1=new_rest_player(
    "knight a",
    player1_controller,
    {armor=dget"0", armor_dark=dget"1", details=dget"6", skin=dget"2", skin_sdw=dget"3", eyes=dget"4", mouth=dget"5"},
    dget"56",
    {
      swd1=dget"28",
      swd2=dget"29",
      shd1=dget"30",
      shd2=dget"31",
      bow1=dget"32",
      bow2=dget"33",
      stf1=dget"34",
      stf2=dget"35",
      g_swd1=dget"36",
      g_swd2=dget"37",
      bag1=dget"38",
      bag2=dget"39",
      ptn1=dget"40",
      ptn2=dget"41"
    },
    {pos=new_pos(49,83)}
  ),
  ply2=new_rest_player(
    "knight b",
    player2_controller,
    {armor=dget"7",armor_dark=dget"8",details=dget"13",skin=dget"9",skin_sdw=dget"10",eyes=dget"11",mouth=dget"12"},
    dget"57",
    {
      swd1=dget"42",
      swd2=dget"43",
      shd1=dget"44",
      shd2=dget"45",
      bow1=dget"46",
      bow2=dget"47",
      stf1=dget"48",
      stf2=dget"49",
      g_swd1=dget"50",
      g_swd2=dget"51",
      bag1=dget"52",
      bag2=dget"53",
      ptn1=dget"54",
      ptn2=dget"55"
    },
    {pos=new_pos(81,83),flip_x=t},
    t
  ),

  init=function(self)
    dset(61,dget"58")
    dset(62,dget"60")
    self.acts={}
    add(self.acts,self.ply1)
    add(self.acts,self.ply2)
    self.merchant=new_merchant({pos=new_pos(96,40)})
    fade_in(20,function()
      fade_out(60,function()
        self.hide_save_notice=t
        fade_in(20,function()
          new_delayed_event(60, function()
            self:start()
          end)
        end)
      end)
    end)

  end,
  start=function(self)
    self:process_next_turn()
  end,
  process_next_turn=function(self)
    if self.turn==0 then
      self.ply1:start_turn()
    elseif self.turn==1 then
      self.ply2:start_turn()
    else
      music(-1,1000)
      fade_out(20,function()
        self:save()
        load_cart("map")
      end)
    end
  end,
  update=function(self)
    bonfire:update()
    for a in all(self.acts) do
      a:update()
    end

    self.merchant:update()
  end,
  draw=function(self)
    if not self.hide_save_notice then
      cls(0)
      center_print("progress saved",120,7)
      return
    end
    map:draw()
    for a in all(map_accs) do
      a:draw_sdw()
      a:draw()
    end
    snow_con:draw()
    bonfire:draw()
--    spr(57,35,85)
--    spr(57,86,72,1,1,t)
    self.merchant:draw()
    for a in all(self.acts) do
      a:draw()
    end

    if (self.ply1.menu) self.ply1.menu:draw()
    if (self.ply2.menu) self.ply2.menu:draw()

    --ply stats
    draw_ply_sts(3, self.ply1)
    draw_ply_sts(27, self.ply2)

    --money stats
    sm_tb(99,117,124,1)
    ? money_char,101,118,9
    ? f_num(self.gold,t),110,118,7

    --potion stats
    sm_tb(75,117,96,1)
    ? potion_char,77,118,14
    ? f_num(self.potions),86,118,self.potions >= self.max_potions and 15 or 7
  end,
  save=function(self)
    p1d=self.ply1.acns_data
    p2d=self.ply2.acns_data

    dset(28,p1d.swd1)
    dset(29,p1d.swd2)
    dset(30,p1d.shd1)
    dset(31,p1d.shd2)
    dset(32,p1d.bow1)
    dset(33,p1d.bow2)
    dset(34,p1d.stf1)
    dset(35,p1d.stf2)
    dset(36,p1d.g_swd1)
    dset(37,p1d.g_swd2)
    dset(38,p1d.bag1)
    dset(39,p1d.bag2)
    dset(40,p1d.ptn1)
    dset(41,p1d.ptn2)

    dset(42,p2d.swd1)
    dset(43,p2d.swd2)
    dset(44,p2d.shd1)
    dset(45,p2d.shd2)
    dset(46,p2d.bow1)
    dset(47,p2d.bow2)
    dset(48,p2d.stf1)
    dset(49,p2d.stf2)
    dset(50,p2d.g_swd1)
    dset(51,p2d.g_swd2)
    dset(52,p2d.bag1)
    dset(53,p2d.bag2)
    dset(54,p2d.ptn1)
    dset(55,p2d.ptn2)

    dset(56,self.ply1.max_hp)
    dset(57,self.ply2.max_hp)

    dset(58,self.gold)
    dset(59,self.max_potions)
    dset(60,self.max_potions)
    dset(61,self.gold)
    dset(62,self.max_potions)
  end,
}
function rest_turn_done()
  rst.turn+=1
  new_delayed_event(40,function()
      rst:process_next_turn()
    end)
end
function previous_rest_turn()
  rst.turn=max(0,rst.turn-1)
  new_delayed_event(40,function()
    rst:process_next_turn()
  end)
end
function draw_ply_sts(x,ply)
  sm_tb(x,117,x+21,ply.pal.armor_dark)
  ? "♥",x+2,118,ply.pal.armor
  ? f_num(ply.max_hp),x+11,118,15
end
function pay_cost(cost)
  rst.gold=max(0,rst.gold-cost)
  sfx"60"
end
function increase_max_potions()
  rst.max_potions+=1
  rst.potions=rst.max_potions
end