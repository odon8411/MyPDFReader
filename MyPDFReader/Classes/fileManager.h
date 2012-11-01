//
//  fileManager.h
//  MyPDFView
//
//  Created by oudongjia on 12-7-27.
//  Copyright 2012 z. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface fileManager : NSObject {

}

+(void)savePDFFilesToDocuments;
+(NSMutableArray*)getFileNameList;
@end
