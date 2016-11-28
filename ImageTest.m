figure(1)
clf;

im1 = imread('Screen1.jpg');
im2 = imread('Screen2.jpg');
im1=im2double(im1);
im2=im2double(im2);

subplot(2, 3, 1);
imshow( im1 );

subplot(2, 3, 3);
imshow( im2 );

subplot(2, 3, 2);
im1G = rgb2gray( im1 );
imshow( im1G )

subplot(2, 3, 4);
im2G = rgb2gray( im2 );
imshow( im2G )

im1E = edge( imresize( im1G, 0.1 ), 'Canny' );
im2E = edge( imresize( im2G, 0.1 ), 'Canny' );
im1E = edge( imresize( im1G, 0.2 ), 'Canny',  [], 'both', 5 );

subplot(2, 3, 3);
imshow( im1E )

subplot(2, 3, 6);
imshow( im2E )

imwrite( im1E, 'Screen1 edge.png');
imwrite( im2E, 'Screen2 edge.png');

figure(2)
clf;
