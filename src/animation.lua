-- frame[1]=sprite, frame[2]=duration, frame[3]=event
function new_anim_manager(anims,act,default)
  local active_anim,active_name,frames_until_next,frame_index,active,loop,on_showed_triggered=nil,"",0,1,f,f,f
  local am={
    play=function(self,name)
      local anim=anims[name]
      if anim then
        active_anim,active_name,frame_index,active,on_showed_triggered,loop=anim,name,anim.rdm_start and 1+flr(rnd(#(anim.frames))) or 1,t,f,anim.loop
        frames_until_next=anim.frames[frame_index][2] or 100
      end
    end,
    play_or_continue=function(self,name)
      if (not active or active_name!=name) self:play(name)
    end,

    -- for actor update
    load_next_frame=function(self)
      if active then
        if frames_until_next<=0 then
         -- setup next anim
         frame_index+=1
         on_showed_triggered=f
         if frame_index>#active_anim.frames then
           if active_anim.next then
             self:play(active_anim.next)
           else
             if loop then
               frame_index=1
             else
               active=f
               frame_index=#(active_anim.frames)
             end
           end
         end
         frames_until_next=self:current_frame()[2] or 100
        end
        frames_until_next-=1
        if self:current_event() and not on_showed_triggered then
          self:current_event()(act)
          on_showed_triggered=t
        end
      end
      return self:current_frame()
    end,

    -- for actor draw
    current_frame=function()
      return active_anim.frames[frame_index]
    end,
    current_event=function(self)
      return act.selected_acn and act.selected_acn[self:current_frame()[3]] or act[self:current_frame()[3]]
    end,
    current_spr=function(self)
      return self:current_frame()[1]
    end
  }
  am:play(default or "idle")
  return am
end

function new_anims(strs)
  local result={}
  for str in all(split(strs,"&")) do
    local t=split(str,"$")
    --t[1]=anim name | t[2]=frames | t[3]=loop? (leave empty if not) | t[4]=next anim | t[5]=random frame on start?
    result[t[1]]={
      frames=s_split(t[2]),
      loop=is_present(t[3]),
      next=is_present(t[4]) and t[4] or nil,
      rdm_start=is_present(t[5])
    }
  end
  return result
end