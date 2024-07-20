sub Init()
  m.top.SetFocus(true)
  
  m.scene = m.top.FindNode("content")
  m.scene.width = m.global.display["w"]
  m.scene.height = m.global.display["h"]

  m.global.ObserveField("screen", "HandleChangeScreen")

  screen = CreateObject("RoSGNode", m.global.screen)
  m.scene.AppendChild(screen)
end sub

sub HandleChangeScreen(event as object)
  while m.scene.GetChildCount() > 0
    m.scene.RemoveChild(m.scene.GetChild(0))
  end while

  screenName = event.GetData()
  screen = CreateObject("RoSGNode", screenName)
  m.scene.AppendChild(screen)
end sub