//
//  PhunWareDetailViewController.h
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phunware-Swift.h"
@interface PhunWareDetailViewController : UIViewController<UISplitViewControllerDelegate>
@property (nonatomic,retain)PhunWareFlapi *flapiObject;
-(void)updateFlapi:(PhunWareFlapi *)flapiObject;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end
