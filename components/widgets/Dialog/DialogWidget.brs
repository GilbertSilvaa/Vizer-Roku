sub Init()
  m.top.backgroundUri = "pkg:/images/colors/secundary-color.png"

  closeBtn = CreateObject("RoSGNode", "Button")
  closeBtn.text = "Fechar"
  closeBtn.iconUri = ""
  closeBtn.focusedIconUri = ""
  closeBtn.ObserveField("buttonSelected", "CloseDialog")

  m.top.buttonGroup.AppendChild(closeBtn)
end sub

sub CloseDialog()
  m.top.close = true
end sub