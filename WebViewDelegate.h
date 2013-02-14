//
//  WebViewDelegate.h
//  Web Template
//
//  Created by Kyle Newsome on 11-08-22.
//  Copyright 2011 BitWit.ca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebViewDelegate : NSObject 
<UIWebViewDelegate,
UIImagePickerControllerDelegate> //we will also be using the UIImagePicker in this class
{
    UIWebView *webView;
}

@end
