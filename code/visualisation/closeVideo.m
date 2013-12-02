function closeVideo()
	global Vis_Disabled
	if Vis_Disabled
		return;
	end

	global Vis_Filename;
	global Vis_VObj;
	close(Vis_VObj);
end
