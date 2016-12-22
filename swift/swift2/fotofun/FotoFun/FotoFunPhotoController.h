//
//  FotoFunPhotoController.h
//  FotoFun
//
//  Created by Lin David, US-205 on 11/5/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SAMCache/SAMCache.h>

@interface FotoFunPhotoController : NSObject

+(void)imageForPhoto:(NSDictionary*)photo size:(NSString*)size completion:(void(^)(UIImage *image))completion;

@end
