//
//  MyPDFReaderAppDelegate.h
//  MyPDFReader
//
//  Created by oudongjia on 12-7-30.
//  Copyright 2012 z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPDFReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

