//
//  ImageScrollView.m
//  my -- 图片缩放2
//
//  Created by 李鑫浩 on 15/6/22.
//  Copyright (c) 2015年 app17. All rights reserved.
//

#import "AFZoomView.h"
#import "UIImageView+AFNetworking.h"
#import "AFTempConverData.h"
#import "UIImageView+WebCache.h"

@interface AFZoomView ()<UIScrollViewDelegate,UIActionSheetDelegate>
{
    UIImageView *m_pImageView;
    UIActivityIndicatorView *m_pActivityIndicatorV;
}

@end

@implementation AFZoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        self.minimumZoomScale = 1.0f;
        self.maximumZoomScale = 3.0f;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = YES;
        self.directionalLockEnabled = YES;
        self.delegate = self;
        //添加单击取消事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelReviewImage)];
        [self addGestureRecognizer:singleTap];
        //添加双击事件
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomInOrOut:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        //约束单击和双击不能同时生效
        [singleTap requireGestureRecognizerToFail:doubleTap];
        //添加长按保存图片事件
        UILongPressGestureRecognizer *pSaveImage = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(SaveImageToAlbum:)];
        [self addGestureRecognizer:pSaveImage];
        //添加图片加载指示器
        m_pActivityIndicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        m_pActivityIndicatorV.frame = CGRectMake(0, 0, 0 , 0);
        m_pActivityIndicatorV.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        [self addSubview:m_pActivityIndicatorV];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    CGRect fScreenBounds = [[UIScreen mainScreen] bounds];
    CGRect fFrame = CGRectMake(frame.origin.x, frame.origin.y, fScreenBounds.size.width, fScreenBounds.size.height);
    [super setFrame:fFrame];
}

#pragma mark -- public method
- (void)ShowZoomViewWithImageView:(UIImageView *)imageView
{
    m_pImageView = imageView;
    [self RestImageViewFrame];
    [self addSubview:imageView];
}

- (void)RestoreViewScale
{
    if (self.zoomScale != 1.0f)
    {
        [self setZoomScale:1.0f animated:NO];
    }
}

- (void)StartLoadImageWithUrl:(NSString *)url
{
    if ([url isEqualToString:@""] || url == nil)
        return;
    if ([url hasPrefix:@"http"])
    {
        [m_pActivityIndicatorV startAnimating];
        __weak typeof(self) weakSelf = self;
        __block typeof(m_pActivityIndicatorV) pActivityIndicatorV = m_pActivityIndicatorV;
        __weak typeof(m_pImageView) weakImageView = m_pImageView;
        
//        [m_pImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
//            
//            weakImageView.image = image;
//            [weakSelf RestImageViewFrame];
//            [pActivityIndicatorV stopAnimating];
//            
//        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, NSError * _Nonnull error) {
//        }];
        [m_pImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            weakImageView.image = image;
            [weakSelf RestImageViewFrame];
            [pActivityIndicatorV stopAnimating];
        }];

    }
    else
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:url]];
        m_pImageView.image = [UIImage imageWithData:data];
        [self RestImageViewFrame];
    }
}

#pragma mark -- private method
- (void)RestImageViewFrame;
{
    CGSize size = (m_pImageView.image) ? m_pImageView.image.size : m_pImageView.frame.size;
    CGSize sAdjustSize = [AFTempConverData GetAfterAdjustSizeWithImageView:m_pImageView];
    CGFloat fWidth = sAdjustSize.width,fHeight = sAdjustSize.height;
    if (size.height / size.width > 2.0f)
    {
        CGFloat yMargin = fHeight > self.frame.size.height ? 0.0f : (self.frame.size.height - fHeight) / 2.0f;
        m_pImageView.frame = CGRectMake((self.frame.size.width - fWidth) / 2.0f, yMargin, fWidth, fHeight);
        if (yMargin == 0.0f)
        {
            [self setZoomScale:3.0f animated:NO];
            [self setZoomScale:1.0f animated:NO];
            [self setContentOffset:CGPointMake(self.contentOffset.x, 0.0f)];
        }
    }
    else
    {
        if (size.width / size.height > 2.0f && size.width > self.frame.size.width)
        {
            self.maximumZoomScale = self.frame.size.height / fHeight;
        }
        m_pImageView.frame = CGRectMake((self.frame.size.width - fWidth) / 2.0f, (self.frame.size.height - fHeight) / 2.0f, fWidth, fHeight);
    }
}

#pragma mark -- UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return m_pImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = self.frame.size.width - self.contentInset.left - self.contentInset.right;
    CGFloat Hs = self.frame.size.height - self.contentInset.top - self.contentInset.bottom;
    CGFloat W = m_pImageView.frame.size.width;
    CGFloat H = m_pImageView.frame.size.height;
    
    CGRect rct = m_pImageView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    m_pImageView.frame = rct;
}

#pragma mark -- long press gesture method
- (void)SaveImageToAlbum:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet *pActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片到相册", nil];
        [pActionSheet showInView:self];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(m_pImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save the picture is blocked" message:[NSString stringWithFormat:@"Please go to system->“Settings”->“privacy”->“pictures” open access of “%@”",appName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Has been saved to the photo library"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] ;
        [alertView show];
    }
}

#pragma mark -- single tap gesture method
- (void)CancelReviewImage
{
    self.backgroundColor = [UIColor clearColor];
    self.CancleShow();
}

#pragma mark -- double tap gesture method
- (void)zoomInOrOut:(UITapGestureRecognizer *)tapGesture
{
    if (self.zoomScale == self.minimumZoomScale)
    {
        CGPoint point = [tapGesture locationInView:self];
        CGFloat fLength = self.maximumZoomScale;
        [self zoomToRect:CGRectMake(point.x - fLength, point.y - fLength , 2 * fLength, 2 * fLength) animated:YES];
    }
    else
    {
        [self setZoomScale:1.0f animated:YES];
    }
}

@end
