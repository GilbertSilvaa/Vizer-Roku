sub Init()
  m.top.functionName = "GetContent"
  m.env = GetVariableEnvironments()
end sub

sub GetContent()
  content = CreateObject("RoSGNode", "ContentNode")
  URL = m.env["api"] + "/episodes/" + m.top.serieId + "/" + m.top.season.ToStr()

  urlTransfer = CreateObject("RoUrlTransfer")
  urlTransfer.SetUrl(URL)
  response = urlTransfer.GetToString()

  if response = invalid then return
  response = ParseJson(response)

  for each item in response
    episode = CreateObject("RoSGNode", "ContentNode")
    episode.id = item.id
    
    episode.AddFields({
      title: item.title
      synopsis: item.synopsis
      category: item.category
      banner: item.banner
      poster: item.poster
      releaseYear: item.releaseYear
      parentalRating: item.parentalRating
      number: item.number
      season: item.season
      url: item.video.url
      duration: item.video.duration
    })
    
    content.AppendChild(episode)
  end for

  m.top.content = content
end sub