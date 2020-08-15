


function snapitem(tosnapitem)
      
    reaper.Main_OnCommand(40289,0) --Unselect all items
    reaper.SetMediaItemInfo_Value(tosnapitem, "B_UISEL", 1)
    reaper.Main_OnCommand(41844,0) -- remove all stretch markers
    reaper.Main_OnCommand(42027,0) -- clear transient guides
    
    
    
    last = cur
    
    reaper.SetEditCurPos( reaper.GetMediaItemInfo_Value(tosnapitem,"D_POSITION") , 0, 0 )
    
    while true do
    
      reaper.Main_OnCommand(40375,0) -- move to next transient
      reaper.Main_OnCommand(41842,0) -- add stretch marker at cursor
      
      
      curnew = reaper.GetCursorPosition()
      
      if curnew == last then
      
          break
      end
      
      last = curnew
    
    
    end
    
    reaper.Main_OnCommand(41846,0) -- snap markers to grid


end













cur = reaper.GetCursorPosition()
start_time, end_time = reaper.BR_GetArrangeView(0)
ci = reaper.CountSelectedMediaItems(0)

flagg = false

myitems = {}


x = 0

while x< ci do

  myitems[x] = reaper.GetSelectedMediaItem(0,x)
  x = x+1
  
end















reaper.Undo_BeginBlock()

reaper.PreventUIRefresh(-1)
   



x = 0

while x< ci do

  snapitem(myitems[x])
  x = x+1
  
end



reaper.SetEditCurPos( cur, 0, 0 )
reaper.BR_SetArrangeView(0,start_time, end_time)


reaper.PreventUIRefresh(1)



reaper.Undo_EndBlock("Add and snap stretch markers",0)








