clear
clc
number=2;
%dirname=['../clip_' num2str(number)];
dirname='E:\new 420\project1\clip_1';
d=dir([dirname '/*.jpg']);
for i=1:65%length(d)
    d(i).name=[dirname '/' d(i).name];
end
for i=1:length(d)
    im=imread(d(i).name);
    imgray=rgb2gray(im);
    th=graythresh(imgray);
    data(i,1).img=imresize(im,.3);
    data(i,1).edge=imresize(im2bw(imgray,th),.4);
end
for i=1:length(data)-1
    hn1 = imhist(data(i,1).edge)./numel(data(i,1).edge);
    hn2 = imhist(data(i+1,1).edge)./numel(data(i+1,1).edge);
    m(i) = sum((hn1 - hn2).^2);
    
   % temp = data(i,1).edge;
%    temp2 = data(i+1,1).edge;
 %  X=normxcorr2(temp, temp2);
 %   m(i)=max(X(:));
    
end

%n=1./m;
n=m;
plot(n),title('Shot detection');
xlabel('frames');
[pks,loc]=findpeaks(n,'MINPEAKHEIGHT',0.01);
for i=1:length(loc)
    figure;
  
        subplot(1,2,1),imshow(data(loc(i)).img),title(num2str(loc(i)));
        subplot(1,2,2),imshow(data(loc(i)+1).img),title(num2str(loc(i)+1))
    
end
