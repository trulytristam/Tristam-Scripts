function find_id(track_s,start)
	local s = 0
	while true do 
		local item = reaper.GetTrackMediaItem(track_s, s)
		local item_start = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
		if item_start == start then
			return reaper.GetTrackMediaItem(track_s,s)
		end
		s = s+1

	end
	
end
	

function unfold_midi_item_to_16_tracks(da_item)

		
	item = da_item
	track = reaper.GetMediaItem_Track(item)
	track_number = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER")
	item_take = reaper.GetMediaItemTake(item,0)


	retval = true
	i = 0


	--create table of related tracks
	-- related_tracks = {}
	-- sixteen = 0
	-- while true do
	-- 	if sixteen > 15 then
	-- 		break
	-- 	end

	-- 	track_being_checked = reaper.GetTrack(0,track_number+sixteen)

	-- 	reaper.GetMediaTrackInfo_Value(MediaTrack tr,string parmname)

	-- 	sixteen = sixteen + 1
	-- end



	while retval do


		retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( item_take, i )

		if retval == false then
			break
		end

		ppq_length = endppqpos - startppqpos

		offset_pitch = pitch-36


		PT_start_pos = reaper.MIDI_GetProjTimeFromPPQPos(item_take,startppqpos)
		PT_end_pos = reaper.MIDI_GetProjTimeFromPPQPos(item_take,endppqpos)

		track_to_add_midi_clip_to = reaper.GetTrack(0,track_number+1+offset_pitch)
		reaper.CreateNewMIDIItemInProj(track_to_add_midi_clip_to,PT_start_pos,PT_end_pos)


		num_items_on_track = reaper.CountTrackMediaItems(track_to_add_midi_clip_to)
		item_to_add_note_to = find_id(track_to_add_midi_clip_to, PT_start_pos)
		take_to_add_note_to = reaper.GetTake(item_to_add_note_to,0)

		reaper.MIDI_InsertNote(take_to_add_note_to,0,0,0,ppq_length,0,pitch,vel)


		i  = i+1

	end
	
	 

	i_take = reaper.GetMediaItemTake(item,0)
		---------------delete
	while true do
		
		retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( i_take, 0 )
		if retval == false then
			break
		end

		 reaper.MIDI_DeleteNote(i_take,0)

	end
		


end	




function fold_midi_item_to_one_track(da_item)


	item = da_item
	item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
	item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")

	track = reaper.GetMediaItem_Track(item)
	track_number = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER")
	item_take = reaper.GetMediaItemTake(item,0)

	for t=0, 16-1 do

		track_to_fold = reaper.GetTrack(0,track_number+1+t)
		if track_to_fold == nil then
			break
		end

		items_to_delete = {}
		itd_iter = 0

		i = 0
		--scan track for items to fold
		while true do

			item_to_fold = reaper.GetTrackMediaItem(track_to_fold,i)		

			if item_to_fold == nil then
				break
			end
			item_to_fold_take = reaper.GetMediaItemTake(item_to_fold,0)
			item_to_fold_pos = reaper.GetMediaItemInfo_Value(item_to_fold,"D_POSITION")
			item_to_fold_len = reaper.GetMediaItemInfo_Value(item_to_fold,"D_LENGTH")


			if item_to_fold_pos >= item_pos+item_len then
				break
			end

			if item_to_fold_pos >= item_pos then

				items_to_delete[itd_iter] = item_to_fold
				itd_iter = itd_iter + 1

				retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( item_to_fold_take, 0)

				insertstart = reaper.MIDI_GetPPQPosFromProjTime(item_take, item_to_fold_pos)
				insertend = reaper.MIDI_GetPPQPosFromProjTime(item_take, item_to_fold_pos+item_to_fold_len)

				reaper.MIDI_InsertNote(item_take,0,0,insertstart,insertend,0,pitch,vel)


			end

			i = i +1
		end

		---delete clips on current track
		d = #items_to_delete
		
		while items_to_delete[d] ~= nil do

			--reaper.ShowConsoleMsg(tostring(items_to_delete[d]).."\n")
			reaper.DeleteTrackMediaItem(track_to_fold,items_to_delete[d])
			d = d -1
		end


	end




end 





function main()

	num_item = reaper.CountSelectedMediaItems(0)
	for it=0, num_item-1 do
		ITEM = reaper.GetSelectedMediaItem(0,it)
		ITEM_TAKE = reaper.GetMediaItemTake(ITEM,0)
		
		n = 0
		while true do
			retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( ITEM_TAKE, n )
			if retval == false then
				break
			end
			n = n+1
		end


		if n == 0 then
			fold_midi_item_to_one_track(ITEM)	
		else 
			unfold_midi_item_to_16_tracks(ITEM)
		end

	end
end




reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(-1)

main()

reaper.PreventUIRefresh(1)

reaper.Undo_EndBlock("fold/unfold",0)