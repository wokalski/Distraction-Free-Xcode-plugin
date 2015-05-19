//
//  WCContainerView.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 03.04.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WCContainerView : NSView
@property (nonatomic, weak, readonly) NSViewController *viewController;
- (instancetype)initWithViewController:(NSViewController *)viewController NS_DESIGNATED_INITIALIZER;
@end
