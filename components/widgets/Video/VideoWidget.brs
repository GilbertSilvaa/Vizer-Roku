sub Init()
  m.top.ObserveField("position", "HandleChangePosition")
  m.top.ObserveField("state", "HandleChangeState")
  m.hasSetPosition = false

  Setup()
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

sub Setup()
  m.top.trickPlayBar.filledBarBlendColor = "0xff7a09"
  m.top.trickPlayBar.liveFilledBarBlendColor = "0xe72424"
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  if key = "back" and m.top.IsInFocusChain() then
    m.top.control = "stop"
    m.top.visible = false
    m.top.isBack = true
    
    return true
  end if

  return false
end function