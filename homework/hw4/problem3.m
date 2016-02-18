clear all 
close all
raw_im = Tiff('trees.tif','r');
im = raw_im.readRGBAImage();
im = im2double(im(1:200,1:200,:)) ;
imshow(im);


%initialize parameters
K=5
miu=rand(K,3);
new_miu=zeros(K,3);
im_1D = reshape(im, [40000,3]);

diff=zeros(K,40000);
z=ones(K,40000);
z_new=zeros(K,40000);
updateNum=nnz(z_new-z);
iteration=0;

% K means clastering
% end loop when no data is classified to a cluster  different from last loop
while (updateNum~=0)
 
  for i=1:K
    miu2= repmat(miu(i,:),40000,1);
    diff(i,:)=sum( ((im_1D-miu2).^2)');
  end
  z=z_new;
  z_new=zeros(K,40000);
  z_new(find((diff-repmat(min(diff),K,1))==0))=1;
  
  for i=1:K
    new_miu(i,:)= sum(im_1D.*(repmat(z_new(i,:),3,1)'));
  end

  new_miu=new_miu./repmat(sum(z_new')',1,3);
  updateNum=nnz(z_new-z);
  miu=new_miu;
  iteration=iteration+1;
end


 %show the picture after K means clatering
 newImg=0*im_1D;
 for j=1:40000
 for i=1:K
     if z(i,j)==1
         newImg (j,:)= miu(i,:);
     end
 end
 
 end
 img=reshape(newImg,[200,200,3]);
 imshow(img)
 close(raw_im)
