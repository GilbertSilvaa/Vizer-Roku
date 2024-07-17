sub Init()
  m.video = invalid
  m.title = m.top.FindNode("title")
  m.synopsis = m.top.FindNode("synopsis")
  m.poster = m.top.FindNode("poster")
  m.category = m.top.FindNode("category")
  m.releaseYear = m.top.FindNode("releaseYear")
  m.parentalRating = m.top.FindNode("parentalRating")
  m.btnsContainer = m.top.FindNode("btns-container")
  m.review = m.top.FindNode("review")

  m.top.ObserveField("content", "LoadContent")
  m.top.ObserveField("isBack", "FocusScreen")

  Setup()
end sub

sub LoadContent(event as object)
  data = event.GetData()

  m.title.text = data.title
  m.synopsis.text = data.synopsis
  m.category.text = data.category
  m.releaseYear.text = data.releaseYear
  m.poster.uri = data.banner
  m.parentalRating.year = data.parentalRating
  m.review.text = data.review

  m.top.isBack = false
  SetupButtons()
end sub

sub PlayVideo()
  content = CreateObject("RoSGNode", "ContentNode")
  content.url = m.top.content.url
  content.title = m.top.content.title
  content.streamformat = "unk"

  m.video = CreateObject("RoSGNode", "VideoWidget")
  m.top.AppendChild(m.video)
  m.video.ObserveField("isBack", "HandleBackVideo")

  m.video.width = m.global.display["w"]
  m.video.height = m.global.display["h"]
  m.video.visible = true
  m.video.isBack = false

  m.video.contentId = m.top.content.id
  m.video.content = content
  m.video.control = "play"
  m.video.SetFocus(true)
end sub

sub HandleBackVideo()
  SetupButtons()
  m.top.RemoveChild(m.video)
end sub

sub ResetPlayVideo()
  RemoveVideoPosition(m.top.content.id)
  PlayVideo()
end sub

sub FocusScreen()
  m.btnsContainer.SetFocus(true)
end sub

sub SetupButtons()
  positionVideo = GetVideoPosition(m.top.content.id)

  while m.btnsContainer.GetChildCount() > 0
    m.btnsContainer.RemoveChild(m.btnsContainer.GetChild(0))
  end while

  if positionVideo = "0" then
    playBtn = CreateObject("RoSGNode", "Button")
    playBtn.SetFields({
      id: "play"
      height: 50
      minWidth: 170
      text: "Assistir"
      showFocusFootprint: true
      iconUri: "pkg:/images/icons/play-icon.png"
      focusedIconUri: "pkg:/images/icons/play-icon.png"
      focusBitmapUri: "pkg:/images/colors/primary-color.png"
    })

    playBtn.ObserveField("buttonSelected", "PlayVideo")
    m.btnsContainer.AppendChild(playBtn)
    playBtn.SetFocus(true)
    return
  end if

  resetBtn = CreateObject("RoSGNode", "Button")
  resetBtn.SetFields({
    id: "reset-play"
    height: 50
    minWidth: 170
    text: "Assistir do inicio"
    showFocusFootprint: true
    iconUri: "pkg:/images/icons/reset-icon.png"
    focusedIconUri: "pkg:/images/icons/reset-icon.png"
    focusBitmapUri: "pkg:/images/colors/primary-color.png"
  })

  playBtn = CreateObject("RoSGNode", "Button")
  playBtn.SetFields({
    id: "play"
    height: 50
    minWidth: 170
    text: "Continuar assistindo"
    showFocusFootprint: true
    iconUri: "pkg:/images/icons/play-icon.png"
    focusedIconUri: "pkg:/images/icons/play-icon.png"
    focusBitmapUri: "pkg:/images/colors/primary-color.png"
  })

  playBtn.ObserveField("buttonSelected", "PlayVideo")
  resetBtn.ObserveField("buttonSelected", "ResetPlayVideo")

  m.btnsContainer.AppendChild(playBtn)
  m.btnsContainer.AppendChild(resetBtn)
  m.btnsContainer.SetFocus(true)
end sub

sub Setup()
  opacity = m.top.FindNode("opacity")
  opacity.width = m.global.display["w"]
  opacity.height = m.global.display["h"]

  m.poster.width = m.global.display["w"]
  m.poster.height = m.global.display["h"]

  m.title.width = m.global.display["w"] / 1.5
  m.title.font.size = 60

  m.synopsis.width = m.global.display["w"] / 1.75
  m.synopsis.height = m.global.display["h"] / 2.5
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