//
//  WCXcodeViews.h
//  WCDistractionFreeXcodePlugin
//
//  Created by Wojciech Czekalski on 08.03.2015.
//  Copyright (c) 2015 Wojciech Czekalski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVTCompletingTextView : NSTextView
@end

@interface DVTSourceTextView : DVTCompletingTextView
@end

@interface DVTLayoutView_ML : NSView
@end

@interface IDESourceCodeEditorContainerView : DVTLayoutView_ML
@end

@interface DVTTextSidebarView : NSRulerView
@end

@interface IDENavBar : DVTLayoutView_ML
@end
