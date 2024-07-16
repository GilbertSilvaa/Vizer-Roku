sub Init()
  m.top.SetFocus(true)
  
  scene = m.top.FindNode("content")
  scene.width = m.global.display["w"]
  scene.height = m.global.display["h"]

  screen = CreateObject("RoSGNode", "HomeScreen")
  scene.AppendChild(screen)
end sub