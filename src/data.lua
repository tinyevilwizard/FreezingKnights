cartdata("tinyevilwizard_freezing_knights_v0_2_0")

function dget_or_default(mem_id,default)
  return dget(mem_id) != 0 and dget(mem_id) or default
end

function dget_to_table(str)
  vals,res=s_split(str),{}
  for v in all(vals) do
    res[v[1]]=dget(v[2])
  end
  return res
end

-- setup saved settings
player1_controller,player2_controller=0,dget"17"
btns_lbls={[4]="🅾️",[5]="❎"}
confirm_btn,cancel_btn=dget_or_default(14,4),dget_or_default(15,5)
confirm_btn_lbl,cancel_btn_lbl=btns_lbls[confirm_btn],btns_lbls[cancel_btn]