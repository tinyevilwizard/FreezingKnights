load_mode,version=1,"V1.2.0"  --1 for .p8 files, 2 for BBS cart ID
f,t,potion_char,money_char=false,true,"\^:3e1c3a3e3e000000","\^:1c323a3e1c000000"

menuitem(1,"main menu",function() load_cart"start" end)

function load_cart(cart_name)
  load((load_mode==2 and "#freezing_knights_" or "")..cart_name)
end

function is_present(s)
  return (s and #s>0)
end

function set_ply_colors(ply_pal)
  pal{1,ply_pal.mouth,ply_pal.eyes,4,5,6,7,ply_pal.details,9,10,2,ply_pal.armor,13,ply_pal.skin_sdw,ply_pal.skin}
end

function sort(tb,fn)
  for i=2,#tb do
    local j=i
    while j>=2 and fn(tb[j],tb[j-1]) do
      local k=tb[j]
      tb[j]=tb[j-1]
      tb[j-1]=k
      j-=1
    end
  end
end

function clone(tb)
  local t2={}
  for k,v in next,tb do t2[k]=v end
  return t2
end

function merge(t1,t2,t3)
  local result=clone(t1)
  for i in all(t2) do
    add(result,i)
  end
  for i in all(t3) do
    add(result,i)
  end
  return result
end

function set_vals(tb,str)
  for tt in all(s_split(str)) do
    tb[tt[1]]=tt[2]
  end
end

function multi_add(tb,vals)
  for v in all(vals) do
    add(tb,v)
  end
end

function new_pos(x,y)
  return {x=x,y=y}
end

function pos_clone(pos,x_offset,y_offset)
  return new_pos(pos.x+(x_offset or 0),pos.y+(y_offset or 0))
end

function parse_pos(s)
  local tb=split(s)
  return new_pos(tb[1],tb[2])
end

function is_same_pos(pos1,pos2)
  return (pos1.x==pos2.x and pos1.y==pos2.y)
end

function mv(obj,coo,spd)
  local obj_pos=obj.pos
  local x1,x2,y1,y2=obj_pos.x,coo.x,obj_pos.y,coo.y
  local dx,dy=x2-x1,y2-y1
  local ang,spd_val=atan2(dx,dy),type(spd)=="function" and spd() or spd
  local vx,vy=spd_val*cos(ang),spd_val*sin(ang)
  obj_pos.x=abs(dx)<=abs(vx) and x2 or obj_pos.x+vx
  obj_pos.y=abs(dy)<=abs(vy) and y2 or obj_pos.y+vy
  return is_same_pos(obj_pos,coo)
end

function mv_ang(obj,ang,spd)
  local spd_val=type(spd)=="function" and spd() or spd
  obj.pos.x+=spd_val*cos(ang)
  obj.pos.y+=spd_val*sin(ang)
end

function ang_to(obj,coo)
  return atan2(coo.x-obj.pos.x,coo.y-obj.pos.y)
end

--"[1]=max_spd,[2]=start_spd,[3]=acl"
function new_spd(str)
  local data=s_split(str)
  local max_spd,spd,acl=rnd(data[1]),rnd(data[2]),rnd(data[3])
  return function()
    spd=min(spd+acl,max_spd)
    return spd
  end
end

function sdw(x,y,w)
  w=w or 8
  x_mod=w/2
  ovalfill(x-x_mod+1,y-2,x-x_mod+w-1,y,6)
end

function f_num(n,hundreds)
  local prefix=""
  if (hundreds) return n<10 and "00"..n or n<100 and "0"..n or n
  return n<10 and "0"..n or n
end

function sm_tb(x,y,x2,c,tx,txc)
  pal(1,c)
  pal(5,0)
  sspr(88,24,3,8,x,y)
  sspr(90,24,1,8,x+3,y,x2-x-6,8)
  sspr(88,24,3,8,x2-3,y,3,8,t)
  pal()
  if (tx) ? tx,x+3,y+1,txc and txc or 7
end

function b_print(text,x,y,c,c_b)
  for i=-1,1 do
    for j=-1,1 do
      ? text,x+i,y+j,c_b
    end
  end
  ? text,x,y,c
end

function s_split(s)
  local st={}
  for tb in all(split(s,"|")) do
    add(st,split(tb))
  end
  return st
end

delayed_events={}
function new_delayed_event(time,event)
  add(delayed_events,{t=time,event=event})
end
function update_delayed_events()
  for e in all(delayed_events) do
    e.t-=1
    if e.t<=0 then
      e.event()
      del(delayed_events,e)
    end
  end
end

shake_dur=0
function shake(dur)
  shake_dur=dur or 2
end
function update_shake()
  camera()
  if shake_dur>0 then
    camera(rnd(split"-1,0,1"),rnd(split"-1,0,1"))
  end
  shake_dur=max(0,shake_dur-1)
end

-- fade_step,fading_dir,fading_wait=0,0,0
function fade_in(wait,ended_event)
  fading_dir,fade_step,fading_wait,on_fading_out_ended,on_fading_in_ended=-1,3,wait or 40,nil,ended_event
end
function fade_out(wait,ended_event)
  fading_dir,fade_step,fading_wait,on_fading_out_ended,on_fading_in_ended=1,0,wait or 120,ended_event,nil
end
function process_fade()
  if fade_step==0 then
    pal()
    if on_fading_in_ended then
      on_fading_in_ended()
      on_fading_in_ended=nil
    end
  elseif fade_step==1 then
    pal(split"1,2,3,4,5,6,7,13,8,9,3,13,13,13,13",1)
  elseif fade_step==2 then
    pal(split"0,0,0,2,0,5,5,1,2,2,1,1,1,2,1",1)
  elseif fade_step>=3 then
    pal(split"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",1)
    if fade_step>3 and on_fading_out_ended then
      on_fading_out_ended()
      on_fading_out_ended=nil
    end
  else
    return
  end
  if fading_wait<=0 then
    fading_wait=10
    fade_step+=fading_dir
  else
    fading_wait-=1
  end
end