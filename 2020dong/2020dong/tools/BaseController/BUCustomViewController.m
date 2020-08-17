//
//  BUCustomViewController.m
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import "BUCustomViewController.h"

#import "BUCustomViewController.h"
#import "BUVerticalAlignLabel.h"
#import "BUCoreUtility.h"
#import "BUSystemVersion.h"
#import "AFTabBarViewController.h"

// This category (i.e. class extension) is a workaround to get the
// Image PickerController to appear in landscape mode.
@interface UIImagePickerController(Nonrotating)
{
}
- (BOOL)shouldAutorotate;
@end

@implementation UIImagePickerController(Nonrotating)

- (BOOL)shouldAutorotate
{
    return NO;
}
@end


@interface BUCustomViewController ()
{
    NSString * m_strLeftImageName;
    
    UIAlertView *m_pAlert;
}

@end

@implementation BUCustomViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        m_strLeftImageName = @"navigation_openleft.png";
    }
    return self;
}

-(void)dealloc
{
    [m_pProgressHUD removeFromSuperview];
    m_pProgressHUD = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"释放");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [AppConfigure MainBgColor];
    
    if([AppConfigure iOSVersion]>=7.0)
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    m_pTopBar =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45+[AppConfigure GetYStartPos])];
    m_pTopBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:m_pTopBar];
    
    //Name Lable
    m_pNameLabel = [[BUVerticalAlignLabel alloc] initWithFrame:CGRectMake(70,0+[AppConfigure GetYStartPos], self.view.bounds.size.width - 140, 45)];
    m_pNameLabel.backgroundColor = [UIColor clearColor];
    m_pNameLabel.textAlignment = NSTextAlignmentCenter;
    m_pNameLabel.verticalAlignment = VerticalAlignmentMiddle;
    m_pNameLabel.textColor = [UIColor blackColor];
    [m_pNameLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
    [m_pTopBar addSubview:m_pNameLabel];
    
    //Back button
    m_pBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0+[AppConfigure GetYStartPos] , 55, 44)];
    [m_pBackButton setExclusiveTouch:YES];
    //    [m_pBackButton setTitle:@"返回" forState:UIControlStateNormal];
    [m_pBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    m_pBackButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [m_pBackButton setImage:[BUCoreUtility newImageFromResource:m_strLeftImageName] forState:UIControlStateNormal];
    //    [m_pBackButton setImage:[BUCoreUtility newImageFromResource:@"back_highlight"] forState:UIControlStateHighlighted];
    [m_pBackButton addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [m_pTopBar addSubview:m_pBackButton];
    
    
    m_pLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pTopBar.frame)-0.5, self.view.frame.size.width, 0.5)];
    m_pLineView.backgroundColor = [UIColor colorWithRed:232%256/255.0 green:232%256/255.0 blue:232%256/255.0 alpha:1];
    [self.view addSubview:m_pLineView];
    
    
    
    m_pLoadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 126*[AppConfigure GetLengthAdaptRate], 50*[AppConfigure GetLengthAdaptRate])];
    [m_pLoadingView setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, 335*[AppConfigure GetLengthAdaptRate])];
    [self.view addSubview:m_pLoadingView];
    
//    NSMutableArray * arrImages = [NSMutableArray array];
//    for (int i=0; i<12; i++)
//    {
//        UIImage * pImage = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d.png",i]];
//        [arrImages addObject:pImage];
//    }
//
//    m_pLoadingView.animationImages = arrImages;
//
//    m_pLoadingView.animationDuration = 1.5;
//    m_pLoadingView.animationRepeatCount = 30000;
//    [m_pLoadingView startAnimating];
    
    
}

- (void)viewSafeAreaInsetsDidChange {
    // 补充：顶部的危险区域就是距离刘海10points，（状态栏不隐藏）
    // 也可以不写，系统默认是UIEdgeInsetsMake(10, 0, 34, 0);
    [super viewSafeAreaInsetsDidChange];
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 0, 34, 0);
}

-(void)HiddenLoadingView
{
    m_pLoadingView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:m_pTopBar];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)ReplacedBackButton
{
    m_strLeftImageName = @"navigation_back.png";
}



#pragma mark -- target method

-(void)Back
{
    if (self.propBackAction) {
        self.propBackAction();
    }
}

#pragma mark -- public method

- (void)ShowProgressHUD
{
    if (m_pProgressHUD == nil)
    {
        m_pProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
        [m_pProgressHUD showAnimated:YES];
    }
}

- (void)HideProgressHUD
{
    [m_pProgressHUD hideAnimated:YES];
}

- (void)ShowFlagMessage:(NSString *)argMsg
{
    if (m_pFlagMsgV == nil)
    {
        m_pFlagMsgV = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width - 100 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
        m_pFlagMsgV.center = self.view.center;
        m_pFlagMsgV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
        m_pFlagMsgV.textColor = [UIColor whiteColor];
        m_pFlagMsgV.font = [UIFont fontWithName:@"Arial" size:16.0f];
        m_pFlagMsgV.textAlignment = NSTextAlignmentCenter;
        m_pFlagMsgV.layer.cornerRadius = 10;
        m_pFlagMsgV.layer.masksToBounds = YES;
        m_pFlagMsgV.alpha = 0.0f;
        [self.view addSubview:m_pFlagMsgV];
    }
    m_pFlagMsgV.text = argMsg;
    m_pFlagMsgV.alpha = 1.0f;
    [UIView animateWithDuration:3.0f animations:^{
        self->m_pFlagMsgV.alpha = 0.0f;
    }];
}

-(void) showErrorAlert: (NSError *) error {
    showErrorAlert.message = error.userInfo[@"errorMsg"];
    [showErrorAlert show];
}

-(void) showAlert: (NSString *)msg {
    if ([m_pAlert isVisible])
    {
        return;
    }
    m_pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [m_pAlert show];
}

-(void)StartShowLoading
{
    [m_pLoadingView startAnimating];
}


@end
