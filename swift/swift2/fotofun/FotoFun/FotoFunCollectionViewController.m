//
//  FotoFunCollectionViewController.m
//  FotoFun
//
//  Created by Lin David, US-205 on 11/4/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

#import "FotoFunCollectionViewController.h"
#import "FotoFunCollectionViewCell.h"

NSString *const DATA_VERSION_DATE = @"20160627";
NSString *const DATA_FORMAT = @"foursquare";

@interface FotoFunCollectionViewController ()

@end

@implementation FotoFunCollectionViewController

static NSString * const reuseIdentifier = @"FotoFunCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"FotoFun";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [defaults stringForKey:@"accessToken"];
    
    if(self.accessToken == nil){
        [SimpleAuth authorize:@"foursquare-web" completion:^(id responseObject, NSError *error) {
            //NSLog(@"response: %@", responseObject);
            NSString *token = responseObject[@"credentials"][@"token"];
            [defaults setObject:token forKey:@"accessToken"];
            [defaults synchronize];
            
            self.accessToken = token;
            [self refreshFoursquare];
        }];
    } else {
        [self refreshFoursquare];
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)refreshFoursquare{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/users/self/venuelikes/?oauth_token=%@&v=%@&m=%@",self.accessToken, DATA_VERSION_DATE, DATA_FORMAT];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSLog(@"response: %@", response);
//        NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"text: %@", text);
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
//        NSLog(@"responseDict: %@", responseDict);
        
        self.likedArray = [responseDict valueForKeyPath:@"response.venues.items.id"];
        self.venueArray = [[NSMutableArray alloc]init];
        
        for (NSString *venueID in self.likedArray) {
            NSString *urlString = [[NSString alloc]initWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token=%@&v=%@&m=%@", venueID, self.accessToken, DATA_VERSION_DATE, DATA_FORMAT];
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSData *data = [[NSData alloc]initWithContentsOfURL:location];
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                [self.venueArray addObject:responseDict];
                [self refresh];
            }];
            
            [task resume];
        }
        
    }];
    
    [task resume];
}

-(void)refresh{
    if(self.likedArray.count == self.venueArray.count){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showDetail"]){
        NSIndexPath *selectedPath = [self.collectionView indexPathsForSelectedItems][0];
        NSDictionary *photo = self.venueArray[selectedPath.row];
        FotoFunDetailViewController *detailView = segue.destinationViewController;
        detailView.photo = photo;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.venueArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FotoFunCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.photoData = self.venueArray[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
