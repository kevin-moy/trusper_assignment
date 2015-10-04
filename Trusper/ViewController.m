//
//  ViewController.m
//  Trusper
//
//  Created by Kevin Moy on 10/3/15.
//  Copyright © 2015 Kevin Moy. All rights reserved.
//

#import "ViewController.h"

static NSString *const baseUrl = @"https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=4cba999f343e0eb30035b1eaf37c6076&format=json&extras=url_m&nojsoncallback=?";

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    layout= [[UICollectionViewFlowLayout alloc] init];
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [mainCollectionView setDataSource:self];
    [mainCollectionView setDelegate:self];
    
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [mainCollectionView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:mainCollectionView];

    [self setupCollectionView];
    [self getFlickrPicture:baseUrl];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)setupCollectionView {
    layout= [[UICollectionViewFlowLayout alloc] init];
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [mainCollectionView setDataSource:self];
    [mainCollectionView setDelegate:self];
    
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [mainCollectionView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:mainCollectionView];
}
- (void)getFlickrPicture: (NSString *)UrlString {
    NSURL *url = [NSURL URLWithString:UrlString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    [manager GET:UrlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictionary = responseObject;
        NSArray *photos = dictionary[@"photos"][@"photo"];
        for (NSDictionary *imageInformation in photos) {
            NSString *imageUrl = imageInformation[@"url_m"];
            
            // Store image info
            NSDictionary *displayInformation = @{@"image":imageUrl,};
            [self.datasourceArray addObject:displayInformation];
        }
        //reload view here
//        jsonFlickrApi(
        //remove the last )
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
    }];
}

#pragma mark - Collection View
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
    return 2;
    }
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        mainCollectionView.frame = self.view.frame;
        return CGSizeMake(17.f, 17.f);
        
    }
    mainCollectionView.frame = self.view.frame;
    return CGSizeMake(192.f, 192.f);
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  
    [mainCollectionView performBatchUpdates:nil completion:nil];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
@end
