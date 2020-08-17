//
//  FirstController.m
//  2020dong
//
//  Created by 董融 on 2020/6/24.
//  Copyright © 2020 董融. All rights reserved.
//

#import "FirstController.h"
#import "FirstView.h"
#import "ScreenConfigure.h"

@interface FirstController ()
{
    FirstView *view;
}
@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"page1";
    
    view = [[FirstView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    NSLog(@"device = %@",[ScreenConfigure getDeviceIdentifier]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
