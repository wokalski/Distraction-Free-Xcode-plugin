//
//  ZENAndPeace.h
//  Zen
//
//  Created by Wojciech Czekalski on 04.08.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZENInterfaceController.h"
#import "ZENBarsController.h"
#import "ZENEventScheduler.h"

@interface ZENAndPeace : NSObject <ZENInterfaceController>

@property (nonatomic, strong, readonly) ZENBarsController *barsController;
@property (nonatomic, strong, readonly) ZENEventScheduler *eventScheduler;

- (instancetype)initWithBarsController:(ZENBarsController *)barsController;

@end
