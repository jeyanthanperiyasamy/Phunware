//
//  AppDelegate.m
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PhunWareDetailViewController.h"
@interface AppDelegate ()

@end
#define MAX_IMAGE_CACHE 52428800    // 50 Meg
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  if([UIDevice isiPad]){
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // ViewController *masterViewController = [[ViewController alloc] initWithNibName:@"FileListViewController_iPad" bundle:nil];detailview
    
    ViewController *masterViewController = (ViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    
    PhunWareDetailViewController *detailViewController = (PhunWareDetailViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"detailview"];
   // PhunWareDetailViewController *detailViewController = [[PhunWareDetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    masterViewController.detailViewController = detailViewController;
    
    self.splitViewController = [[UISplitViewController alloc] init];
    self.splitViewController.delegate = detailViewController;
    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    
   // [self.window addSubview:self.splitViewController.view];
    self.window.rootViewController = self.splitViewController;
  }
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  [self purgeImageCacheIfNecessary];
}

- (void)purgeImageCacheIfNecessary {
  // Clear image cache when we reach the max size.
  SDImageCache *imageCache = [SDImageCache sharedImageCache];
  if (MAX_IMAGE_CACHE < [imageCache getSize]) {
    [imageCache clearDisk];
  }
  else {
    [imageCache cleanDisk];  // Remove expired images from the cache.
  }
}
@end
