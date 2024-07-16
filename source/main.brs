sub Main()
  ShowChannelSGScreen()
end sub

sub ShowChannelSGScreen()
  screen = CreateObject("RoSGScreen")
  device = CreateObject("RoDeviceInfo")

  m.global = screen.GetGlobalNode()
  m.global.AddField("display", "RoAssociativeArray", false)
  m.global.display = device.GetDisplaySize()

  m.port = CreateObject("RoMessagePort")

  screen.SetMessagePort(m.port)
  scene = screen.CreateScene("MainScene")
  screen.Show()

  While(true)
    msg = Wait(0, m.port)
    msgType = Type(msg)

    if msgType = "RoSGScreenEvent" then
      if msg.IsScreenClosed() then return
    end if
  end while

end sub
