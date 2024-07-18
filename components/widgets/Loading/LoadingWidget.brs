sub Init()
  m.container = m.top.FindNode("container")
  m.spinner = m.top.FindNode("spinner")
  m.spinner.poster.ObserveField("loadStatus", "ShowSpinner")
  Setup()
end sub

sub ShowSpinner()
  if m.spinner.poster.loadStatus = "ready" then
    centerX = (m.global.display["w"] - m.spinner.poster.bitmapWidth) / 2
    centerY = (m.global.display["h"] - m.spinner.poster.bitmapWidth) / 2
    m.spinner.translation = [centerX, centerY]

    m.spinner.visible = true
  end if
end sub

sub Setup()
  m.container.width = m.global.display["w"]
  m.container.height = m.global.display["h"]

  m.spinner.poster.uri = "pkg:/images/icons/loading.png"
  m.spinner.poster.width = 100
  m.spinner.poster.height = 100
  m.spinner.spinInterval = 1.6
end sub