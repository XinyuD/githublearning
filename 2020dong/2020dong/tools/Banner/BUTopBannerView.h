//
//  BUTopBannerView.h
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUTopBannerViewDelegate <NSObject>

- (void)ToViewDetails:(id)argData;    ///查看详细情况

@end

@interface BUTopBannerView : UIView <UIScrollViewDelegate>
{
@public
    UIPageControl *m_pPageControl;
@private
    UIScrollView *m_pScrollView;
    UIView *m_pTitleBg;
    UILabel *m_pTitleLable;
    NSMutableArray* m_arrData;
    NSMutableArray *m_arrTitle;
    NSTimer* m_pTimer;
}
@property(nonatomic,weak)id<BUTopBannerViewDelegate> propDel;

-(void)SetData:(NSArray*)arrData andImageUrls:(NSArray*)argImageUrls andTitle:(NSArray *)argTitle;

@end

NS_ASSUME_NONNULL_END
