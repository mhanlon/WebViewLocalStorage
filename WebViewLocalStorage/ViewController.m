//
//  ViewController.m
//  WebViewLocalStorage
//
//  Created by Matthew Hanlon on 10/19/15.
//  Copyright © 2015 Q.I. Software. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate, WKUIDelegate>
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *rightView;

@property (strong, nonatomic) IBOutlet WKWebView *leftWebView;
@property (strong, nonatomic) IBOutlet WKWebView *rightWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc] init];
    WKProcessPool* processPool = [[WKProcessPool alloc] init];
    config.processPool = processPool;
    
    self.rightWebView = [[WKWebView alloc] initWithFrame:self.rightView.frame configuration:config];
    [self.rightView addSubview:self.rightWebView];
    
    NSURL* rightURL = [[NSBundle mainBundle] URLForResource:@"right" withExtension:@"html"];
    NSURLRequest* rightURLRequest = [NSURLRequest requestWithURL:rightURL];
    [self.rightWebView loadRequest:rightURLRequest];
    self.rightWebView.UIDelegate = self;
    self.rightWebView.navigationDelegate = self;

    self.leftWebView = [[WKWebView alloc] initWithFrame:self.leftView.frame configuration:config];
    [self.leftView addSubview:self.leftWebView];

    NSURL* leftURL = [[NSBundle mainBundle] URLForResource:@"left" withExtension:@"html"];
    NSURLRequest* leftURLRequest = [NSURLRequest requestWithURL:leftURL];
    [self.leftWebView loadRequest:leftURLRequest];
    self.leftWebView.UIDelegate = self;
    self.leftWebView.navigationDelegate = self;

}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"Running panel with message: %@", message);
    completionHandler();
}


@end
