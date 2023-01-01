levels={}
unordered_levels={}
function add_level(id,next_ids,type,x,y,enm_ids,cart,map_x,map_y,chars_reversed,corruption_y_base,cleared_exceptions_ids)
  levels[id]={
    id=id,
    next_ids=next_ids,
    type=type,
    x=x,
    y=y,
    enm_ids=enm_ids,
    cart=cart,
    map_x=map_x,
    map_y=map_y,
    chars_reversed=chars_reversed,
    corruption_y_base=corruption_y_base,
    cleared_exceptions_ids=cleared_exceptions_ids
  }
  add(unordered_levels,levels[id])
end

local type_rest=0
local type_battle=1
local type_boss=2
local type_final_boss=3

function load_level(l)
  dset(26,l.map_x)
  dset(27,l.map_y)
  if (l.enm_ids) then
    dset(20,l.enm_ids[1])
    dset(21,l.enm_ids[2])
    dset(22,l.enm_ids[3])
    dset(23,l.enm_ids[4])
    dset(24,l.enm_ids[5])
    dset(25,l.enm_ids[6])
  end
  if (l.type==type_rest) dset(19,l.id)
  dset(18,l.id)
  load_cart(l.cart)
end

local road1_1=10
local road1_2=20
local road1_3=30

local road2a_1=40
local road2a_2=50
local road2b_1=60
local road2b_2=70
local road2_3=80
local road2_4=90

local road3_1=100
local road3_2=110
local road3_3=120
local road3_4=130

local road4_1=140
local road4_2=150

local road5_1=160
local road5_2=170
local road5_3=180
local road5_4=190
local road5_5=200
local road5_6=210
local road5_7=220
local road5_8=230

local road6a_1=240
local road6a_2=250
local road6a_3=260
local road6a_4=270
local road6b_1=280
local road6b_2=290
local road6b_3=300
local road6b_4=310
local road6b_5=320
local road6b_6=330

local road7_1=340
local road7_2=350
local road7_3=360
local road7_4=370

local cart_rest="rest"
local cart_battle_main1="battle1"
local cart_battle_main2="battle2"
local cart_battle_special="battle3"
local cart_battle_boss1="boss1"
local cart_battle_boss2="boss2"
local cart_battle_boss3="boss3"
local cart_battle_boss4="boss4"
local cart_battle_boss5="boss5"
local cart_battle_boss6="boss6"
local cart_battle_boss7="boss7"

add_level(0,{road1_1},type_rest,-20,14,nil,nil,0,0) -- Out of bound fake level, not selectable

add_level(road1_1,{road1_2},type_battle,1,14,{50,52},cart_battle_special,0,0,f,nil)
add_level(road1_2,{road1_3},type_battle,3,14,{51,51,51},cart_battle_special,1,0,f,nil)
add_level(road1_3,{road2a_1,road2b_1},type_rest,5,14,nil,cart_rest,0,0,f,nil)

add_level(road2a_1,{road2a_2},type_battle,8,12,{10,30,30},cart_battle_main1,2,0,f)
add_level(road2a_2,{road2_3},type_battle,10,12,{10,30,30,11},cart_battle_main1,3,0,f)
add_level(road2b_1,{road2b_2},type_battle,8,14,{30,10,10},cart_battle_main1,2,0,f,nil,{road2a_1,road2a_2})
add_level(road2b_2,{road2_3},type_battle,10,14,{30,10,10,11},cart_battle_main1,3,0,f,nil,{road2a_1,road2a_2})
add_level(road2_3,{road2_4},type_boss,12,13,{10,11,11,100},cart_battle_boss1,0,0,f)
add_level(road2_4,{road3_1},type_rest,14,13,nil,cart_rest,1,0,f)

