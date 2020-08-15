georgecurpos = reaper.GetCursorPosition()



boop = reaper.GetMainHwnd()
reaper.MIDIEditor_OnCommand(boop,40886)

reaper.MoveEditCursor(georgecurpos,1)