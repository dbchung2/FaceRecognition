filter = imread('NBC_logo.jpg');
FRAME_DIR = 'clip1/tracked_frames/';
start_frame = 22;
end_frame = 200;

for f = start_frame:end_frame
    im = imread(fullfile(FRAME_DIR, sprintf('clip1_%03d.jpg', f)));
    frame_num = sprintf('%03d', f);
    name = strcat('clip1/', 'logo_detected/', 'clip1_', frame_num, '.jpg');
    findLogo(im, filter, name);
end