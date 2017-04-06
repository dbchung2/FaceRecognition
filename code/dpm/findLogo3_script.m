filter = imread('Flicks_and_the_City_logo.png');
FRAME_DIR = 'clip3/tracked_frames';
start_frame = 16;
end_frame = 50;

for f = start_frame:end_frame
    im = imread(fullfile(FRAME_DIR, sprintf('clip3_%04d.jpg', f)));
    frame_num = sprintf('%04d', f);
    name = strcat('clip3/', 'logo_detected/', 'clip3_', frame_num, '.jpg');
    findLogo(im, filter, name);
end