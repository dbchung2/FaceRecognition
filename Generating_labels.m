clear
clc
dirname='E:\new 420\project1\clip_3';
mat_ph='E:\new 420\project1\bbox';
orginal_image=dir([dirname '/*.jpg']);
mat_list=dir([mat_ph '/*.mat']);
for j=1:length(orginal_image)
    img_name = orginal_image(j).name;
    img_path = strcat('E:\new 420\project1\clip_3\',orginal_image(j).name);
    img = imread(img_path);
    mat_path = strcat('E:\new 420\project1\bbox\',mat_list(j).name);
    % helper that crop the faces
    mat = load(mat_path);
    
    M_FM_facetest(img,mat,img_name);
end