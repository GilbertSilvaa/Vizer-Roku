sub Init()
  m.video = invalid
  m.dialog = invalid

  m.serieId = ""
  m.title = m.top.FindNode("title")
  m.synopsis = m.top.FindNode("synopsis")
  m.banner = m.top.FindNode("banner")
  m.category = m.top.FindNode("category")
  m.releaseYear = m.top.FindNode("releaseYear")
  m.parentalRating = m.top.FindNode("parentalRating")
  m.review = m.top.FindNode("review")

  m.episodes = m.top.FindNode("episodes")
  m.episodes.ObserveField("itemSelected", "PlayVideo")

  m.seasons = m.top.FindNode("seasons")
  m.seasons.ObserveField("itemSelected", "LoadEpisodes")

  m.top.ObserveField("isBack", "FocusScreen")
  m.top.ObserveField("content", "LoadContent")
  m.top.ObserveField("preLoadBanner", "HandlePreLoadBanner")
  
  Setup()
end sub

sub LoadContent(event as object)
  data = event.GetData()

  m.serieId = data.id
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
  LoadEpisodes()
  FocusScreen()
end sub

sub LoadEpisodes()
  task = CreateObject("RoSGNode", "GetEpisodesTask")
  task.serieId = m.serieId

  if m.seasons.itemSelected >= 0 then
    task.season = m.seasons.itemSelected + 1
  else
    task.season = 1
  end if

  task.ObserveField("content", "EpisodesLoaded")
  task.control = "RUN"
end sub

sub PlayVideo()
  episodeSelected = m.episodes.rowItemSelected[1]
  data = m.episodes.content.GetChild(0).GetChild(episodeSelected)
  
  content = CreateObject("RoSGNode", "ContentNode")
  content.url = data.url
  content.title = data.title
  content.streamformat = "unk"

  m.video = CreateObject("RoSGNode", "VideoWidget")
  m.video.ObserveField("isBack", "HandleBackVideo")
  m.video.ObserveField("hasError", "HandleErrorVideo")
  
  m.video.width = m.global.display["w"]
  m.video.height = m.global.display["h"]
  m.video.visible = true
  
  m.video.contentId = data.id
  m.video.content = content
  m.video.control = "play"
  
  m.top.AppendChild(m.video)
  m.video.SetFocus(true)
end sub

sub HandleBackVideo()
  if not m.video = invalid then m.top.RemoveChild(m.video)
  m.episodes.SetFocus(true)
end sub

sub HandleErrorVideo()
  m.dialog = CreateObject("RoSGNode", "DialogWidget")
  m.dialog.title = "Ops! Houve um erro"
  m.dialog.message = "Ocorreu um erro ao tentar reproduzir o conteúdo"
  m.dialog.ObserveField("close", "FocusScreen")

  m.top.AppendChild(m.dialog)
  m.dialog.buttonGroup.SetFocus(true)
end sub

sub EpisodesLoaded(event as object)
  m.episodes.content = event.GetData()
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
    m.seasons.itemSelected = 0
    m.top.visible = false
    m.top.isBack = true

    return true
  end if

  if key = "right" and m.seasons.IsInFocusChain() then
    m.episodes.SetFocus(true)
  end if

  if key = "left" and m.episodes.IsInFocusChain() then
    m.seasons.SetFocus(true)
  end if

  return false
end function