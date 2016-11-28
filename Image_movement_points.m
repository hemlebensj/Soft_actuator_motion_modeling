%Download the video data and output the image and the X and Y coordinates
%for the clicked points 
%Input the video filename such as 'Last video corresponding to data
%DSC_3857.MOV' and input the number of points you want to determine the
%change in lenght ie. clicking two points for each image and the size is
%the amount of frames the video has 

function [im, X,Y] = Image_movement_points( filename1, number_of_points,size )
 %Import the video data 
 vid=VideoReader(filename1); 
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 %Preallocate the arrays that will be updated with the clicked points location 
 X = zeros(2,length(1:50:801)); 
 Y = X; 
 c = 0;
 figure(1);
 %For loop to collect the image data points 
for i = 1:50:size
 c = c+1;
 frames = read(vid,i);
 %If the frames are not showing the entirety of the image or there is
 %distracting outside image you can uncomment the below line and crop the
 %image 
 %frames = imcrop(frames,i, [800 100 600 1500]);
 %Show the frames to click on 
 imshow(frames);
 [X(:,c),Y(:,c)] = ginput(number_of_points);
 frames = rgb2gray( frames );
 frames = edge( imresize( frames, 0.1 ), 'Canny' );
 %Output the frames that are used 
 imwrite(frames,['Image' int2str(i), '.jpg']);
 im(i)=image(frames);
 %Save the data points in X and Y 
 csvwrite('Chamber one.csv', [X(:,c),Y(:,c)],c);
 %Clear the figure to start over 
 clf
end 
end 