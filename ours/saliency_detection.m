function sm = saliency_detection(img)
%
%---------------------------------------------------------
% 读取图像并使用 3x3 或 5x5 高斯滤波器对其进行模糊处理
%---------------------------------------------------------
%img = imread('input_image.jpg');%Provide input image path
gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');
%---------------------------------------------------------
% 执行 sRGB 到 CIE Lab 颜色空间转换（使用 D65）
%---------------------------------------------------------
%cform = makecform('srgb2lab', 'whitepoint', whitepoint('d65'));
cform = makecform('srgb2lab');
lab = applycform(gfrgb,cform);
%---------------------------------------------------------
% 计算Lab平均值
%（请注意，在论文中这个平均值是从未模糊的原始图像中找到的，但结果非常相似）
%---------------------------------------------------------
l = double(lab(:,:,1)); lm = mean(mean(l));
a = double(lab(:,:,2)); am = mean(mean(a));
b = double(lab(:,:,3)); bm = mean(mean(b));
%---------------------------------------------------------
% 最后计算显着性图并显示出来。
%---------------------------------------------------------
sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;