clip1_t = track_objects;
clip1_t2 = {};
% clip2_t = track_objects2;
% clip2_t2 = {};
% clip3_t = track_objects3;
% clip3_t2 = {};

clip1_x = size(clip1_t, 2);
for l=1:clip1_x
    y = size(clip1_t{l}, 1);
    if y > 5
        z = size(clip1_t2, 2);
        clip1_t2{z+1} = clip1_t{l};
    end
end

FRAME_DIR = '../../clip_1/';
start_frame = 22;
end_frame = 200;

for i = start_frame:end_frame
    im_cur = imread(fullfile(FRAME_DIR, sprintf('%03d.jpg', i)));
    det_data = load(sprintf('clip1/bbox/clip1_%03d_bbox.mat', i));
    dets_cur = det_data.bbox;
    label_data = load(sprintf('clip1/labels/clip1_%03d_labels.mat', i));
    labels = label_data.labels;
    boxes_cur = [];
    x = size(clip1_t2, 2);
    for j=1:x
        y = size(clip1_t2{j}, 1);
        for k=1:y
            if clip1_t2{j}(k, 2) == i
                boxes_cur = vertcat(boxes_cur, [dets_cur(clip1_t2{j}(k, 1), 1), dets_cur(clip1_t2{j}(k, 1), 2), dets_cur(clip1_t2{j}(k, 1), 3), dets_cur(clip1_t2{j}(k, 1), 4)]);
            end
        end
    end
    frame_num = sprintf('%03d', i);
    name = strcat('clip1/', 'tracked_frames/', 'clip1_', frame_num, '.jpg');
    fig = figure('visible', 'off'), image(im_cur), axis image tight, hold on
    for m=1:size(boxes_cur,1)
%     for m=1:size(dets_cur,1)
        rectangle('Position', [boxes_cur(m,1), boxes_cur(m,2), boxes_cur(m,3) - boxes_cur(m,1), boxes_cur(m,4) - boxes_cur(m,2)]);
%         rectangle('Position', [dets_cur(m,1), dets_cur(m,2), dets_cur(m,3) - dets_cur(m,1), dets_cur(m,4) - dets_cur(m,2)]);
        if labels(1,m) == 1
            text(boxes_cur(m,1), boxes_cur(m,2), 'Male', 'Color', 'white');
%             text(dets_cur(m,1), dets_cur(m,2), 'Male', 'Color', 'white');
        else
            text(boxes_cur(m,1), boxes_cur(m,2), 'Female', 'Color', 'white');
%             text(dets_cur(m,1), dets_cur(m,2), 'Female', 'Color', 'white');
        end
    end
    set(gca, 'position', [0 0 1 1], 'units', 'normalized');
    saveas(fig, name);
end

% clip2_x = size(clip2_t, 2);
% for l=1:clip2_x
%     y = size(clip2_t{l}, 1);
%     if y > 5
%         z = size(clip2_t2, 2);
%         clip2_t2{z+1} = clip2_t{l};
%     end
% end

FRAME_DIR = '../../clip_2/';
start_frame = 65;
end_frame = 199;

for i = start_frame:end_frame
    im_cur = imread(fullfile(FRAME_DIR, sprintf('%03d.jpg', i)));
    det_data = load(sprintf('clip2/bbox/clip2_%03d_bbox.mat', i));
    dets_cur = det_data.bbox;
    label_data = load(sprintf('clip2/labels/clip2_%03d_labels.mat', i));
    labels = label_data.labels;
%     boxes_cur = [];
%     x = size(clip2_t2, 2);
%     for j=1:x
%         y = size(clip2_t2{j}, 1);
%         for k=1:y
%             if clip2_t2{j}(k, 2) == i
%                 boxes_cur = vertcat(boxes_cur, [dets_cur(clip2_t2{j}(k, 1), 1), dets_cur(clip2_t2{j}(k, 1), 2), dets_cur(clip2_t2{j}(k, 1), 3), dets_cur(clip2_t2{j}(k, 1), 4)]);
%             end
%         end
%     end
    frame_num = sprintf('%03d', i);
    name = strcat('clip2/', 'tracked_frames/', 'clip2_', frame_num, '.jpg');
    fig = figure('visible', 'off'), image(im_cur), axis image tight, hold on
