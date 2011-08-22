//
//  Web_TemplateAppDelegate.h
//  Web Template
//
//  Created by Kyle Newsome on 11-08-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Web_TemplateViewController;

@interface Web_TemplateAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Web_TemplateViewController *viewController;

@end
