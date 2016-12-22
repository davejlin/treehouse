//
//  FotoFunCollectionViewController.h
//  FotoFun
//
//  Created by Lin David, US-205 on 11/4/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SimpleAuth/SimpleAuth.h>
#import "FotoFunDetailViewController.h"

extern NSString *const DATA_VERSION_DATE;
extern NSString *const DATA_FORMAT;

@interface FotoFunCollectionViewController : UICollectionViewController
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *likedArray;
@property (nonatomic) NSMutableArray *venueArray;
@end
