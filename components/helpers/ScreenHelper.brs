sub SetScreen(screen as string)
  m.global.screen = screen
end sub

function GetScreen()
  return m.global.screen
end function