@interface IDEViewController

// Searches recursively for document provider. Check's every superviews contorller, and at the end checks windowController. Specifically it checks whether it conforms to IDEWorkspaceDocumentProvider.

- (void)_resolveWorkspaceDocumentProvider {

    BOOL isValid = [self isValid];

    if (isValid == NO) {
            _DVTAssertionFailureHandler(self, _cmd, "-[IDEViewController _resolveWorkspaceDocumentProvider]", "/SourceCache/IDEFrameworks/IDEFrameworks-6776/IDEKit/ViewControllers/IDEViewController.m", 0x84, @"self.isValid", @"");
            rbx = self;
    }

    NSView *viewControllerView = [self.view retain];
    superview = [[viewControllerView superview] retain];
    [viewControllerView release];

// If top level view 
    if (superview == nil) {
        if (_workspaceDocumentProvider == nil) {
            NSWindowController *windowController = self.view.window.windowController;
                BOOL windowControllerIsDocumentProvider = [windowController conformsToProtocol:@protocol(IDEWorkspaceDocumentProvider)];
                if (windowControllerIsDocumentProvider == YES) {
                        [self willChangeValueForKey:@"workspaceDocumentProvider"];
                        _workspaceDocumentProvider = windowController;
                        [self didChangeValueForKey:@"workspaceDocumentProvider"];
                }
        }
        return;
    } else if ([self.superview respondsToSelector:@selector(viewController)] == NO) {
        NSView *superViewSuperView = self.view.superview.superview;

        if (superViewSuperView != nil)
        {
            
        }
    }

loc_2486f5:
    rdi = self;
    if (rdi->_workspaceDocumentProvider == 0x0) {
            r13 = *objc_msgSend;
            r12 = [[rdi view] retain];
            r14 = [[r12 window] retain];
            rax = [r14 windowController];
            var_40 = rax;
            rax = [rax retain];
            r15 = *objc_release;
            rdi = r14;
            r14 = rax;
            [rdi release];
            [r12 release];
            rax = [r14 conformsToProtocol:@protocol(IDEWorkspaceDocumentProvider)];
            if (LOBYTE(rax) != 0x0) {
                    r13 = *objc_msgSend;
                    [self willChangeValueForKey:@"workspaceDocumentProvider"];
                    objc_storeStrong(self + *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider, var_40);
                    [self didChangeValueForKey:@"workspaceDocumentProvider"];
            }
            [r14 release];
    }
    rax = [rbx release];
    return;

loc_248615:
    r14 = @selector(viewController);
    r12 = rbx;

loc_24861f:
    rdx = r14;
    rax = [rbx respondsToSelector:rdx];
    if (LOBYTE(rax) == 0x0) goto loc_24866b;
    goto loc_248636;

loc_24866b:
    rbx = [[r12 superview] retain];
    [r12 release];
    r12 = rbx;
    if (rbx != 0x0) goto loc_24861f;
    goto loc_2486f5;

loc_248636:
    r13 = *objc_msgSend;
    r15 = [[rbx viewController] retain];
    rax = [r15 conformsToProtocol:@protocol(IDEWorkspaceDocumentProvider)];
    if (LOBYTE(rax) != 0x0) goto loc_248699;
    goto loc_248662;

loc_248699:
    r13 = *objc_msgSend;
    [self willChangeValueForKey:@"workspaceDocumentProvider"];
    rcx = *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider;
    r12 = *(self + rcx);
    *(self + rcx) = r15;
    r15 = [r15 retain];
    r14 = *objc_release;
    [r12 release];
    [self didChangeValueForKey:@"workspaceDocumentProvider"];
    [r15 release];
    goto loc_2486f5;

loc_248662:
    [r15 release];
    goto loc_24866b;
}