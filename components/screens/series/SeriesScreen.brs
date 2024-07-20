sub Init()
  m.loading = m.top.FindNode("loading")
  m.grid = m.top.FindNode("grid")
  m.sideMenu = m.top.FindNode("sideMenu")
  m.sideMenu.ObserveField("isBack", "FocusScreen")

  LoadGridContent()
end sub

sub LoadGridContent()
  task = CreateObject("RoSGNode", "GetSeriesTask")
  task.ObserveField("content", "ContentLoaded")
  task.control = "RUN"
end sub

sub ContentLoaded(event as object)
  data = event.GetData()
  content = CreateObject("RoSGNode", "ContentNode")

  for i = 0 to data.GetChildCount() - 1
    item = CreateObject("RoSGNode", "ContentNode")

    item.SetFields({
      id: data.GetChild(i).id
      hdposterurl: data.GetChild(i).poster
      sdposterurl: data.GetChild(i).poster
      hdgridposterurl: data.GetChild(i).poster
      sdgridposterurl: data.GetChild(i).poster
      shortdescriptionline1: data.GetChild(i).title
    })

    item.AddFields({
      title: data.GetChild(i).title
      synopsis: data.GetChild(i).synopsis
      category: data.GetChild(i).category
      banner: data.GetChild(i).banner
      poster: data.GetChild(i).poster
      releaseYear: data.GetChild(i).releaseYear
      parentalRating: data.GetChild(i).parentalRating
      review: data.GetChild(i).review
      numberSeasons: data.GetChild(i).numberSeasons
    })

    content.AppendChild(item)
  end for

  m.grid.content = content
  m.grid.SetFocus(true)
  m.loading.visible = false
end sub

sub FocusScreen(event as object)
  m.grid.visible = true
  m.sideMenu.isBack = false
  m.sideMenu.isFocus = false

  m.grid.SetFocus(event.GetData())
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  if key = "left" and m.grid.IsInFocusChain() then
    m.sideMenu.isFocus = true
    return true
  end if

  return false
end function