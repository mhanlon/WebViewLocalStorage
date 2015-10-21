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
    self.rightWebView.UIDelegate = self;
    self.rightWebView.navigationDelegate = self;

    self.leftWebView = [[WKWebView alloc] initWithFrame:self.leftView.frame configuration:config];
    [self.leftView addSubview:self.leftWebView];
    self.leftWebView.UIDelegate = self;
    self.leftWebView.navigationDelegate = self;

//    [self _loadURLRequests];
    [self _loadURLSessions];
    
}

- (void)_loadURLRequests
{
    NSURL* rightURL = [[NSBundle mainBundle] URLForResource:@"right" withExtension:@"html"];
//    NSURL* rightURL = [NSURL URLWithString:@"http://your.website.example.com/right.html"];
    NSURL* leftURL = [[NSBundle mainBundle] URLForResource:@"left" withExtension:@"html"];
//    NSURL* leftURL = [NSURL URLWithString:@"http://your.website.example.com/left.html"];

    
    NSURLRequest* rightURLRequest = [NSURLRequest requestWithURL:rightURL];
    [self.rightWebView loadRequest:rightURLRequest];
    
    
    NSURLRequest* leftURLRequest = [NSURLRequest requestWithURL:leftURL];
    [self.leftWebView loadRequest:leftURLRequest];
}

- (void)_loadURLSessions
{
    NSURLSession *session = [NSURLSession sharedSession];

    NSURL* rightURL = [[NSBundle mainBundle] URLForResource:@"right" withExtension:@"html"];
//    NSURL* rightURL = [NSURL URLWithString:@"http://your.website.example.com/right.html"];
    NSURL* leftURL = [[NSBundle mainBundle] URLForResource:@"left" withExtension:@"html"];
//    NSURL* leftURL = [NSURL URLWithString:@"http://your.website.example.com/left.html"];

    NSURLSessionDataTask *rightTask = [session dataTaskWithURL:rightURL
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSString* htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                [self.rightWebView loadHTMLString:htmlString baseURL:rightURL];
                                            }];
    [rightTask resume];
    
    NSURLSessionDataTask *leftTask = [session dataTaskWithURL:leftURL
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            NSString* htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                            [self.leftWebView loadHTMLString:htmlString baseURL:leftURL];
                                        }];
    [leftTask resume];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"Running panel with message: %@", message);
    completionHandler();
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