add_level(road3_1,{road3_2},type_battle,14,10,{10,30,30,20},cart_battle_main1,4,0,f)
add_level(road3_2,{road3_3},type_battle,12,10,{30,10,10,30,20,20},cart_battle_main1,5,0,f)
add_level(road3_3,{road3_4},type_battle,10,10,{20,20,20,10,11,11},cart_battle_main1,6,0,f)
add_level(road3_4,{road4_1,road5_1},type_boss,8,10,{20,20,20,200},cart_battle_boss2,0,0,f)

add_level(road4_1,{road4_2,road5_5},type_battle,3,9,{60,40,40},cart_battle_main2,7,0,t,116)
add_level(road4_2,{road6b_1},type_battle,5,7,{70},cart_battle_special,9,0,t,112)

add_level(road5_1,{road5_2},type_rest,5,11,nil,cart_rest,2,0,t,nil,{road4_1,road4_2})
add_level(road5_2,{road5_3},type_battle,3,11,{20,40,40},cart_battle_main2,7,0,t,nil,{road4_1,road4_2})
add_level(road5_3,{road5_4},type_battle,1,11,{60,40,40},cart_battle_main2,9,0,t,124,{road4_1,road4_2})
add_level(road5_4,{road5_5},type_battle,1,9,{40,60,60},cart_battle_main2,8,0,t,120,{road4_1,road4_2})
add_level(road5_5,{road5_6},type_battle,1,7,{60,40,40,21},cart_battle_main2,10,0,t,116,{road4_2})
add_level(road5_6,{road5_7},type_boss,1,5,{300},cart_battle_boss3,0,0,f,112,{road4_2})
add_level(road5_7,{road5_8},type_rest,3,5,nil,cart_rest,3,0,t,108,{road4_1,road4_2})
add_level(road5_8,{road6a_1,road6b_1},type_battle,5,4,{12,31,31,21},cart_battle_main1,11,0,f,104,{road4_1,road4_2})

add_level(road6a_1,{road6a_2},type_battle,7,2,{12,12,12,13,13,13},cart_battle_main1,0,1,f,96,{})
add_level(road6a_2,{road6a_3},type_battle,9,2,{41,41,41,61},cart_battle_main2,1,1,f,88,{})
add_level(road6a_3,{road6a_4},type_battle,9,4,{41,21,21,21},cart_battle_main2,2,1,f,80,{})
add_level(road6a_4,{road7_1},type_battle,9,6,{41,61,61,41,21,21},cart_battle_main2,3,1,f,72,{})

add_level(road6b_1,{road6b_2},type_battle,7,6,{31,12,12,13},cart_battle_main1,0,1,f,100,{road6a_1,road6a_2,road6a_3,road6a_4})
add_level(road6b_2,{road6b_3},type_battle,8,8,{41,61,61},cart_battle_main2,1,1,t,96,{road6a_1,road6a_2,road6a_3,road6a_4})
add_level(road6b_3,{road6b_4},type_battle,10,8,{12,31,31,21,13,13},cart_battle_main1,2,1,t,88,{road6a_1,road6a_2,road6a_3,road6a_4})
add_level(road6b_4,{road6b_5},type_battle,12,8,{61,61,61,41},cart_battle_main2,3,1,t,80,{road6a_1,road6a_2,road6a_3,road6a_4})
add_level(road6b_5,{road6b_6},type_battle,14,8,{31,12,12,13,21,21},cart_battle_main1,4,1,t,72,{road6a_1,road6a_2,road6a_3,road6a_4})
add_level(road6b_6,{road7_1},type_boss,13,6,{21,21,21,201},cart_battle_boss4,0,0,f,64,{road6a_1,road6a_2,road6a_3,road6a_4})

add_level(road7_1,{road7_2},type_rest,11,6,nil,cart_rest,4,0,t,60,{})
add_level(road7_2,{road7_3},type_boss,11,4,{12,12,12,101,13,13},cart_battle_boss5,0,0,t,52,{})
add_level(road7_3,{road7_4},type_boss,11,2,{301},cart_battle_boss6,0,0,t,30,{})
add_level(road7_4,{road1_1},type_final_boss,13,2,{400},cart_battle_boss7,0,0,f,nil,{})