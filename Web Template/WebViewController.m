//
//  WebViewController.m
//  Web Template
//
//  Created by Kyle Newsome on 11-08-22.
//  Copyright 2011 BitWit.ca. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewDelegate.h"

@implementation WebViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //First we load up the index.html file
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"exampleMinimus" ofType:@"html"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];

    NSData *htmlData = [NSData dataWithContentsOfFile:path];
    
    //Next we need to set up a proper base URL for our files 
    NSString *resourceURL = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@", resourceURL); // <- the URL in the raw still needs some cleaning
    // Need to be double-slashes to work correctly with UIWebView, so change all "/" to "//"
    resourceURL = [resourceURL stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    // Also need to replace all spaces with "%20"
    resourceURL = [resourceURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    //And make a proper URL
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"file:/%@//",resourceURL]];

    //Finally let's load up the html data and passthe Base URL for the CSS and Javascript files
    [webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
    //The delegate is where we will handle notifications from the UIWebView
    webView.delegate = [[WebViewDelegate alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [webView.delegate release]; //release delegate from memory
    webView.delegate = nil; //set to nil to prevent a bad call
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
