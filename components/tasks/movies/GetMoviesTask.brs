sub Init()
  m.top.functionName = "GetContent"
  
  m.env = GetVariableEnvironments()
end sub

sub GetContent()
  content = CreateObject("RoSGNode", "ContentNode")
  URL = m.env["api"] + "/movie"

  urlTransfer = CreateObject("RoUrlTransfer")
  urlTransfer.SetUrl(URL)
  response = urlTransfer.GetToString()

  if response = invalid then return
  response = ParseJson(response)

  for each item in response
    movie = CreateObject("RoSGNode", "ContentNode")

    movie.SetFields({ id: item.id })
    movie.AddFields({
      title: item.title
      synopsis: item.synopsis
      category: item.category
      banner: item.banner
      poster: item.poster
      releaseYear: item.releaseYear
      parentalRating: item.parentalRating
      review: item.review
      url: item.video.url
      duration: item.video.duration
      streamFormat: item.video.streamFormat
    })
    
    content.AppendChild(movie)
  end for

  m.top.content = content
end sub