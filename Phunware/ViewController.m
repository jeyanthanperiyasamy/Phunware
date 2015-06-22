//
//  ViewController.m
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

#import "ViewController.h"
#import "PhunWareDetailViewController.h"
#import "PhunwareCell.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *phunwareTableView;
@property (retain,nonatomic) NSMutableArray *phunwareData;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Master";
  [self getNetworkData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)getNetworkData{
  
  if (_phunwareData == nil) {
    self.phunwareData = [@[]mutableCopy];
  }
  [_phunwareData removeAllObjects];
  [[PhunWareManager sharedInstance] getPhunWareData:^(PhunwareResult * flapiObject, NSError * error) {
    
    if(flapiObject.phunwareDataList.count>0){
      [_phunwareData addObjectsFromArray:flapiObject.phunwareDataList];
      [self.phunwareTableView reloadData];
      if([UIDevice isiPad]){
        [self.detailViewController updateFlapi:(PhunWareFlapi*)[_phunwareData objectAtIndex:0]];
      }
    }
    
  }];
  
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  // Return the number of sections.
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  // Return the number of rows in the section.
  return _phunwareData.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   PhunwareCell *contentCell = [tableView dequeueReusableCellWithIdentifier: @"PhunwareCell"];
   PhunWareFlapi *instance = (PhunWareFlapi*)[_phunwareData objectAtIndex:indexPath.row];
   contentCell.nameLabel.text = instance.name;
   contentCell.addressLabel.text = instance.address;
   return contentCell;
   
  
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if([UIDevice isiPad]){
    [self.detailViewController updateFlapi:(PhunWareFlapi*)[_phunwareData objectAtIndex:indexPath.row]];
    if(self.detailViewController.masterPopoverController!=nil){
    [self.detailViewController.masterPopoverController dismissPopoverAnimated:YES];
    }
  }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
  if([UIDevice isiPhone]){
    return YES;
  }
  return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"PhunwareSegue"]) {
    NSIndexPath *indexPath = [_phunwareTableView indexPathForSelectedRow];
    PhunWareDetailViewController *destViewController = segue.destinationViewController;
    [destViewController updateFlapi:(PhunWareFlapi*)[_phunwareData objectAtIndex:indexPath.row]];
  }
}

@end
