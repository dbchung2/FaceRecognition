function t = track_objects3()

% this is a very simple tracking algo
% for more serious tracking, look-up the papers in the projects pdf
FRAME_DIR = '../../clip_3/';
start_frame = 16;
end_frame = 289;
t = {};
t2 = {};

for i = start_frame:end_frame
    im_cur = imread(fullfile(FRAME_DIR, sprintf('%04d.jpg', i)));
    data = load(sprintf('clip3/bbox/clip3_%04d_bbox.mat', i));
    dets_cur = data.bbox;
    
    im_next = imread(fullfile(FRAME_DIR, sprintf('%04d.jpg', i+1)));
    data = load(sprintf('clip3/bbox/clip3_%04d_bbox.mat', i+1));
    dets_next = data.bbox;
    
    % sim has as many rows as dets_cur and as many columns as dets_next
    % sim(k,t) is similarity between detection k in frame i, and detection
    % t in frame j
    % sim(k,t)=0 means that k and t should probably not be the same track
    sim = compute_similarity(dets_cur, dets_next, im_cur, im_next);
    n = nnz(sim);
    for j=1:n
        x = size(t, 2);
        [M,I] = max(sim(:));
        [I_row, I_col] = ind2sub(size(sim),I);
        sim(I_row, I_col) = 0;
        added = 0;
        for k=1:x
            y = size(t{k}, 1);
            if t{k}(y,1) == I_row
                if t{k}(y,2) == i
                    t{k} = vertcat(t{k}, [I_col, i + 1]);
                    added = 1;
                end
            end
        end
        if added == 0
            t{x+1} = [I_row, i; I_col, i+1];
        end
    end
end;

end


function sim = compute_similarity(dets_cur, dets_next, im_cur, im_next)

n = size(dets_cur, 1);
m = size(dets_next, 1);
sim = zeros(n, m);


area_cur = compute_area(dets_cur);
area_next = compute_area(dets_next);
c_cur = compute_center(dets_cur);
c_next = compute_center(dets_next);
im_cur = double(im_cur);
im_next = double(im_next);
weights = [1,1,2];

for i = 1: n
    % compare sizes of boxes
    a = area_cur(i) * ones(m, 1);
    sim(i, :) = sim(i, :) + weights(1) * (min(area_next, a) ./ max(area_next, a))';
    
    % penalize distance (would be good to look-up flow, but it's slow to
    % compute for images of this size)
    sim(i, :) = sim(i, :) + weights(2) * exp((-0.5*sum((repmat(c_cur(i, :), [size(c_next, 1), 1]) - c_next).^2, 2)) / 5^2)';
    
    % compute similarity of patches
    box = round(dets_cur(i, 1:4));
    box(1:2) = max([1,1],box(1:2));
    box(3:4) = [min(box(3),size(im_cur, 2)), min(box(4),size(im_cur, 1))];
    im_i = im_cur(box(2):box(4),box(1):box(3), :);
    im_i = im_i / norm(im_i(:));
    for j = 1 : m
       d = norm(c_cur(i, :) - c_next(j, :));
       if d>60  % distance between boxes too big
           sim(i,j) = 0;
           continue;
       end;
       box = round(dets_next(j, 1:4));
       box(1:2) = max([1,1],box(1:2));
       box(3:4) = [min(box(3),size(im_cur, 2)), min(box(4),size(im_cur, 1))]; 
       im_j = im_next(box(2):box(4),box(1):box(3), :);
       im_j = double(imresize(uint8(im_j), [size(im_i, 1), size(im_i, 2)]));
       im_j = im_j / norm(im_j(:));
       c = sum(im_i(:) .* im_j(:));
       sim(i,j) = sim(i,j) + weights(3) * c;
    end;
end;
end

function area = compute_area(dets)
   area = (dets(:, 3) - dets(:, 1) + 1).* (dets(:, 4) - dets(:, 2) + 1);
end

function c = compute_center(dets)

c = 0.5 * (dets(:, [1:2]) + dets(:, [3:4]));
end