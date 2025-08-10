    [file_name file_path] = uigetfile ({'Test/*.png'});
            if file_path ~= 0
                filename = [file_path,file_name];                
               % facerec (filename,myDatabase,minmax);  
                
            end
            a = imread(filename);
      

 
 
 I=a;
try
    I = rgb2gray(I);   

end


pout_imadjust = imadjust(I);

pout=imhist(pout_imadjust);

imwrite(pout_imadjust,'10.pgm')