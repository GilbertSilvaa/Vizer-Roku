function OnKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  if key = "back" and m.top.IsInFocusChain() then
    m.top.control = "pause"
    m.top.visible = false
    m.top.isBack = true
    
    return true
  end if

  return false
end function