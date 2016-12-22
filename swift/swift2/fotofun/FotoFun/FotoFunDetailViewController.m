//
//  FotoFunDetailViewController.m
//  FotoFun
//
//  Created by Lin David, US-205 on 11/5/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import "FotoFunDetailViewController.h"
#import "FotoFunPhotoController.h"

@interface FotoFunDetailViewController ()

@end

@implementation FotoFunDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *size = @"300x300";
    [FotoFunPhotoController imageForPhoto:self.photo size:size completion:^(UIImage *image){
        self.imageView.image = image;
    }];
    
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.backgroundView addGestureRecognizer:dismiss];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDismiss)];
    [self.view addGestureRecognizer:swipe];
    
    self.centerView.layer.cornerRadius = 10;
    
    [self downloadTips];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swipeToDismiss{
    [UIView animateWithDuration:.75 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)dismiss{
    [UIView animateWithDuration:.75 animations:^{
        self.view.transform = CGAffineTransformMakeScale(.01, .01);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)dismissTips{
    [UIView animateWithDuration:.5 animations:^{
        self.tipView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.tipView removeFromSuperview];
    }];
}

-(void)downloadTips{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSString *venueID = [self.photo valueForKeyPath:@"response.venue.id"];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://api.foursquare.com/v2/venues/%@/tips/?oauth_token=%@&v=%@&m=%@",venueID, accessToken, DATA_VERSION_DATE, DATA_FORMAT];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //NSLog(@"%@",responseDict);
        
        NSArray *tipsArray = [responseDict valueForKeyPath:@"response.tips.items.text"];
        
        //NSLog(@"%@",tipsArray);
        self.tipString = [self formatTips:tipsArray];
    }];
    
    [task resume];
}

-(NSString*)formatTips:(NSArray*)tipsArray{
    NSMutableString *tipString = [[NSMutableString alloc]initWithString:@"Tips:\n\n"];
    
    for(NSString *tip in tipsArray){
        [tipString appendString:[NSString stringWithFormat:@"*%@\n\n", tip]];
    }
    
    return (NSString*)tipString;
}

-(IBAction)presentTipView{
    self.tipView = [[UITextView alloc]initWithFrame:self.centerView.frame];
    self.tipView.backgroundColor = [UIColor orangeColor];
    self.tipView.textColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 10;
    self.tipView.text = self.tipString;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissTips)];
    [self.tipView addGestureRecognizer:tap];
    
    [self.view addSubview:self.tipView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
