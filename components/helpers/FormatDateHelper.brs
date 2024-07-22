function FormatSecondsToHHmm(seconds as integer)
  hours = Int(seconds / 3600)
  remainingSeconds = seconds mod 3600
  minutes = Int(remainingSeconds / 60)
  timeString = ""

  if hours > 0 then timeString += hours.ToStr() + "h"
  if minutes > 0 then timeString += minutes.ToStr() + "m"
  
  return timeString
end function