//
//  XFViewController.m
//  qr
//
//  Created by 朱晓峰 on 16/9/16.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XFQRCodeScanner.h"
#import <AVFoundation/AVFoundation.h>

#define  ScreenWidth self.view.frame.size.width
//#define <#macro#>
@interface XFQRCodeScanner ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)AVCaptureSession *captureSession;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer * videoPreviewLayer;
@property(nonatomic,strong)UIImageView * animationLineView;
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation XFQRCodeScanner

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self buildNavigationItem];
    [self buildInputAVCaptureDevice];
    [self buildFrameImageView];
    [self titlelable];
    [self buildAnimationLineView];
}
-(void)buildAnimationLineView{
    self.animationLineView=[[UIImageView alloc]init];
    self.animationLineView.image =[UIImage imageNamed:@"yellowlight"];
    [self.view addSubview:self.animationLineView];
    
    self.timer =[NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(startYellowViewAnimation) userInfo:nil repeats:YES] ;
    NSRunLoop * runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}
-(void)startYellowViewAnimation{
//    __weak  weakSelf = self;
    
    self.animationLineView.frame = CGRectMake(ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, 100, ScreenWidth * 0.5, 20);
    [UIView animateWithDuration:2.5 animations:^{
        self.animationLineView.frame = CGRectMake(ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, 300, ScreenWidth * 0.5, 20);
    }];
//    UIView animateWithDuration(2.5) { () -> Void in
//        weakSelf!.animationLineView.frame.origin.y += ScreenWidth * 0.55
}
-(void)buildFrameImageView{
    [self buildTransparentView];
    [self buildLineView];
    
   
    
    CGFloat yellowHeight= 4;
    CGFloat yellowWidth =30;
    CGFloat yellowX= ScreenWidth * 0.2;
    CGFloat bottomY = 100 + ScreenWidth * 0.6;
    [self buildYellowLineView:CGRectMake(yellowX, 100, yellowWidth, yellowHeight)];
    [self buildYellowLineView:CGRectMake(yellowX, 100, yellowHeight, yellowWidth)];
    
    [self buildYellowLineView:CGRectMake(ScreenWidth * 0.8 - yellowHeight, 100, yellowHeight, yellowWidth)];
    [self buildYellowLineView:CGRectMake(ScreenWidth * 0.8 - yellowWidth, 100, yellowWidth, yellowHeight)];
    [self buildYellowLineView:CGRectMake(yellowX, bottomY - yellowHeight + 2, yellowWidth, yellowHeight)];
    [self buildYellowLineView:CGRectMake(ScreenWidth * 0.8 - yellowWidth, bottomY - yellowHeight + 2, yellowWidth, yellowHeight)];
    [self buildYellowLineView:CGRectMake(yellowX, bottomY - yellowWidth, yellowHeight, yellowWidth)];
    [self buildYellowLineView:CGRectMake(ScreenWidth * 0.8 - yellowHeight, bottomY - yellowWidth, yellowHeight, yellowWidth)];
    
    
    
    
}
-(void)buildYellowLineView:(CGRect)frame{
    UIView * yellowView = [[UIView alloc]initWithFrame:frame];
    yellowView.backgroundColor = [UIColor colorWithRed:253/255 green:212/255 blue:49/255 alpha:1];
    [self.view addSubview:yellowView];

}
-(void)titlelable{
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.font =[UIFont systemFontOfSize:14];
    
    self.titleLable.frame = CGRectMake(0, 340, ScreenWidth, 30);
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLable];

}
-(void)buildLineView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2, 100, ScreenWidth * 0.6, 2)];
    view.backgroundColor=[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:1];
    [self.view addSubview:view];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2, 100, 2, ScreenWidth * 0.6)];
    view1.backgroundColor=[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:1];
    [self.view addSubview:view1];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.8 - 2, 100, 2, ScreenWidth * 0.6)];
    view2.backgroundColor=[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:1];
    [self.view addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.2, 100 + ScreenWidth * 0.6, ScreenWidth * 0.6, 2)];
    view3.backgroundColor=[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:1];
    [self.view addSubview:view3];
}
-(void)buildTransparentView{
    UIView *tView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    tView.backgroundColor=[UIColor blackColor];
    tView.alpha = 0.5;
    
    [self.view addSubview:tView];
    
    UIView *tView1=[[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width * 0.2, self.view.frame.size.width * 0.6)];
    tView1.backgroundColor=[UIColor blackColor];
    tView1.alpha = 0.5;
    
    [self.view addSubview:tView1];
    UIView *tView2=[[UIView alloc]initWithFrame:CGRectMake(0, 100 + self.view.frame.size.width * 0.6, self.view.frame.size.width, self.view.frame.size.height - 100 - self.view.frame.size.width * 0.6)];
    tView2.backgroundColor=[UIColor blackColor];
    tView2.alpha = 0.5;
    
    [self.view addSubview:tView2];
    UIView *tView3=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.8, 100, self.view.frame.size.width * 0.2, self.view.frame.size.width * 0.6)];
    tView3.backgroundColor=[UIColor blackColor];
    tView3.alpha = 0.5;
    
    [self.view addSubview:tView3];
    
}
-(void)buildInputAVCaptureDevice{
    AVCaptureDevice *captureDevice=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.titleLable.text=@"将店铺二维码对准方块内既可收藏店铺";
//    let input = try? AVCaptureDeviceInput(device: captureDevice)
    AVCaptureDeviceInput *input=[AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    if (input == nil) {
        self.titleLable.text = @"没有监测到可用的设备";
        
        return;
    }
    AVCaptureMetadataOutput *captureMetadataOutput=[[AVCaptureMetadataOutput alloc]init];
    self.captureSession=[[AVCaptureSession alloc]init];
    [self.captureSession addInput:input];
    [self.captureSession addOutput:captureMetadataOutput];
    dispatch_queue_t dispatchQueue=dispatch_queue_create("myQueue", nil);

    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    captureMetadataOutput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];

    self.videoPreviewLayer=[AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.videoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.frame=self.view.frame;
    [self.view.layer addSublayer:self.videoPreviewLayer];
    
    captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1);
    [self.captureSession startRunning];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer!=nil) {
        [self.timer invalidate];
        self.timer=nil;
    }
}
-(void)buildNavigationItem{
    self.title=@"二维码";
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:249/255 green:250/255 blue:243/255 alpha:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
