function center_print(t,y,c,symbol_count)
  sc=symbol_count or 0
  ? t,64-sc*2-#t*4/2,y,c
end

function t_split(s)
  local result={}
  for t in all(split(s,"|")) do
    st=split(t)
    result[st[1]]=st[2]
  end
  return result
end