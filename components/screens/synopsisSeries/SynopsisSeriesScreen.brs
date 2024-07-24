sub Init()
  m.video = invalid
  m.dialog = invalid

  m.title = m.top.FindNode("title")
  m.synopsis = m.top.FindNode("synopsis")
  m.banner = m.top.FindNode("banner")
  m.category = m.top.FindNode("category")
  m.releaseYear = m.top.FindNode("releaseYear")
  m.parentalRating = m.top.FindNode("parentalRating")
  m.review = m.top.FindNode("review")
  m.seasons = m.top.FindNode("seasons")

  m.top.ObserveField("isBack", "FocusScreen")
  m.top.ObserveField("content", "LoadContent")
  m.top.ObserveField("preLoadBanner", "HandlePreLoadBanner")
  
  Setup()
end sub

sub LoadContent(event as object)
  data = event.GetData()

  m.title.text = data.title
  m.synopsis.text = data.synopsis
  m.category.text = data.category
  m.releaseYear.text = data.releaseYear
  m.banner.uri = data.banner
  m.parentalRating.year = data.parentalRating
  m.review.text = data.review

  while m.seasons.content.GetChildCount() > 0
    m.seasons.content.RemoveChild(m.seasons.content.GetChild(0))
  end while

  for i=1 to data.numberSeasons
    seasonNode = CreateObject("RoSGNode", "ContentNode")
    seasonNode.title = i.ToStr() + "ª temporada" 
    m.seasons.content.AppendChild(seasonNode)
  end for

  m.top.isBack = false
  FocusScreen()
end sub

sub HandlePreLoadBanner(event as object)
  m.banner.uri = event.GetData()
end sub

sub FocusScreen()
  if not m.dialog = invalid then m.top.RemoveChild(m.dialog)
  m.seasons.jumpToItem = 0
  m.seasons.SetFocus(true)
end sub

sub Setup()
  opacity = m.top.FindNode("opacity")
  opacity.width = m.global.display["w"]
  opacity.height = m.global.display["h"]

  m.banner.width = m.global.display["w"]
  m.banner.height = m.global.display["h"]

  m.title.width = m.global.display["w"] / 1.5
  m.title.font.size = 60

  m.synopsis.width = m.global.display["w"] / 1.75
  m.synopsis.height = m.global.display["h"] / 3
  m.synopsis.font.size = 28

  m.category.font.size = 20
  m.releaseYear.font.size = 20
  m.review.font.size = 20
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  if key = "back" then
    m.top.visible = false
    m.top.isBack = true

    return true
  end if

  return false
end function