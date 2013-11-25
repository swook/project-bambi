function initVideo()
	global Vis_Filename;
	global Vis_VObj;

	Vis_Filename = ['../../videos/' datestr(now) '.avi'];
	Vis_VObj     = VideoWriter(Vis_Filename, 'Motion JPEG 2000');
	Vis_VObj.FrameRate = 8; % Store at 8fps
	open(Vis_VObj);
end
