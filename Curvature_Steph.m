%Download the video data and output the image and the X and Y coordinates
%for the clicked points 
%Input the video filename such as 'Last video corresponding to data
%DSC_3857.MOV' and input the number of points you want to determine the
%change in lenght ie. clicking two points for each image 

function [im, X,Y] = Curvature_Steph( filename1, number_of_points )
 %vid=VideoReader('Steph_movie.MOV');
 vid=VideoReader(filename1); 
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 X = zeros(2,length(1:50:801)); 
 Y = X; 
 c = 0;
 figure(1);
%  for i = 1:2
for i = 1:50:801
%  %for i = 1:35:552
 c = c+1;
 frames = read(vid,i);
 %frames = imcrop(frames,i, [800 100 600 1500]); 
%  frames = imcrop(frames,i, [300 100 1000 800]);
 imshow(frames);
 [X(:,c),Y(:,c)] = ginput(number_of_points);
frames = rgb2gray( frames );
 frames = edge( imresize( frames, 0.1 ), 'Canny' );
 imwrite(frames,['Image' int2str(i), '.jpg']);
 im(i)=image(frames);
 csvwrite('Chamber one.csv', [X(:,c),Y(:,c)],c);
 clf
end 
end 