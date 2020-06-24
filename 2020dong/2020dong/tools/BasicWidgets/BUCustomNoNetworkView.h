//
//  BUCustomNoNetworkView.h
//  pbuXingLianClient
//
//  Created by 自知之明、 on 2017/10/14.
//  Copyright © 2017年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUCustomNoNetworkViewDelegate <NSObject>

-(void)ReloadNetworkStatus;

@end

@interface BUCustomNoNetworkView : UIView

@property (nonatomic,weak)id<BUCustomNoNetworkViewDelegate> propDelegate;

@end
