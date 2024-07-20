sub Init()
  m.top.functionName = "GetContent"
  
  m.env = GetVariableEnvironments()
end sub

sub GetContent()
  content = CreateObject("RoSGNode", "ContentNode")
  URL = m.env["api"] + "/serie"

  urlTransfer = CreateObject("RoUrlTransfer")
  urlTransfer.SetUrl(URL)
  response = urlTransfer.GetToString()

  if response = invalid then return
  response = ParseJson(response)

  for each item in response
    serie = CreateObject("RoSGNode", "ContentNode")

    serie.SetFields({ id: item.id })
    serie.AddFields({
      title: item.title
      synopsis: item.synopsis
      category: item.category
      banner: item.banner
      poster: item.poster
      releaseYear: item.releaseYear
      parentalRating: item.parentalRating
      review: item.review
      numberSeasons: item.numberSeasons
    })
    
    content.AppendChild(serie)
  end for

  m.top.content = content
end sub