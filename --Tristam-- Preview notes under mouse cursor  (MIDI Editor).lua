
_,_,_ = reaper.BR_GetMouseCursorContext()
reaper.BR_GetMouseCursorContext_MIDI()
mouse_position = reaper.BR_GetMouseCursorContext_Position()

media_item = reaper.GetSelectedMediaItem(0,0)

item_track = reaper.GetMediaItem_Track(media_item)

media_item_take = reaper.GetMediaItemTake(media_item,0)

midi_mouse_position = reaper.MIDI_GetPPQPosFromProjTime(media_item_take, mouse_position )

number_of_notes = reaper.MIDI_CountEvts(media_item_take)

note_to_play = {}

getoriginalnoteselected = {}
                                                      
isitoverundermouse = {}
----------------------------


------determining original selected notes---
-----------------------------------------------------

function getoriginalnotesel()
	for to = 0, number_of_notes - 1 do
	retval, isselected,  mutedOut, startpos,  endpos, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(media_item_take,to)
	getoriginalnoteselected[to] = isselected
  

	end
end

function resettooriginalselection()
			for s = 0, number_of_notes - 1 do 


				if getoriginalnoteselected[s] == false then
		 
				reaper.MIDI_SetNote(media_item_take, s, getoriginalnoteselected[s],NULL,NULL,NULL,NULL,NULL,NULL,NULL)

			    end
				reaper.MIDI_Sort(media_item_take)	
			end
end

------
p = 0
y = 0
-------	
function main()
		------Determine if note is under/over the mouse cursor
			for i = 0, (number_of_notes)-1 do

				------Determining values for note start and note end
			  retval, selectedOut,  mutedOut, startpos,  endpos, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(media_item_take,i)
	            
	            ------determine if note is over/under mouse position
	            -------------------------------------------------------
	            if startpos > midi_mouse_position and endpos > midi_mouse_position 
	            		or
	            	startpos < midi_mouse_position and endpos < midi_mouse_position 
	            		then
 					  ----false
	            		isnoteselected = false
	            		y = y + 1
	          	                
	            	elseif startpos < midi_mouse_position and endpos > midi_mouse_position then	           
					   -----true
	            		isnoteselected = true
	            end
	            isitoverundermouse[i] = isnoteselected					 
			end
-----------------------------------------------------------
 ---------------No notes selected?
 --------------------------------------------------
			if y == number_of_notes then				
				mousenotunderovernote = true 
				
								
			end					
			-------------------------------------------------
			--unselect unwanted notes--Select notes and record chan/pitch/velocity
			-------------------------------------------------
				for j = 0, number_of_notes - 1 do 

						trueorfalse = isitoverundermouse[j]

					--reaper.MIDI_SetNote(media_item_take, j,trueorfalse,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

								if trueorfalse == true then

				 		retval2, selectedOut2, mutedOut2, startppqposOut2, endppqposOut2, chanOut2, note_pitch, note_velocity = reaper.MIDI_GetNote( media_item_take, j )					         
										  note_to_play[p] = 144 + chanOut2;
									      note_to_play[p+1] = note_pitch;
									      note_to_play[p+2] = note_velocity;
									     
									      p = p + 3
								end	      

				end



				
	-------------------------------------------------
	----Get lenght of selected notes table			
	length= #note_to_play + 1
	---------------------------------------------		 	
		if mousenotunderovernote ~= true then	

		local ctr = 0 
			while ctr < length  do				
				reaper.StuffMIDIMessage(0, note_to_play[ctr], note_to_play[ctr + 1], note_to_play[ctr+2])
			    ctr = ctr + 3
			end			
	end
end
----------------------------------------

  

getoriginalnotesel()

reaper.Main_OnCommand( reaper.NamedCommandLookup( "_S&M_CC123_SEL_TRACKS"),  0)

--reaper.PreventUIRefresh(1)



reaper.MIDI_SelectAll(media_item_take,true)
		main()




resettooriginalselection()




--reaper.Main_OnCommand( reaper.NamedCommandLookup( "_S&M_CC123_SEL_TRACKS"),  0)



reaper.UpdateArrange() 
--reaper.PreventUIRefresh(-1)











		
		
