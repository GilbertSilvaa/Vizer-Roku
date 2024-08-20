sub Init()
  m.noItemsText = m.top.FindNode("noItemsText")

  m.top.ObserveField("size", "ChangeWidth")
  m.top.ObserveField("content", "LoadContent")
  Setup()
end sub

sub LoadContent(event as object)
  m.noItemsText.visible = false
  data = event.GetData()

  listContent = CreateObject("RoSGNode", "ContentNode")
  content = CreateObject("RoSGNode", "ContentNode")
  content.title = "Episódios"

  if data.GetChildCount() = 0 then m.noItemsText.visible = true

  for i=0 to data.GetChildCount() - 1
    episodeContent = CreateObject("RoSGNode", "ContentNode")
    episodeContent.id = data.GetChild(i).id
    episodeContent.HDPosterUrl = data.GetChild(i).poster
    episodeContent.title = "episódio " + data.GetChild(i).number.ToStr()

    episodeContent.AddFields({
      synopsis: data.GetChild(i).synopsis
      category: data.GetChild(i).category
      banner: data.GetChild(i).banner
      poster: data.GetChild(i).poster
      releaseYear: data.GetChild(i).releaseYear
      parentalRating: data.GetChild(i).parentalRating
      number: data.GetChild(i).number
      season: data.GetChild(i).season
      url: data.GetChild(i).url
      duration: data.GetChild(i).duration
    })

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

  m.noItemsText.font.size = 20
end sub
