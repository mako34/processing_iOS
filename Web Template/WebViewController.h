//
//  WebViewController.h
//  Web Template
//
//  Created by Kyle Newsome on 11-08-22.
//  Copyright 2011 BitWit.ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
{
    IBOutlet UIWebView *webView;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;

@end
