function M_FM_facetest(img,mat,name)
load svmt_women_men;
ori_img = img;
faces  = mat.bbox;
nt  = strsplit(name,'.');
n = nt(1,1);
% how many boxes in one pics
labels(1) = -1;
cellSize = [8 8];
for i=1:size(faces,1)
    x1 = faces(i,1);
    y1 = faces(i,2);
    x2 = faces(i,3);
    y2 = faces(i,4);
    face = imcrop(ori_img, [x1 y1 x2-x1+1 y2-y1+1 ]);
    im=rgb2gray(face);
    im=imresize(im,[64 64]);
    testingFeatures = extractHOGFeatures(im,'CellSize',cellSize);
    label = svmclassify(svmt_women_men, testingFeatures	);
    labels(i)= label;
end
filename = strcat('E:\new 420\project1\labels\clip3\', 'clip3_', char(n), '_labels');
save(filename, 'labels');
end