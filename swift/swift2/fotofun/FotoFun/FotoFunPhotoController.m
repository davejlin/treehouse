//
//  FotoFunPhotoController.m
//  FotoFun
//
//  Created by Lin David, US-205 on 11/5/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import "FotoFunPhotoController.h"

@implementation FotoFunPhotoController

+(void)imageForPhoto:(NSDictionary*)photo size:(NSString*)size completion:(void(^)(UIImage *image))completion{
    
    if(photo == nil || size == nil || completion == nil){
        NSLog(@"missing argument for imageForPhoto");
        return;
    }
    
    NSString *prefix = [photo valueForKeyPath:@"response.venue.bestPhoto.prefix"];
    NSString *suffix = [photo valueForKeyPath:@"response.venue.bestPhoto.suffix"];
    NSString *urlString = [[NSString alloc]initWithFormat:@"%@%@%@", prefix, size, suffix];
    
    NSString *key = [urlString stringByReplacingOccurrencesOfString:@"/" withString:@""];
    UIImage *cachedPhoto = [[SAMCache sharedCache] imageForKey:key];
    
    if(cachedPhoto){
        completion(cachedPhoto);
        return;
    }
    
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc]initWithData:data];
        [[SAMCache sharedCache] setImage:image forKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    }];
    
    [task resume];
}

@end
