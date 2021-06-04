
%inputfile = 'cameraman.tif'; 
%inputfile = 'coins.png'; 
%inputfile = 'moon.tif'; 
inputfile = 'liftingbody.png'; 

A = imread(inputfile);
noise_probability = 0.9;
threshold = 9;
[rows,columns,dim] = size(A);
B = imnoise(A,'salt & pepper',noise_probability);
Output=double(B);
for i=5:rows-4
    for j=5:columns-4
        
        
        kernel = 3;
        y = floor(kernel/2);
        while true
            X = B(i-y:i+y,j-y:j+y);
            X=X(:);
            g_med = median(X);
            g_min = min(X);
            g_max = max(X);
        
            if (g_min < g_med && g_med < g_max)
            
                if (g_min < B(i,j) && B(i,j) < g_max)
                    Output(i,j) = B(i,j);
                else
                    Output(i,j) = g_med;
                end
                
                break;
            
            
            else 
            
                kernel = kernel + 2;
                y = floor(kernel/2);
                
                if kernel > threshold
                    Output(i,j) = B(i,j);
                    break;
                end

            end
        end
        
    end
end


Output=uint8(Output);
hold on
figure
imshow(Output)
outstr=strcat('adaptive_output_noiseprobability_',num2str(noise_probability),'_threshold_',num2str(threshold),'_',inputfile);
imwrite(Output,outstr);
title(outstr);

figure
imshow(B)
hold off
