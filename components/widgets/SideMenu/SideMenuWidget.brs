sub Init()
  m.container = m.top.FindNode("container")
  m.menu = m.top.FindNode("menu")

  m.menu.ObserveField("buttonSelected", "ChangeScreen")

  m.top.ObserveField("isFocus", "OnFocusChange")
  m.top.ObserveField("itemFocus", "OnItemFocusChange")

  Setup()
end sub

sub ChangeScreen(event as object)
  screen = MenuItemToScreenMap(event.GetData())
  if screen = GetScreen() then Unfocus()
  SetScreen(screen)
end sub

sub OnFocusChange(event as object)
  m.menu.SetFocus(event.GetData())
  m.container.color = "0x091835"

  for i = 0 to m.menu.GetChildCount() - 1
    btn = m.menu.GetChild(i)
    btn.text = btn.id
  end for
end sub

sub OnItemFocusChange(event as object)
  m.menu.focusButton = event.GetData()
end sub

function MenuItemToScreenMap(item as integer)
  screens = {
    "0": "HomeScreen"
    "1": "SeriesScreen"
  }

  return screens[item.ToStr()]
end function

sub Unfocus()
  m.top.isBack = true
  m.container.color = "0x09183500"

  for i = 0 to m.menu.GetChildCount() - 1
    btn = m.menu.GetChild(i)
    btn.text = ""
  end for
end sub

sub Setup()
  m.container.width = 155
  m.container.height = m.global.display["h"]
  m.menu.translation = [0, m.global.display["h"] / 2.6]

  for i = 0 to m.menu.GetChildCount() - 1
    btn = m.menu.GetChild(i)
    btn.textFont.size = 16
    btn.focusedTextFont.size = 16
  end for
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
  if not press then return false

  if key = "right" then
    m.menu.focusButton = m.top.itemFocus
    Unfocus()
    return true
  end if

  return false
end function