sub Init()
  m.container = m.top.FindNode("container")
  m.menu = m.top.FindNode("menu")
  Setup()
end sub

sub Setup()
  m.container.width = 200
  m.container.height = m.global.display["h"]
  m.menu.translation = [0, m.global.display["h"] / 2.6]
end sub