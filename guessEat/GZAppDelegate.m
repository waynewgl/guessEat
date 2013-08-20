//
//  GZAppDelegate.m
//  guessEat
//
//  Created by Guiwei LIN on 8/8/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZAppDelegate.h"
#import "GZGamePageViewController.h"
#import "GZGameSettingController.h"


@implementation GZAppDelegate
@synthesize navigationController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    NSLog(@"test");
    
    
    
    
    
    GZHomeViewController *homepage=[[GZHomeViewController alloc]init];
    homepage.title=@"游戏";

//    GZCollectionViewController *game=[[GZCollectionViewController alloc]init];

//    GZGamePageViewController *gzGamePageViewController = [[GZGamePageViewController alloc]init];
    
//    gzGamePageViewController.title=@"声音";
    
//    UINavigationController *collectionNavigationController = [[UINavigationController alloc]initWithRootViewController:gzGamePageViewController];

    
//    UIViewController *achievement=[[UIViewController alloc]init];
//    achievement.title=@"成就";
    GZGameSettingController *setController=[[GZGameSettingController alloc]init];
    setController.title=@"设置";
    NSArray *viewControllers=@[homepage,setController];
    UITabBarController *tabBarController=[[UITabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers animated:YES];
    
    //use navigation controller to achieve page navigation, but it does not work
    navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    //self.window.rootViewController=navigationController;
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
