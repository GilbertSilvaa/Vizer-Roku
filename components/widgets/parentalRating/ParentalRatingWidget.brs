sub Init()
  m.container = m.top.FindNode("container")
  m.label = m.top.FindNode("label")

  m.top.ObserveField("year", "SetRating")
  m.top.ObserveField("size", "SetContainerSize")

  m.containerColors = {
    "0": "0x138f57"
    "10": "0x19638f"
    "12": "0x917e1a"
    "14": "0xe97e2e"
    "16": "0xe92e2e"
    "18": "0x212121"
  }

  Setup()
end sub

sub SetRating(event as object)
  year = event.GetData().ToStr()
  m.container.color = m.containerColors[year]

  if year = "0" then year = "L"
  m.label.text = year
end sub

sub SetContainerSize(event as object)
  size = event.GetData()
  m.container.width = size
  m.container.height = size
  m.label.width = size
  m.label.height = size
end sub

sub Setup()
  m.container.width = 28
  m.container.height = 28
  m.label.width = 28
  m.label.height = 28

  m.container.color = m.containerColors["14"]
  m.label.text = "14"
  m.label.font.size = 18
end sub