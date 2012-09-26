;-------------------------------------------------------
; Xie Xin's NCL Utility
;-------------------------------------------------------

;-------------------------------------------------------
; Function to calculate the smoothing average
;-------------------------------------------------------
; Input Arguments:
; input: 1D numeric arrary
; start: the starting position, count from 1!!!
; finish: the end position
; length: smoothing run length
;-------------------------------------------------------

undef("smoothavg")
function smoothavg(input:numeric, start:numeric, finish:numeric, length:numeric)

local output, i, size

begin
  outputsize = finish - start + 1
  output = new((/outputsize/), typeof(input)) ; allocate for the output
  do i = start, finish
    output(i-start) = avg(input(i-length:i-1))
  end do
  return output
end


;-------------------------------------------------------
; Function to set view resource given x/y ratio.
;-------------------------------------------------------
; Input Arguments:
; input: resource needed to be modified.
; ratio; X/Y ratio.
;-------------------------------------------------------
undef("setviewratio")
procedure setviewratio(res:logical, ratio:numeric, ifmap:logical)
begin
if(ifmap .eq. True) then
  res@mpShapeMode = "FreeAspect"
end if
longsize = 0.7
if(ratio .gt. 1) then
  res@vpWidthF = longsize
  res@vpHeightF = longsize/ratio
  res@vpXF = 0.5 - longsize/2.0
  res@vpYF = 0.5 - res@vpHeightF/2.0
else
  res@vpHeightF = longsize
  res@vpWidthF = longsize*ratio
  res@vpXF = 0.5 - res@vpWidthF/2.0
  res@vpYF = 0.5 - longsize/2.0
end if
;  res@mpLimitMode = "NDC"
;  res@mpLeftNDCF = res@vpXF
;  res@mpRighetNDCF = res@vpXF+res@vpWidthF
;  res@mpTopNDCF = res@vpYF
;  res@mpBottomNDCF = res@vpYF+res@vpHeightF
end


;-------------------------------------------------------
; Function to change the units for human reading.
;-------------------------------------------------------
; Input Arguments:
; input: resource needed to be modified.
; ratio; X/Y ratio.
;-------------------------------------------------------
undef("easyunits")
procedure easyunits(x:numeric)
begin

if (x@units .eq. "kg/kg") then
  x = (/x*1000/)
  x@units = "g/kg"
end if
if (x@units .eq. "K/s") then
  x = (/x*3600/)
  x@units = "K/hour"
end if
if (x@units .eq. "m/s") then
  x = (/x*86400000/)
  x@units = "mm/day"
end if

end


undef("easyfonts")
procedure easyfonts(res:logical, stdfont:numeric)
begin

res@tiMainFontHeightF    = stdfont*0.8

res@tiXAxisFontHeightF   = stdfont*0.5
res@tiYAxisFontHeightF   = stdfont*0.5

res@tmXBLabelFontHeightF = stdfont*0.5
res@tmXTLabelFontHeightF = stdfont*0.5
res@tmYLLabelFontHeightF = stdfont*0.5
res@tmYRLabelFontHeightF = stdfont*0.5

;res@lbTitleFontHeightF   = stdfont*0.5

end


