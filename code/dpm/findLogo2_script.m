filter = imread('clevver_news.png');
FRAME_DIR = 'clip2/tracked_frames/';
start_frame = 86;
end_frame = 199;

for f = start_frame:end_frame
    im = imread(fullfile(FRAME_DIR, sprintf('clip2_%03d.jpg', f)));
    frame_num = sprintf('%03d', f);
    name = strcat('clip2/', 'logo_detected/', 'clip2_', frame_num, '.jpg');
    findLogo(im, filter, name);
end