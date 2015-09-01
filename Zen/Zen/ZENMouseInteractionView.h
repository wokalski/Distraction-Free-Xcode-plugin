//
//  ZENMouseInteractionView.h
//  Zen
//
//  Created by Wojciech Czekalski on 28.07.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZENInterfaceController.h"

@interface ZENMouseInteractionView : NSView

@property (nonatomic, strong, readonly) id<ZENInterfaceController> interfaceController;

- (instancetype)initWithInterfaceController:(id<ZENInterfaceController>)interfaceController;

@end
