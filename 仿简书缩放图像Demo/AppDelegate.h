//
//  AppDelegate.h
//  仿简书缩放图像Demo
//
//  Created by 随风流年 on 2019/7/15.
//  Copyright © 2019 随风流年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

