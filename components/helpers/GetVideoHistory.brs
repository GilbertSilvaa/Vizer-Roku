function GetVideoPosition(id as string)
  sec = CreateObject("RoRegistrySection", "video_history")
  if sec.Exists(id) then return sec.Read(id)
  return 0
end function

function SetVideoPosition(id as string, time as float)
  if time > 30 then time -= 10

  sec = CreateObject("RoRegistrySection", "video_history")
  sec.Write(id, time.ToStr())
  sec.Flush()
end function