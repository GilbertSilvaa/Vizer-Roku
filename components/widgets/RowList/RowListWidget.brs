sub Init()
  m.top.ObserveField("size", "ChangeWidth")
  m.top.ObserveField("content", "LoadContent")
  Setup()
end sub

sub LoadContent(event as object)
  data = event.GetData()

  listContent = CreateObject("RoSGNode", "ContentNode")
  content = CreateObject("RoSGNode", "ContentNode")
  content.title = "Episódios"

  for i=0 to data.GetChildCount() - 1
    episodeContent = CreateObject("RoSGNode", "ContentNode")
    episodeContent.HDPosterUrl = data.GetChild(i).poster
    episodeContent.title = "episódio " + data.GetChild(i).number.ToStr()
    content.AppendChild(episodeContent)
  end for

  listContent.AppendChild(content)
  m.top.content = listContent
end sub

sub ChangeWidth(event as object)
  width = event.GetData()
  m.top.itemSize = [width,160]
end sub

sub Setup()
  m.top.itemComponentName = "RowListItemWidget"
  m.top.itemSize = [800,160]
  m.top.rowItemSize = [[250,160]]
  m.top.rowItemSpacing = [[16,0]]
  m.top.rowFocusAnimationStyle = "floatingFocus"
  m.top.focusBitmapBlendColor = "0xff7a09"
end sub
