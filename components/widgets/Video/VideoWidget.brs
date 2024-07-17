sub Init()
  m.top.ObserveField("position", "HandleChangePosition")
  m.top.ObserveField("state", "HandleChangeState")
  m.hasSetPosition = false
end sub

sub HandleChangePosition(event as object)
  position = event.GetData()

  if not m.hasSetPosition then 
    HandleSetPositionVideo()
    m.hasSetPosition = true
    return
  end if

  SetVideoPosition(m.top.contentId, position)
end sub

sub HandleChangeState(event as object)
  state = event.GetData()

  if state = "finished" and not m.top.hasError then 
    RemoveVideoPosition(m.top.contentId)
    m.top.isBack = true
  end if

  if state = "error" then
    m.top.isBack = true 
    m.top.hasError = true
  end if
end sub

sub HandleSetPositionVideo()
  position = GetVideoPosition(m.top.contentId)
  m.top.seek = position
end sub

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