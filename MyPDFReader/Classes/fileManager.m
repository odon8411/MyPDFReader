//
//  fileManager.m
//  MyPDFView
//
//  Created by oudongjia on 12-7-27.
//  Copyright 2012 z. All rights reserved.
//

#import "fileManager.h"


@implementation fileManager

+(void)savePDFFilesToDocuments
{
	NSArray * fileList = [NSArray arrayWithObjects:
						  @"test.pdf",
						  @"TestPage.pdf",
						  @"CET.pdf",
						  @"历年公务员考试试题真题.pdf",
						  @"CET副本",
						  nil];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//在这里获取应用程序Documents文件夹里的文件及文件夹列表
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];

	NSString* documentsDirectory =[documentDir stringByAppendingPathComponent:@"doc"];

	NSError *error;
	if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory]) {
		
		if(![[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error])
			NSLog(@"createDirectoryAtPath ERROR");
	}
	BOOL success;
	NSError *Error = nil;
	
	for(int i=0; i<[fileList count]; i++)
	{
		NSString *path =[documentsDirectory stringByAppendingPathComponent:[fileList objectAtIndex:i]];
		
		if([fileManager fileExistsAtPath:path])//判断是否存在此path
			[fileManager removeItemAtPath:path error:nil];//删除此path文件
		
		if(![fileManager fileExistsAtPath:path])
		{
			
			NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[fileList objectAtIndex:i]];
			success = [fileManager copyItemAtPath:defaultDBPath toPath:path error:&Error];
			if (!success) {
				NSLog(@"Failed to create path4 database file with test:%@",Error);
			} 
			else {
				NSLog(@"save %@ file to documents sucess",[fileList objectAtIndex:i]);
			}

		}	
		
		
	}
}

+(NSMutableArray*)getFileNameList
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//在这里获取应用程序Documents文件夹里的文件及文件夹列表
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	NSString* documentsDirectory =[documentDir stringByAppendingPathComponent:@"doc"];
	
	NSError *error = nil;
	//NSArray *fileList = [[NSArray alloc] init];
	//fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
	NSArray *fileList = [NSArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]];
	NSMutableArray*fileNameArray = [[NSMutableArray alloc] init];
	NSLog(@"fileList count = %d",[fileList count]);
	for (int i = 0; i<[fileList count]; i++) {
		NSLog(@"file name = %@",[fileList objectAtIndex:i]);
		[fileNameArray addObject:[fileList objectAtIndex:i]];
	}
	return fileNameArray;
}

@end
