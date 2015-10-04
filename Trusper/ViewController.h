//
//  ViewController.h
//  Trusper
//
//  Created by Kevin Moy on 10/3/15.
//  Copyright © 2015 Kevin Moy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *mainCollectionView;
    UICollectionViewFlowLayout *layout;
    
}


@end

