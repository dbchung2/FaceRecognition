function I2 = crop_face(img, mat)

% this is a very simple tracking algo
% for more serious tracking, look-up the papers in the projects pdf
ori_img = imread(img);
mat =load(mat);
% o contain cordinate for left eye, right eye, nose and mouth.
for i = 1:4
    x(i) = mat.x(i);
    y(i) = mat.x(i);
end

topleft(1) =  x(1) - 1.3.*(x(2) - x(1))./2;  
topleft(2) =  y(1) - 3.*( y(3) - y(1));


bottomright(1) =  x(2) + 1.3.*(x(2) - x(1))./2;
bottomright(2) = y(4) + 80;

I2 = imcrop(ori_img,[topleft(1) topleft(2) bottomright(1)-topleft(1) bottomright(2)-topleft(2)]); 