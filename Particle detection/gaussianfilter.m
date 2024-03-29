function corrcoef =  gaussianfilter(im, points, templateSize, SD)

points = points';
n=size(points,2);
corrcoef=zeros(n,1);
halfkernelsize=(templateSize(1)-1)/2;

gfilter=fspecial('gaussian',[templateSize templateSize], SD);
gfilter=gfilter-mean(gfilter(:));

for k=1:n
    TempXLoc =round(points(1,k));
    TempYLoc =round(points(2,k));    
    XLocStart=TempXLoc-halfkernelsize;
    XLocEnd=TempXLoc+halfkernelsize;
    YLocStart=TempYLoc-halfkernelsize;
    YLocEnd=TempYLoc+halfkernelsize;
    if XLocStart > 0 && YLocStart >0    %Check for boundaries:
        if XLocEnd <size(im,2) && YLocEnd <size(im,1)
            TempImagePatch=im(YLocStart:YLocEnd,XLocStart:XLocEnd);
            TempImagePatch=TempImagePatch-mean(TempImagePatch(:));
            corrcoef(k)=sum(sum(gfilter.*TempImagePatch))/sqrt(sum(sum(gfilter.^2))*sum(sum(TempImagePatch.^2)));
            
        else
            corrcoef(k)=0;
        end
    else
        corrcoef(k)=0;
    end
end
end