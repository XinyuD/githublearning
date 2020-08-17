//
//  SecondController.m
//  2020dong
//
//  Created by 董融 on 2020/8/17.
//  Copyright © 2020 董融. All rights reserved.
//

#import "SecondController.h"
#import "SecondView.h"

@interface SecondController ()
{
    SecondView *m_pView;
}
@end

@implementation SecondController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.view bringSubviewToFront:m_pTopBar];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    m_pNameLabel.text = @"Second";
    m_pView = [[SecondView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pView];
}

@end
