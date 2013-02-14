//
//  WebViewDelegate.m
//  Web Template
//
//  Created by Kyle Newsome on 11-08-22.
//  Copyright 2011 BitWit.ca. All rights reserved.
//

#import "WebViewDelegate.h"
#import "Web_TemplateAppDelegate.h"
#import "NSData+Base64.h"

@implementation WebViewDelegate

- (BOOL)webView:(UIWebView*)webViewRef shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //we are listening out for links being click
    if (navigationType == UIWebViewNavigationTypeLinkClicked) 
    {
        
        NSURL *URL = [request URL]; //Get the URL
        
        // The [URL scheme] is the "http://" or "ftp://
        // portion, for example, so let's make one up that isn't used
        // at all -> "objc://"
        //
        if ( [[URL scheme] isEqualToString:@"objc"] ) {
            
            //hold a reference to this webview for calling back to the webview later
            webView = webViewRef;
            
            // The [URL host] is the next part of the link
            // so we can use that like a selector
            // "objc://message" will run the 'message' method in this delegate
            SEL method = NSSelectorFromString( [URL host] );
            
            if ([self respondsToSelector:method])
            {
                // if you delay the method just slightly, 
                // you can get the <a> button to change color to
                // your CSS :hover state before the method takes action
                [self performSelector:method withObject:nil afterDelay:0.1f];
            }
            
            return NO;
        }
        
    }
    
   return YES;
}

-(void)message
{
    //Showing a basic pop up alert
    
    NSString *message = [NSString stringWithString:
                         @"You clicked on this test link" ];
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Message From OBJ-C" 
                          message:message 
                          delegate:nil 
                          cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
}

-(void)takePicture
{
    // Set the UIImagePicker, set it to theCamer and set self as the delegate 
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	imagePicker.delegate = self;
    
    // Present the image picker
    id delegate = [[UIApplication sharedApplication] delegate];
	[[delegate viewController] presentModalViewController:imagePicker animated:YES];
    
    [imagePicker release];
    
}

#pragma mark - Image Picker

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get the Image
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //flatten it to NSData as a JPEG, low quality
    NSData *flatImage = UIImageJPEGRepresentation(image, 0.1f);
    
    // convert NSData to a base 64 encoded string
    // NSData+Base64 Category provided by Matt Gallagher
    // http://cocoawithlove.com/2009/06/base64-encoding-options-on-mac-and.html
    //
    NSString *image64 = [flatImage base64EncodedString];
    
    //process the image in javascript to be added to the page
    NSString *js = [NSString stringWithFormat: @"processImage('data:image/jpeg;base64,%@')", image64];
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    //dismiss the image picker
    [picker dismissModalViewControllerAnimated:YES];
	
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //cancel was hit inside of the camera view
    [picker dismissModalViewControllerAnimated:YES];
}

@end
