//
//  BUCustomViewController.h
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUVerticalAlignLabel.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "AFTabBarViewController.h"
#import "BURequest.h"
#import "BUCustomNoNetworkView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackAction)(void);

@interface BUCustomViewController : UIViewController<UIAlertViewDelegate>
{
    BUVerticalAlignLabel* m_pNameLabel;        //页面红条上标题
    UIButton* m_pBackButton;                   //返回按钮
    UIView* m_pTopBar;                         //顶条
    UIView *m_pLineView;
    UIAlertView *showErrorAlert;
    UILabel *m_pFlagMsgV;    ///标签信息视图
    
    MBProgressHUD *m_pProgressHUD;    ///数据加载进度标示
    UIImageView * m_pLoadingView;
};

@property(nonatomic,copy)BackAction propBackAction;

//返回或关闭
-(void)Back;

/**
 *  push到下一级级子控制器
 *
 *  @param pController 子控制器对象
 */
-(void)PushChildViewController:(UIViewController*)pController;

/**
 *  接收到通知后，push到下一级子控制器
 *
 *  @param pController 子控制器对象
 */
-(void)NotifyPushChildViewController:(UIViewController*)pController;

/**
 *  显示数据加载进度标示(有加载指示器)
 *
 * @param argMessage 提示信息
 */
- (void)ShowProgressHUDWithMessage:(NSString *)argMessage;

/**
 *  显示加载结果信息(没有加载指示器)
 *
 *  @param argMessage 提示信息
 */
- (void)ShowHUDWithMessage:(NSString *)argMessage;

/**
 *  隐藏数据加载进度标示
 */
- (void)HideProgressHUD;

/**
 *  网络状态 1 有网络  0没有网络
 */
- (void)UploadNetwork:(NSInteger )argType;


-(void)DisplayServerUpdatingView:(BOOL)argDisplay;

-(void)DisplayOfflineView;


-(void)ReloadData;


- (void)AddScreenLeftEdgePanGestureRecognizer:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
