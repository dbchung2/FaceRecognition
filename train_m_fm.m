clear
clc
dirname='E:\new 420\project1\train_data\female';
neg='E:\new 420\project1\train_data\male';
jpg_list=dir([dirname '/*.jpg']);
mat_list=dir([dirname '/*.mat']);
neg_jpg_list=dir([neg '/*.jpg']);
neg_mat_list=dir([neg '/*.mat']);

%d=dir([dirname '/*.jpg']);
k=1;
for i=1:length(jpg_list)
    img = strcat('E:\new 420\project1\train_data\female\',jpg_list(i).name);
    mat = strcat('E:\new 420\project1\train_data\female\',mat_list(i).name);
    % helper that crop the faces
    d{i} = crop_face(img,mat);
end
for i=1:length(neg_jpg_list)
    img = strcat('E:\new 420\project1\train_data\male\',jpg_list(i).name);
    mat = strcat('E:\new 420\project1\train_data\male\',mat_list(i).name);
    % helper that crop the faces
    d_neg{i} = crop_face(img,mat);
end
cellSize = [8 8];
%hogFeatureSize = length(hog_4x4);
% Pre-allocate trainingFeatures array
    numTrainingImages = size(d,2) + size(d_neg,2);
    
  %  trainingFeatures  = zeros(numTrainingImages,hogFeatureSize,'single');
    trainingLabels(1:length(d),1) = 0;
    trainingLabels(length(d):length(d)+length(d_neg),1) = 1;
   % trainingLabels(index,1)=1;
    % Extract HOG features from each training image. trainingImages
    % contains both positive and negative image samples.
    for i = 1:numTrainingImages
        if i <= length(d)
            img = d{i};
            img=rgb2gray(img);
            img=imresize(img,[64 64]);
            trainingFeatures(i,:) = extractHOGFeatures(img,'CellSize',cellSize);
        end
        if i > length(d)
            t = i - length(d);
            img = d_neg{t};
            img=rgb2gray(img);
            img=imresize(img,[64 64]);
            trainingFeatures(i,:) = extractHOGFeatures(img,'CellSize',cellSize);
        end
    end
   
    % Train a classifier for a digit. Each row of trainingFeatures contains
    % the HOG features extracted for a single training image. The
    % trainingLabels indicate if the features are extracted from positive
    % (true) or negative (false) training images.
    svmt_women_men = svmtrain(trainingFeatures, trainingLabels(:,1));
    testf= trainingFeatures(168,280);
    svmclassify(svmt_women_men, testf);
    name = strcat('E:\new 420\project1\', 'svmt_women_men');
    save(name, 'svmt_women_men');

