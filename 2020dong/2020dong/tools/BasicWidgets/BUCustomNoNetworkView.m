//
//  BUCustomNoNetworkView.m
//  pbuXingLianClient
//
//  Created by 自知之明、 on 2017/10/14.
//  Copyright © 2017年 1bu2bu. All rights reserved.
//

#import "BUCustomNoNetworkView.h"



@interface BUCustomNoNetworkView ()
{
    
}
@end

@implementation BUCustomNoNetworkView

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
    UIImage *pImg = [UIImage imageNamed:@"noNetwork.png"];
    UIImageView *pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80*[AppConfigure GetLengthAdaptRate], pImg.size.width, pImg.size.height)];
    pImageView.image = pImg;
    pImageView.center = CGPointMake(self.center.x, pImageView.center.y );
    [self addSubview:pImageView];
    
    UILabel *pPromptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, pImageView.bottom + 20*[AppConfigure GetLengthAdaptRate], self.width, 20)];
    pPromptLab.text = @"信息加载失败";
    pPromptLab.font = [UIFont fontWithName:@"Arial" size:13];
    pPromptLab.textAlignment = NSTextAlignmentCenter;
    pPromptLab.textColor = UIColorFromHex(0x666666);
    [self addSubview:pPromptLab];
    
    UILabel *pLoadFailedPromptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, pPromptLab.bottom + 12*[AppConfigure GetLengthAdaptRate], self.width, 15)];
    pLoadFailedPromptLab.text = @"请检查您的网络，重新加载吧";
    pLoadFailedPromptLab.textColor = UIColorFromHex(0x999999);
    pLoadFailedPromptLab.textAlignment = NSTextAlignmentCenter;
    pLoadFailedPromptLab.font = [UIFont fontWithName:@"Arial" size:13.0];
    [self addSubview:pLoadFailedPromptLab];
    
    CGFloat fBtnX = (self.width - 90*[AppConfigure GetLengthAdaptRate])/2.0;
    UIButton *pAgainLoadBtn = [[UIButton alloc] initWithFrame:CGRectMake(fBtnX, pLoadFailedPromptLab.bottom + 30*[AppConfigure GetLengthAdaptRate],  90*[AppConfigure GetLengthAdaptRate], 32*[AppConfigure GetLengthAdaptRate])];
    [pAgainLoadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [pAgainLoadBtn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
    pAgainLoadBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    pAgainLoadBtn.layer.borderWidth = 0.5;
    pAgainLoadBtn.layer.borderColor = UIColorFromHex(0xdedede).CGColor;
    [pAgainLoadBtn addTarget:self action:@selector(ReloadNetworkStatus) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pAgainLoadBtn];
}

-(void)ReloadNetworkStatus
{
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(ReloadNetworkStatus)])
    {
        [self.propDelegate ReloadNetworkStatus];
    }
//    [self NetworkMonitoring];
}


@end
