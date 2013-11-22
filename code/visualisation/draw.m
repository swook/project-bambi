function draw(Gmax, G, A, F)
	% Declare / Get globals
	global Vis_IBambi;
	global Vis_IBambi_BGIdxs;
	global Vis_IGrass;
	global Vis_IGrass_Total;
	global Vis_IFire;
	global Vis_Frame;
	global Vis_BG;

	% Different sizes
	ph = 16;
	pw = 16;
	pn = ph * pw;
	h = size(G, 1);
	w = size(G, 2);
	n = h * w;
	Ih = ph * h;
	Iw = pw * w;
	In = Ih * Iw;
	In3 = In * 3;

	% Load Bambi, Fire, and Grass as needed
	if numel(Vis_IBambi) ~= pn
		Vis_IBambi = imread('bambi.jpg');
		Vis_IBambi_Flat = sum(Vis_IBambi, 3);
		Vis_IBambi_Flat = cat(3, Vis_IBambi_Flat, Vis_IBambi_Flat, Vis_IBambi_Flat);
		Vis_IBambi_BGIdxs = Vis_IBambi_Flat < 45;
	end
	if numel(Vis_IGrass) ~= pn
		Vis_IGrass = reshape(imread('grass.jpg'), pn, 3);
		Vis_IGrass_Total = reshape(repmat(Vis_IGrass, n, 1), Ih, Iw, 3);
	end
	if numel(Vis_IFire) ~= pn
		Vis_IFire = imread('fire.jpg');
	end

	% Initialise frame if not done already
	if numel(Vis_Frame) ~= In3
		Vis_Frame = zeros(Ih, Iw, 3, 'uint8');
	end
	if numel(Vis_BG) ~= In3
		Vis_BG = zeros(size(Vis_Frame));
		Vis_BG(:, :, 1) = 120;
		Vis_BG(:, :, 2) = 72;
	end

	% Paint grass
	alph = G ./ Gmax;
	alph = cat(3, alph, alph, alph);
	alph = imresize(alph, ph, 'Method', 'nearest');
	Vis_Frame = uint8((1 - alph) .* double(Vis_BG) + alph .* double(Vis_IGrass_Total));

	% Paint agent
	if numel(A) > 1
		nagent = size(A, 1);
		for i = 1:nagent
			y0 = (A(i, 1) - 1) * ph + 1;
			x0 = (A(i, 2) - 1) * pw + 1;
			y1 = y0 + ph - 1;
			x1 = x0 + pw - 1;

			bambi = Vis_IBambi;
			grid  = Vis_Frame(y0:y1, x0:x1, :);
			bambi(Vis_IBambi_BGIdxs) = grid(Vis_IBambi_BGIdxs);

			Vis_Frame(y0:y1, x0:x1, :) = bambi(:, :, :);
		end
	end
end
