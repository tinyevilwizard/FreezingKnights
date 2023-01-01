function new_bgr(gradient_y,col1,col2)
  local cols,data={col1,col2},s_split"1,0b0000010000000000|1,0b1000000101000000|1,0b0100101001000000|1,0b0010011100100000|2,0b0101111001011011|1,0b1011010111100101|2,0b0000001001110010|2,0b0000010010100100|2,0b0000100000010100|2,0b0000000001000000"
  return {
    draw=function(self)
      local y=gradient_y
      rectfill(0,0,128,y,cols[1])
      for l in all(data) do
        fillp(l[2])
        rectfill(0,y,128,y+3,cols[l[1]])
        y+=4
      end
      fillp()
      rectfill(0,y,128,128,cols[2])
      pal(6,0)
      for coo in all(s_split "-23,22|0,20|30,18|50,22|56,24|73,26|104,24") do
        local mx,my=coo[1],coo[2]
        spr(96,mx,my,4,4)
        rectfill(mx,my+16,mx+32,my+32,0)
      end
      spr(116,112,6)
      pal()
      rectfill(0,50,128,80,0)
    end
  }
end