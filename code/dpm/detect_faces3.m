FRAME_DIR = '../../clip_3/';
start_frame = 16;
end_frame = 290;
data = load('../face_final.mat');
model = data.model;

for f = start_frame:end_frame
    im = imread(fullfile(FRAME_DIR, sprintf('%04d.jpg', f)));
    bbox = process(im, model, 0.5);
    boxes_to_remove = [];
    for i=1:(size(bbox,1) - 1)
        for j=(i+1):size(bbox,1)
            box1 = [bbox(i,1), bbox(i,2), bbox(i,3), bbox(i,4)];
            box2 = [bbox(j,1), bbox(j,2), bbox(j,3), bbox(j,4)];
            area_intersection = rectint(box1, box2);
            union_coords = [min(box1(1,1), box2(1,1)), min(box1(1,2), box2(1,2)), max((box1(1,1) + (box1(1,3) - 1)), (box2(1,1) + (box2(1,3) - 1))), max((box1(1,2) + (box1(1,4) - 1)), (box2(1,2) + (box2(1,4) - 1)))];
            area_union = (union_coords(1,3) - union_coords(1,1) + 1) * (union_coords(1,4) - union_coords(1,2) + 1);
            overlap = area_intersection / area_union;
            if overlap > 0.5
                if bbox(i,6) >= bbox(j,6)
                    boxes_to_remove = horzcat(boxes_to_remove, [j]);
                end
            end
        end
    end
    for k=1:size(bbox,1)
        if bbox(k,6) <= 0
            boxes_to_remove = horzcat(boxes_to_remove, [k]);
        end
    end
    bbox(boxes_to_remove, :) = [];
    frame_num = sprintf('%04d', f);
    name = strcat('clip3/', 'bbox/', 'clip3_', frame_num, '_bbox');
    save(name, 'bbox');
end