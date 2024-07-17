sub Init()
  m.top.ObserveField("icon", "ChangeIcon")
  Setup()
end sub

sub ChangeIcon(event as object)
  icon = event.GetData()
  m.top.iconUri = icon
  m.top.focusedIconUri = icon
end sub

sub Setup()
  m.top.showFocusFootprint = true
  m.top.focusBitmapUri = "pkg:/images/colors/primary-color.png"
  m.top.focusFootprintBitmapUri = "pkg:/images/colors/default-color.png"

  m.top.height = 50
  m.top.minWidth = 200
end sub