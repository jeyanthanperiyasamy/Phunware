//
//  PhunWareDetailViewController.m
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

#import "PhunWareDetailViewController.h"
@interface PhunWareDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *phunwareImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UITextView *scheduleTextView;
@end

@implementation PhunWareDetailViewController
{
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Detail";
  [_activityIndicator setHidden:true];
  if([UIDevice isiPhone]){
    [self updateFlapi:_flapiObject];
  }
}

-(void)updateFlapi:(PhunWareFlapi *)flapiObject{
  _flapiObject = flapiObject;
  self.nameLabel.text = _flapiObject.name;
  self.addressTextView.text = _flapiObject.address;
  NSString *scheduleString = @"";
  for (PhunWareSchedule *schedule in _flapiObject.schedule) {
    scheduleString = [NSString stringWithFormat:@"%@%@\n",scheduleString,[self convertDateTimeToCurrentTimeZone:schedule.start_date]];
  }
  self.scheduleTextView.text = scheduleString;
  [self phunwareImageDownloader];
}

- (NSString *)convertDateTimeToCurrentTimeZone:(NSString *)dateTimeString {
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  
  // Convert the RFC 3339 date time string to an NSDate.
  NSDate *date = [dateFormatter dateFromString:dateTimeString];
  
  NSString *userDateTimeString;
  if (date != nil) {
    // Convert the date object to a user-visible date string.
    NSDateFormatter *userDateFormatter = [[NSDateFormatter alloc] init];
    assert(userDateFormatter != nil);
    
    [userDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [userDateFormatter setTimeStyle:NSDateFormatterLongStyle];
    
    userDateTimeString = [userDateFormatter stringFromDate:date];
  }
  return userDateTimeString;
}

-(void)phunwareImageDownloader{
  self.phunwareImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
  if(_flapiObject.image_url.length>0){
    [_activityIndicator setHidden:false];
    [_activityIndicator startAnimating];
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:_flapiObject.image_url]
                                                        options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
     }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
     [_activityIndicator setHidden:true];
     [_activityIndicator stopAnimating];
     if (image && finished)
       {
       self.phunwareImageView.image = image;
       }
     }];
  }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController
{
  barButtonItem.title = @"Master";
  [self.navigationItem setLeftBarButtonItem:barButtonItem
                                   animated:YES];
  self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  // Called when the view is shown again in the split view, invalidating the button and popover controller.
  [self.navigationItem setLeftBarButtonItem:nil animated:YES];
  self.masterPopoverController = nil;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
