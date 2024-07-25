sub Init()
  m.poster = m.top.findNode("poster") 
  m.title = m.top.findNode("title")
  Setup()
end sub

sub LoadContent()
  itemContent = m.top.itemContent
  m.poster.uri = itemContent.HDPosterUrl
  m.title.text = itemContent.title
end sub

sub Setup()
  m.title.font.size = 18
end sub