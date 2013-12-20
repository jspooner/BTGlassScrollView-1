//
//  ViewController.m
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#define SIMPLE_SAMPLE NO


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BTGlassScrollView *_glassScrollView;
    
    UIScrollView *_viewScroller;
    BTGlassScrollView *_glassScrollView1;
    BTGlassScrollView *_glassScrollView2;
    BTGlassScrollView *_glassScrollView3;
    int _page;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _page = 0;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    
    //navigation bar work
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.title = @"Awesome App";
    
    //background
    self.view.backgroundColor = [UIColor blackColor];
    
#warning Toggle this to see the more complex build of this version
    if (SIMPLE_SAMPLE) {
        //create your custom info views
        UIView *view = [self customView];
        
        _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background3"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:view];
        
        [self.view addSubview:_glassScrollView];
    }else{
        CGFloat blackSideBarWidth = 2;
        
        _viewScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
        [_viewScroller setPagingEnabled:YES];
        [_viewScroller setDelegate:self];
        [_viewScroller setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:_viewScroller];
        
        _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background3"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:[self customView]];
        _glassScrollView2 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background2"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:[self customView]];
        _glassScrollView3 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background"] blurredImage:nil viewDistanceFromBottom:120 foregroundView:[self customView]];
        
        [_viewScroller addSubview:_glassScrollView1];
        [_viewScroller addSubview:_glassScrollView2];
        [_viewScroller addSubview:_glassScrollView3];
        
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    if (!SIMPLE_SAMPLE) {
        int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
        
        CGFloat blackSideBarWidth = 2;
        [_viewScroller setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
        [_viewScroller setContentSize:CGSizeMake(3*_viewScroller.frame.size.width, self.view.frame.size.height)];
        
        [_glassScrollView1 setFrame:self.view.frame];
        [_glassScrollView2 setFrame:self.view.frame];
        [_glassScrollView3 setFrame:self.view.frame];
        
        [_glassScrollView2 setFrame:CGRectOffset(_glassScrollView2.bounds, _viewScroller.frame.size.width, 0)];
        [_glassScrollView3 setFrame:CGRectOffset(_glassScrollView3.bounds, 2*_viewScroller.frame.size.width, 0)];
        
        [_viewScroller setContentOffset:CGPointMake(page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
        _page = page;
    }
}

- (void)viewWillLayoutSubviews
{
    // if the view has navigation bar, this is a great place to realign the top part to allow navigation controller
    // or even the status bar
    if (SIMPLE_SAMPLE) {
        [_glassScrollView setTopLayoutGuideLength:[self.topLayoutGuide length]];
    }else{
        [_glassScrollView1 setTopLayoutGuideLength:[self.topLayoutGuide length]];
        [_glassScrollView2 setTopLayoutGuideLength:[self.topLayoutGuide length]];
        [_glassScrollView3 setTopLayoutGuideLength:[self.topLayoutGuide length]];
    }
}

- (UIView *)customView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 705)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 120)];
    [label setText:[NSString stringWithFormat:@"%i℉",arc4random_uniform(20) + 60]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 1)];
    [view addSubview:label];
    
    UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(5, 140, 310, 125)];
    box1.layer.cornerRadius = 3;
    box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:box1];
    
    UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 270, 310, 300)];
    box2.layer.cornerRadius = 3;
    box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:box2];
    
    UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 575, 310, 125)];
    box3.layer.cornerRadius = 3;
    box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:box3];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 140, 300, 200)];
    [webView setBackgroundColor:[UIColor clearColor]];
    NSString *myHTML = @"<html><body><h1>BTGlassScrollView</h1><p>This is a view for you to either use as-is or modify the source. The view comes loaded with the ability to:</p><ol><li>Create a self contained view replicating the look and feel of one panel of Yahoo! Weather app</li><li>Blur the background image and/or transform them just the right amount without additional code form you</li><li>Customized the animation/blur/height/shadow/etc. with a chagne of a number in the header #define</li></ol><p>I have been a big fan of Yahoo! weather app. I highly respect the work they have done. I wanted to replicate and also generalize the approach for anyone to use and/or study. This was not associated with Yahoo! No source was lifted from Yahoo! So there will be a few subtle differences between BTGlassScrollView and Yahoo! weather app. For example, this view is built to stay under one navigation bar which in turns allows for \"swipe to back\" on iOS7.</p><p>The view is a subclass of a UIView. It contains 2 scrollViews, background and foreground. backgroundScrollView consists of 2 imageviews, normal and blurred. The alpha of the blurred one changes as the background scrolls. And the background scrolls as the foreground scrolls (at a different rate). The foregroundScrollView consists of maskLayers (gradient) and the foregroundView (which is whatever you want it to be). Between foreground and background, 2 shadowsLayer is added on the top and bottom to give a better readability.</p></body></html>";
    [webView loadHTMLString:myHTML baseURL:nil];
    [webView setDelegate:self];
    [view addSubview:webView];
    
    return view;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;
    
    [_glassScrollView setFrame:CGRectMake(_glassScrollView.frame.origin.x, _glassScrollView.frame.origin.y, _glassScrollView.frame.size.width, fittingSize.height)];
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
    _page = (int)floor(ratio);
    NSLog(@"%i",_page);
    if (ratio > -1 && ratio < 1) {
        [_glassScrollView1 scrollHorizontalRatio:-ratio];
    }
    if (ratio > 0 && ratio < 2) {
        [_glassScrollView2 scrollHorizontalRatio:-ratio + 1];
    }
    if (ratio > 1 && ratio < 3) {
        [_glassScrollView3 scrollHorizontalRatio:-ratio + 2];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    BTGlassScrollView *glass = [self currentGlass];
    
    //can probably be optimized better than this
    //this is just a demonstration without optimization
    [_glassScrollView1 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    [_glassScrollView2 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    [_glassScrollView3 scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
}

- (BTGlassScrollView *)currentGlass
{
    BTGlassScrollView *glass;
    switch (_page) {
        case 0:
            glass = _glassScrollView1;
            break;
        case 1:
            glass = _glassScrollView2;
            break;
        case 2:
            glass = _glassScrollView3;
        default:
            break;
    }
    return glass;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewWillAppear:YES];
}

@end
