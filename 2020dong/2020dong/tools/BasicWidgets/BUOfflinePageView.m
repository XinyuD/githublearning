//
//  BUOfflinePageView.m
//  pbuXingLianClient
//
//  Created by Ruixin Wang on 2017/11/24.
//  Copyright © 2017年 1bu2bu. All rights reserved.
//

#import "BUOfflinePageView.h"

@implementation BUOfflinePageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self CreaeSubView];
    }
    return self;
}

#pragma makr - private methods
-(void)CreaeSubView
{
    UIImage *pImg = [UIImage imageNamed:@"offlinepage.png"];
    UIImageView *pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80*[AppConfigure GetLengthAdaptRate], pImg.size.width, pImg.size.height)];
    pImageView.image = pImg;
    pImageView.center = CGPointMake(self.center.x, pImageView.center.y );
    [self addSubview:pImageView];
    
    UILabel *pPromptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, pImageView.bottom + 20*[AppConfigure GetLengthAdaptRate], self.width, 20)];
    pPromptLab.text = @"诶呦，亲，这个内容下线了呢";
    pPromptLab.font = [UIFont fontWithName:@"Arial" size:13];
    pPromptLab.textAlignment = NSTextAlignmentCenter;
    pPromptLab.textColor = UIColorFromHex(0x666666);
    [self addSubview:pPromptLab];
    
}


@end
