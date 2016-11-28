%Function to test if the points calculated in move_points are calculated
%correctly 
function [] = test_M(ptsCyl, M_array)
cylinder_transformed_one = M_array * ptsCyl;
cylinder_transformed_two = (M_array')*cylinder_transformed_one; 
for j = 1:4 
    for i= 1:4  
    test_value = (abs(cylinder_transformed_one(i,j)- cylinder_transformed_two(i,j)))/16; 
    end
end 
%Outputs values according to the distance between the true values of the
%arrays 
    if test_value < 0.05
        disp('The arrays are close') 
    else 
        disp('The arrays are not close') 
    end  
end 