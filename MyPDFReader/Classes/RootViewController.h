//
//  RootViewController.h
//  MyPDFReader
//
//  Created by oudongjia on 12-7-30.
//  Copyright 2012 z. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "ReaderViewController.h"


#define DEMO_VIEW_CONTROLLER_PUSH TRUE 

@interface RootViewController : UITableViewController<ReaderViewControllerDelegate> {
	
	NSArray *fileNameArray;
	MBProgressHUD*HUD;
	
}

@end
