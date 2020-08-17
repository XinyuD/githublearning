//
//  AppDelegate.m
//  2020dong
//
//  Created by 董融 on 2020/5/22.
//  Copyright © 2020 董融. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstController.h"
#import "SecondController.h"

@interface AppDelegate ()
{
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"fix bug 1.0");
    NSLog(@"dev");
    
    
//    FirstController *vc = [[FirstController alloc] init];
//    UITabBarController *tab = [[UITabBarController alloc] init];
//    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
//    tab.viewControllers = @[nv];
//    tab.tabBarItem.title = @"page1";
   


    if (!self.window)
    {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        
        [self.window makeKeyAndVisible];
    }
    
    
    _mainTc = [[AFTabBarViewController alloc]init];
    _mainTc.propViewControllerClasses = @[[SecondController class]];
//        _mainTc.propTabBarNormalImages = @[@"tabmain.png",@"fjqz_a.png",@"wd_a.png"];
//        _mainTc.propTabBarSelectedImages = @[@"tabmains.png",@"fjqz_b.png",@"wd_b.png"];
    _mainTc.propTabBarTitles = @[@"主页"];
    self.window.rootViewController = _mainTc;
        
    return YES;
}


@end
