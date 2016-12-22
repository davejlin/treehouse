//
//  FotoFunDetailViewController.h
//  FotoFun
//
//  Created by Lin David, US-205 on 11/5/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FotoFunCollectionViewController.h"

@interface FotoFunDetailViewController : UIViewController

@property (nonatomic) NSDictionary *photo;
@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UIView *backgroundView;
@property (nonatomic) IBOutlet UIView *centerView;
@property (nonatomic) UITextView *tipView;
@property (nonatomic) NSString *tipString;

@end
