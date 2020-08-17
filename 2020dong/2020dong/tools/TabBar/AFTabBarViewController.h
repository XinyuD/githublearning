//
//  MainViewController.h
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFTabBarItem.h"

#define kTitleNormalColor [UIColor blackColor]
#define kTitleSelectedColo [UIColor blueColor]
#define kTitleFont [UIFont systemFontOfSize:13.0f]

@interface AFTabBarViewController : UITabBarController

//控制器映射Class的集合（必设）
@property(nonatomic,strong)NSArray *propViewControllerClasses;
//分栏背景图片（必设）
@property(nonatomic,strong)UIImage *propTabBarBackGroundImage;
//分栏项的普通图片数组（必设）
@property(nonatomic,strong)NSArray *propTabBarNormalImages;
//分栏项的选中图片数组（必设）
@property(nonatomic,strong)NSArray *propTabBarSelectedImages;
//分栏项标题的数组（选设）
@property(nonatomic,strong)NSArray *propTabBarTitles;

//选择要显示的控制器
- (void)SelectControllerIndex:(NSInteger)argIndex;

//根据徽标类型给指定的item赋徽标值
- (void)SetBadgeNum:(NSInteger)argNum withType:(AFBadgeShowType)argType andIndex:(NSInteger)argIndex;

/**
 *  显示分栏项(实质是将分栏条转移到tabbarcontroller的view上)
 */
- (void)ShowTabBar;

/**
 *  隐藏分栏项（实质是将分栏条转移到tabbarcontroller当前所展示的viewcontroller的view上）
 */
- (void)HideTabBar;

@end
