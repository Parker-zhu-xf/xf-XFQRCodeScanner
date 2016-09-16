//
//  XFFindQRViewController.m
//  二维码扫描
//
//  Created by 朱晓峰 on 16/9/2.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XFFindQRViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface XFFindQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)NSTimer  *timer;
@property (nonatomic, weak) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;
    @property(nonatomic,strong)UIView * line;
@end
    
@implementation XFFindQRViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2.添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [session addInput:input];
    
    // 3.添加输出数据(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest=CGRectMake((self.view.frame.size.height-200)/2.0/self.view.frame.size.height,(self.view.frame.size.width-200)/2.0/self.view.frame.size.width,1-(self.view.frame.size.height-200)/2.0/self.view.frame.size.height,1-(self.view.frame.size.width-200)/2.0/self.view.frame.size.width);
    NSLog(@"%@",NSStringFromCGRect(output.rectOfInterest));
    [session addOutput:output];
    
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
    // 5.开始扫描
    [session startRunning];
    UIView *view0=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0-100)];
    view0.backgroundColor=[UIColor blackColor];
    view0.alpha=0.3;
    [self.view addSubview:view0];

    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view0.frame), self.view.frame.size.width/2.0-100,200)];
    view1.backgroundColor=[UIColor blackColor];
    view1.alpha=0.3;
    [self.view addSubview:view1];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake( self.view.frame.size.width/2.0+100, CGRectGetMaxY(view0.frame), (self.view.frame.size.width-200)/2.0, 200)];
    view2.backgroundColor=[UIColor blackColor];
    view2.alpha=0.3;
    [self.view addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2.0+100, self.view.frame.size.width, self.view.frame.size.height/2.0-100)];
    view3.backgroundColor=[UIColor blackColor];
    view3.alpha=0.3;
    [self.view addSubview:view3];
    
    self.line=[[UIView alloc]init];
    self.line.frame=CGRectMake(self.view.frame.size.width/2.0-100, self.view.frame.size.height/2.0-100, 200, 5);
    self.line.backgroundColor=[UIColor darkGrayColor];
    [self.view addSubview:self.line];
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(mation) userInfo:nil repeats:YES];
//    [self.timer fire];
    
}
-(void)mation{
    [UIView animateWithDuration:3.0 animations:^{
        self.line.frame=CGRectMake(self.view.frame.size.width/2.0-100, self.view.frame.size.height/2.0+100, 200, 5);
    }completion:^(BOOL finished) {
        self.line.frame=CGRectMake(self.view.frame.size.width/2.0-100, self.view.frame.size.height/2.0-100, 200, 5);
    }];
}
#pragma mark - 实现output的回调方法
// 当扫描到数据时就会执行该方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        
        
        // 停止扫描
        [self.session stopRunning];
        
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
        [self.timer invalidate];
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        UIWebView *webview=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:object.stringValue]]];
        [self.view addSubview:webview];
        
    } else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
