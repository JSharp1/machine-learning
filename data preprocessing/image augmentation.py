# Thank you to Vivek Yadav for his super write up
# https://medium.com/self-driving-cars/image-augmentation-bc75fd02a0ff
#augment dings 20 times
import cv2
import numpy as np
import math
import random

PATH = '00000_00001.ppm'
new_size_col,new_size_row = 32, 32

def augment_brightness_camera_images(image):
    image1 = cv2.cvtColor(image,cv2.COLOR_RGB2HSV)
    image1 = np.array(image1, dtype = np.float64)
    random_bright = .5+np.random.uniform()
    image1[:,:,2] = image1[:,:,2]*random_bright 
    image1[:,:,2][image1[:,:,2]>255]  = 255
    image1 = np.array(image1, dtype = np.uint8)
    image1 = cv2.cvtColor(image1,cv2.COLOR_HSV2RGB)
    return image1

def add_random_shadow(image):
    top_y = 320*np.random.uniform()
    top_x = 0
    bot_x = 160
    bot_y = 320*np.random.uniform()
    image_hls = cv2.cvtColor(image,cv2.COLOR_RGB2HLS)
    shadow_mask = 0*image_hls[:,:,1]
    X_m = np.mgrid[0:image.shape[0],0:image.shape[1]][0]
    Y_m = np.mgrid[0:image.shape[0],0:image.shape[1]][1]
    shadow_mask[((X_m-top_x)*(bot_y-top_y) -(bot_x - top_x)*(Y_m-top_y) >=0)]=1
    #random_bright = .25+.7*np.random.uniform()
    if np.random.randint(2)==1:
        random_bright = .5
        cond1 = shadow_mask==1
        cond0 = shadow_mask==0
        if np.random.randint(2)==1:
            image_hls[:,:,1][cond1] = image_hls[:,:,1][cond1]*random_bright
        else:
            image_hls[:,:,1][cond0] = image_hls[:,:,1][cond0]*random_bright    
    image = cv2.cvtColor(image_hls,cv2.COLOR_HLS2RGB)
    return image

def trans_image(image,steer,trans_range):
    # Translation
    tr_x = trans_range*np.random.uniform()-trans_range/2
    steer_ang = steer + tr_x/trans_range*2*.2
    #tr_y = 40*np.random.uniform()-40/2
    tr_y = 0
    rows, cols, channels, = image.shape
    Trans_M = np.float32([[1,0,tr_x],[0,1,tr_y]])
    image_tr = cv2.warpAffine(image,Trans_M,(cols,rows))
    return image_tr,steer_ang

def preprocessImage(image):
    shape = image.shape
    # note: numpy arrays are (row, col)!
    #image = image[math.floor(shape[0]/5):shape[0]-25, 0:shape[1]]
    image = cv2.resize(image,(new_size_col,new_size_row), interpolation=cv2.INTER_AREA)    
    #image = image/255.-.5
    return image

def jitterImage(I):
    """ perturb the image.
    rotating it by between [-15,15],
    Randomly jitter image by scaling it by between [0.85,1.15], 
    change position by [-4,4]
    Args:
        I: input image
    Returns:
        jitteredI: jittered image
    """
    cols = I.shape[1]
    rows = I.shape[0]
    # rotation
    dst = I.copy()
    theta = random.uniform(-15,15)
    R = cv2.getRotationMatrix2D((cols/2,rows/2),theta,1)
    dst = cv2.warpAffine(I,R,(cols,rows),dst,borderMode=cv2.BORDER_TRANSPARENT,flags=cv2.INTER_CUBIC)
    # scale
    fx = random.uniform(0.85,1.15)
    fy = random.uniform(0.85,1.15)
    dst = cv2.resize(dst,(0,0),dst,fx,fy)
    # transformation
    xdisplacement = random.uniform(-4, 4)
    ydisplacement = random.uniform(-4, 4)
    M = np.float32([[1,0,xdisplacement],[0,1,ydisplacement]])
    dst = cv2.warpAffine(dst,R,(cols,rows),dst,borderMode=cv2.BORDER_TRANSPARENT)
    return dst

def clahe(rgbImage):
    """Convert RGB img to YUV color space 
        uses CLAHE to normalise brightness channel (Y) of YUV image.
        N.B opencv will load as BGR.
    Args: 
        rgbImage: raw rgb image
    Returns:
        yuvImage: normalized yuv image
    """
    #convert RGB img to YUV color space
    yuvImage = cv2.cvtColor(rgbImage,cv2.COLOR_BGR2YUV)
    #copy the Y channel
    Y = yuvImage[:,:,0].copy()
    #apply CLACHE method to YUV image and return
    clache = cv2.createCLAHE(clipLimit=1.0,tileGridSize=(8,8))
    yuvImage[:,:,0] = clache.apply(Y)
    rgbImage = cv2.cvtColor(yuvImage,cv2.COLOR_YUV2BGR)
    return rgbImage

def resizeImg(image):
    #resize the image
    ratio = 32.0 / image.shape[1]
    dim = (32, int(image.shape[0] * ratio))
    resized = cv2.resize(image, dim, interpolation=cv2.INTER_NEAREST)
    resized1 = cv2.resize(resized, (32,32)).astype(np.float32); 
    return resized1

def checkAugmentations():
    src = cv2.imread(PATH); cv2.imshow("img", src)
    print src.shape
    aug1 = augment_brightness_camera_images(src); cv2.imshow("brightness", aug1)
    aug2 = add_random_shadow(src); cv2.imshow("shadow", aug2)
    aug3, angle = trans_image(src,20,40); cv2.imshow("translate", aug3)
    aug4 = jitterImage(src); cv2.imshow("jitterImage", aug4)
    aug5 = clahe(src); cv2.imshow("clahe", aug5)
    aug6 = preprocessImage(src); cv2.imshow("resizeImg", aug6)

    # cv2.putText(aug3, str(angle),(0,30), cv2.FONT_HERSHEY_SIMPLEX, 1,(255,255,255),2,cv2.LINE_AA)
    # cv2.imshow("preprocess", preprocessImage(src))
    cv2.waitKey(5000) & 0xFF
    cv2.destroyAllWindows()


def main():
    checkAugmentations()



if __name__ == '__main__':
    main()
