//
//  AppDelegate.m
//  MyChat
//
//  Created by Andrea Sponziello on 12/02/2018.
//  Copyright © 2018 Frontiere21 SRL. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatManager.h"
#import "ChatUIManager.h"
#import "ChatUser.h"
#import "ChatAuth.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [ChatManager configure];
    
//    ChatUser *chatuser = [[ChatUser alloc] init];
//    chatuser.firstname = @"John";
//    chatuser.lastname = @"Nashville";
//    chatuser.userId = @"N3zgRVmskMVrYAkEIillIbj8DNB3";
    
    NSString *email = @"john@mycompany.com";
    NSString *password = @"123456";
    [ChatAuth authWithEmail:email password:password completion:^(ChatUser *user, NSError *error) {
        if (error) {
            NSLog(@"Authentication error. %@", error);
        }
        else {
            NSLog(@"Authentication success.");
            ChatManager *chatm = [ChatManager getInstance];
            user.firstname = @"John";
            user.lastname = @"Nash";
            [chatm startWithUser:user];
            UINavigationController *conversationsVC = [[ChatUIManager getInstance] getConversationsViewController];
            self.window.rootViewController = conversationsVC;
            [[ChatManager getInstance] createContactFor:user withCompletionBlock:nil];
        }
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
