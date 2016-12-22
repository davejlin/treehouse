//
//  FotoFunCollectionViewCell.m
//  FotoFun
//
//  Created by Lin David, US-205 on 11/4/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import "FotoFunCollectionViewCell.h"
#import "FotoFunPhotoController.h"

@implementation FotoFunCollectionViewCell

-(void)setPhotoData:(NSDictionary *)photoData{
    _photoData = photoData;
    NSString *size = @"100x100";
    [FotoFunPhotoController imageForPhoto:photoData size:size completion:^(UIImage *image) {
        self.photoView.image = image;
    }];
}

@end
