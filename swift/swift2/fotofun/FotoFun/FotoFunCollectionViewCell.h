//
//  FotoFunCollectionViewCell.h
//  FotoFun
//
//  Created by Lin David, US-205 on 11/4/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SAMCache/SAMCache.h>

@interface FotoFunCollectionViewCell : UICollectionViewCell
@property (nonnull) IBOutlet UIImageView *photoView;
@property (nonnull, nonatomic) NSDictionary *photoData;
@end