%     for m=1:size(boxes_cur,1)
    for m=1:size(dets_cur,1)
%         rectangle('Position', [boxes_cur(m,1), boxes_cur(m,2), boxes_cur(m,3) - boxes_cur(m,1), boxes_cur(m,4) - boxes_cur(m,2)]);
        rectangle('Position', [dets_cur(m,1), dets_cur(m,2), dets_cur(m,3) - dets_cur(m,1), dets_cur(m,4) - dets_cur(m,2)]);
        if labels(1,m) == 1
%             text(boxes_cur(m,1), boxes_cur(m,2), 'Male', 'Color', 'white');
            text(dets_cur(m,1), dets_cur(m,2), 'Male', 'Color', 'white');
        elseif labels(1,m) == 0
%             text(boxes_cur(m,1), boxes_cur(m,2), 'Female', 'Color', 'white');
            text(dets_cur(m,1), dets_cur(m,2), 'Female', 'Color', 'white');
        end
    end
    set(gca, 'position', [0 0 1 1], 'units', 'normalized');
    saveas(fig, name);
end

% clip3_x = size(clip3_t, 2);
% for l=1:clip3_x
%     y = size(clip3_t{l}, 1);
%     if y > 5
%         z = size(clip3_t2, 2);
%         clip3_t2{z+1} = clip3_t{l};
%     end
% end

FRAME_DIR = '../../clip_3/';
start_frame = 16;
end_frame = 290;

for i = start_frame:end_frame
    im_cur = imread(fullfile(FRAME_DIR, sprintf('%04d.jpg', i)));
    det_data = load(sprintf('clip3/bbox/clip3_%04d_bbox.mat', i));
    dets_cur = det_data.bbox;
    label_data = load(sprintf('clip3/labels/clip3_%04d_labels.mat', i));
    labels = label_data.labels;
%     boxes_cur = [];
%     x = size(clip3_t2, 2);
%     for j=1:x
%         y = size(clip3_t2{j}, 1);
%         for k=1:y
%             if clip3_t2{j}(k, 2) == i
%                 boxes_cur = vertcat(boxes_cur, [dets_cur(clip3_t2{j}(k, 1), 1), dets_cur(clip3_t2{j}(k, 1), 2), dets_cur(clip3_t2{j}(k, 1), 3), dets_cur(clip3_t2{j}(k, 1), 4)]);
%             end
%         end
%     end
    frame_num = sprintf('%04d', i);
    name = strcat('clip3/', 'tracked_frames/', 'clip3_', frame_num, '.jpg');
    fig = figure('visible', 'off'), image(im_cur), axis image tight, hold on
%     for m=1:size(boxes_cur,1)
    for m=1:size(dets_cur,1)
%         rectangle('Position', [boxes_cur(m,1), boxes_cur(m,2), boxes_cur(m,3) - boxes_cur(m,1), boxes_cur(m,4) - boxes_cur(m,2)]);
        rectangle('Position', [dets_cur(m,1), dets_cur(m,2), dets_cur(m,3) - dets_cur(m,1), dets_cur(m,4) - dets_cur(m,2)]);
        if labels(1,m) == 1
%             text(boxes_cur(m,1), boxes_cur(m,2), 'Male', 'Color', 'white');
            text(dets_cur(m,1), dets_cur(m,2), 'Male', 'Color', 'white');
        elseif labels(1,m) == 0
%             text(boxes_cur(m,1), boxes_cur(m,2), 'Female', 'Color', 'white');
            text(dets_cur(m,1), dets_cur(m,2), 'Female', 'Color', 'white');
        end
    end
    set(gca, 'position', [0 0 1 1], 'units', 'normalized');
    saveas(fig, name);
end

findLogo_script;
findLogo2_script;
findLogo3_script;