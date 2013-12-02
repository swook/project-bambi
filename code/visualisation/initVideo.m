function initVideo()
	global Vis_Disabled
	if Vis_Disabled
		return;
	end

	global Vis_Filename;
	global Vis_VObj;
	global Vis_WriteEnabled;

	Vis_Filename = ['../../videos/' datestr(now) '.avi'];
	Vis_VObj     = VideoWriter(Vis_Filename);
	Vis_VObj.FrameRate = 6 % Store at 8fps
	open(Vis_VObj);
	Vis_WriteEnabled = true;
end
