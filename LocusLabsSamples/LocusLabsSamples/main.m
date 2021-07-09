//
//  main.m
//  Atrius Personal Wayfinder iOS SDK Samples
//
//  Created by Juan Kruger on 2020/05/08.
//  Copyright © 2021 Atrius, part of Acuity Brands. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
