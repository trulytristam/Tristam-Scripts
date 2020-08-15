-- @description Auto solo for selected tracks (defer)
-- @version 1.0
-- @author me2beats
-- @changelog
--  + init
--USER VARIABLES

give = 0.3

--------------------

local r = reaper


last_mouse_state = 0
og_mouse_pos = 0
offset = 0
dir = 0

reaper.Main_OnCommand(39000,0)


function main()
  local ch_count = r.GetProjectStateChangeCount()
  
  
  
  mouse_state = reaper.JS_Mouse_GetState( 5 )
  

  reaper.BR_GetMouseCursorContext()

--pressed
    if reaper.GetSelectedMediaItem(0,0) ~= nil  then
      if last_mouse_state == 0 and mouse_state == 1 and reaper.BR_GetMouseCursorContext_Item()~=nil then

        reaper.Undo_BeginBlock2(0)

        data = {}
        data_i = 0
        sel_item_count = reaper.CountSelectedMediaItems(0)


        reaper.BR_GetMouseCursorContext()
        item_under_mouse = reaper.BR_GetMouseCursorContext_Item()

        
        item_under_mouse_pos = reaper.GetMediaItemInfo_Value(item_under_mouse,"D_POSITION")
        item_under_mouse_len = reaper.GetMediaItemInfo_Value(item_under_mouse,"D_LENGTH")
        

        for i = 0, sel_item_count-1 do
            last_mouse_state = 1
            mouse_pos = reaper.BR_GetMouseCursorContext_Position()
            og_item = reaper.GetSelectedMediaItem(0,i)
            og_item_pos = reaper.GetMediaItemInfo_Value(og_item,"D_POSITION")
            og_item_len = reaper.GetMediaItemInfo_Value(og_item,"D_LENGTH")
            og_item_take = reaper.GetMediaItemTake(og_item,0)
            og_item_take_off = reaper.GetMediaItemTakeInfo_Value(og_item_take,"D_STARTOFFS")

            data[data_i] = mouse_pos
            data[data_i+1] = og_item_pos
            data[data_i+2] = og_item_len
            data[data_i+3] = og_item_take_off

           

            data_i = data_i + 4

        end

        if mouse_pos > (item_under_mouse_pos+item_under_mouse_len/2) then
          dir = -1
        elseif mouse_pos < (item_under_mouse_pos+item_under_mouse_len/2) then
          dir = 1
        end
        
        og_mouse_pos = mouse_pos


      end

    --held
      if last_mouse_state == 1 and mouse_state == 1 then
         
          reaper.BR_GetMouseCursorContext()
          mouse_pos2 = reaper.BR_GetMouseCursorContext_Position()


          for i = 0, sel_item_count-1 do
          --reaper.ShowConsoleMsg(mouse_pos2)
              item = reaper.GetSelectedMediaItem(0,i)
              item_take = reaper.GetMediaItemTake(item,0)
              item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
              item_take_off = reaper.GetMediaItemTakeInfo_Value(item_take,"D_STARTOFFS")

              if dir == 1 then
              reaper.SetMediaItemTakeInfo_Value(item_take,"D_STARTOFFS",data[(i*4)+3] + (data[0]-mouse_pos2))
              reaper.SetMediaItemLength( item, data[(i*4)+2]+ (mouse_pos2 - data[0] ), 1 )
              end

              if dir == -1 then
              reaper.SetMediaItemPosition(item, data[(i*4)+1] +( mouse_pos2- data[0]),1)
              reaper.SetMediaItemLength(item, data[(i*4)+2] -(mouse_pos2-data[0]),1)
              end
          end

          mouse_pos2 = reaper.BR_GetMouseCursorContext_Position()
          
         

      end


    --released
      if last_mouse_state == 1 and mouse_state == 0 then
        last_mouse_state = 0 

        reaper.BR_GetMouseCursorContext()
        mouse_pos = reaper.BR_GetMouseCursorContext_Position()
        itemone = reaper.GetSelectedMediaItem(0,0)

        --move everything
        num_items = reaper.CountMediaItems(0)

        if dir > 0 then
          for i = 0, num_items-1 do

            item = reaper.GetMediaItem(0,i)
            item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")

            if item_pos >= og_item_pos+og_item_len-give then
              reaper.SetMediaItemPosition(item,item_pos+(mouse_pos2-og_mouse_pos),1)
            end
          end
        end

        if dir < 0 then
          for i = 0, num_items-1 do

            item = reaper.GetMediaItem(0,i)
            item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
            item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")

            if item_pos+item_len <= og_item_pos+give then
              reaper.SetMediaItemPosition(item,item_pos+(mouse_pos2-og_mouse_pos),1)
            end
          end
        end
      
        reaper.Undo_EndBlock2(0,"andrew_trim",0)
      end
  end  


  last_ch_count = ch_count

  
 
  r.defer(main)

end

----------------------------------------------------------------------------------------------------
function SetButtonON()
  r.SetToggleCommandState( sec, cmd, 1 ) -- Set ON
  r.RefreshToolbar2( sec, cmd )
  main()
end

----------------------------------------------------------------------------------------------------
function SetButtonOFF()
  r.SetToggleCommandState( sec, cmd, 0 ) -- Set OFF
  r.RefreshToolbar2( sec, cmd ) 
end
----------------------------------------------------------------------------------------------------

_, _, sec, cmd = r.get_action_context()
SetButtonON()
r.atexit(
function()
r.SoloAllTracks(0) -- unsolo all
SetButtonOFF()
reaper.Main_OnCommand(39001,0)
end
)