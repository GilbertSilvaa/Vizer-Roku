function GetVideoPosition(id as string)
  sec = CreateObject("RoRegistrySection", "video_history")
  if sec.Exists(id) then return sec.Read(id)
  return "0"
end function

sub SetVideoPosition(id as string, time as float)
  if time < 60 then return

  time -= 5
  sec = CreateObject("RoRegistrySection", "video_history")
  sec.Write(id, time.ToStr())
  sec.Flush()
end sub

sub RemoveVideoPosition(id as string)
  sec = CreateObject("RoRegistrySection", "video_history")

  if sec.Exists(id) then sec.Delete(id)
  sec.Flush()
end sub