# IDEEditorContext

# IDEFileReference

#IDENavigableItem is asked for 

Check under which circumstances _navigableItemForEditingFromArchivedRepresentation:error: fails. Fix it in our created editor context. It fails in `-[IDENavigableItemCoordinator navigableItemFromArchivableRepresentation:forWorkspace:error:]` method. Workspace is nil. 

`IDEEditorContext` returns nil for workspace.

`IDEEdtiorContext` returns nil for `workspace` because it lacks delegate. Oh boy, we're close.

***

`editorArea` is supposed to respond to this message:

`_openEditorOpenSpecifier:editorContext:takeFocus`

What it does basically is that it calls `openEditorOpenSpecifier` on an `IDEEditorContext` if takeFocus is true it calls takeFocus on the editor context.

***

```objc
void * -[IDEEditorContext _navigableItemForEditingFromArchivedRepresentation:error:](void * self, void * _cmd, void * arg2, void * * arg3) {
    rcx = arg3;
    r15 = rcx;
    rbx = self;
    var_30 = rbx;
    var_38 = _cmd;
    r14 = [arg2 retain];
    rdi = rbx->_delegate;
    if (rdi == 0x0) goto loc_8bafa;
    goto loc_8ba75;

loc_8bafa:
    r12 = rbx->_navigableItemCoordinator;
    r13 = *objc_msgSend;
    rbx = [[rbx workspace] retain];
    r13 = [[r12 navigableItemFromArchivableRepresentation:r14 forWorkspace:rbx error:r15] retain];
    [rbx release];
    if (*__navigationLogAspect == 0x0) goto loc_8bb6e;
    goto loc_8bb5a;

loc_8bb6e:
    if (r13 != 0x0) {
            rax = [r13 isValid];
            if (LOBYTE(rax) == 0x0) {
                    rbx = *objc_msgSend;
                    r15 = [NSStringFromClass([r13 class]) retain];
                    var_40 = r15;
                    r12 = [[r13 invalidationBacktrace] retain];
                    rbx = [[r12 stringRepresentation] retain];
                    _DVTAssertionFailureHandler(var_30, var_38, "-[IDEEditorContext _navigableItemForEditingFromArchivedRepresentation:error:]", "/SourceCache/IDEFrameworks/IDEFrameworks-6611/IDEKit/Editor/IDEEditorContext.m", 0x1438, @"[result isValid]", @"Message sent to invalidated object: <%@, %p>.\n\nBacktrace for invalidation:\n %@", r15, r13, rbx);
                    r15 = *objc_release;
                    [rbx release];
                    [r12 release];
                    [var_40 release];
            }
    }
    [var_30->_navigableItem _enableInvalidationBacktraceCapturing];
    [r14 release];
    [r13 autorelease];
    rax = r13;
    return rax;

loc_8bb5a:
    rdi = *__navigationLogAspect;
    if (*(int32_t *)(rdi + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x3) goto loc_8bc81;
    goto loc_8bb6e;

loc_8bc81:
    rsi = @selector(_logAtLogLevel:withFormat:);

loc_8bc8f:
    [rdi _logAtLogLevel:rdx withFormat:rcx];
    goto loc_8bb6e;

loc_8ba75:
    rax = [rdi respondsToSelector:@selector(editorContext:navigableItemForEditingFromArchivedRepresentation:error:)];
    rbx = var_30;
    if (LOBYTE(rax) == 0x0) goto loc_8bafa;
    r13 = [[rbx->_delegate editorContext:rbx navigableItemForEditingFromArchivedRepresentation:r14 error:r15] retain];
    if (*__navigationLogAspect == 0x0) goto loc_8bb6e;
    rdi = *__navigationLogAspect;
    if (*(int32_t *)(rdi + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x3) goto loc_8bca4;
    goto loc_8bada;

loc_8bca4:
    r12 = *_OBJC_IVAR_$_IDEEditorContext._delegate;
    rdi = *__navigationLogAspect;
    [rdi _logAtLogLevel:0x3 withFormat:@"_navigableItemForEditingFromArchivedRepresentation: _delegate:%@"];
    rdi = *__navigationLogAspect;
    if (rdi == 0x0) goto loc_8bb6e;

loc_8bada:
    if (*(int32_t *)(rdi + **OBJC_IVAR_$_DVTLogAspect._logLevel) < 0x3) goto loc_8bb6e;
    rsi = @selector(_logAtLogLevel:withFormat:);
    goto loc_8bc8f;
}
```

```
void -[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:](void * self, void * _cmd, void * arg2, struct CGPoint arg3) {
    var_198 = intrinsic_movsd(var_198, xmm1, arg2, arg3);
    var_1A0 = intrinsic_movsd(var_1A0, xmm0);
    rbx = self;
    var_30 = rbx;
    var_38 = _cmd;
    r15 = [arg2 retain];
    if (rbx == 0x0) {
            LODWORD(r8) = 0xce;
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]", "/SourceCache/IDEPlugins/IDEPlugins-6254/IDESourceEditor/IDESourceCodeNavigationRequest.m", r8, @"((self)) != nil", @"%s should not be nil.", "(self)");
            rbx = var_30;
    }
    rax = [rbx isValid];
    if (LOBYTE(rax) == 0x0) {
            r13 = *objc_msgSend;
            r14 = [NSStringFromClass([var_30 class]) retain];
            r12 = [[var_30 invalidationBacktrace] retain];
            r13 = [[r12 stringRepresentation] retain];
            LODWORD(r8) = 0xce;
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]", "/SourceCache/IDEPlugins/IDEPlugins-6254/IDESourceEditor/IDESourceCodeNavigationRequest.m", r8, @"[self isValid]", @"Message sent to invalidated object: <%@, %p>.\n\nBacktrace for invalidation:\n %@", r14, var_30, r13);
            rbx = *objc_release;
            [r13 release];
            [r12 release];
            [r14 release];
    }
    if (r15 == 0x0) {
            LODWORD(r8) = 0xcf;
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]", "/SourceCache/IDEPlugins/IDEPlugins-6254/IDESourceEditor/IDESourceCodeNavigationRequest.m", r8, @"((expression)) != nil", @"%s should not be nil.", "(expression)");
    }
    rax = var_30;
    rcx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._didStart;
    if (*(int8_t *)(rax + rcx) != 0x0) {
            LODWORD(r8) = 0xd1;
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]", "/SourceCache/IDEPlugins/IDEPlugins-6254/IDESourceEditor/IDESourceCodeNavigationRequest.m", r8, @"!_didStart", @"Navigation request asked to perform navigation twice");
            rax = var_30;
            rcx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._didStart;
    }
    *(int8_t *)(rax + rcx) = 0x1;
    if (r15 == 0x0) {
            LODWORD(r8) = 0xd5;
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]", "/SourceCache/IDEPlugins/IDEPlugins-6254/IDESourceEditor/IDESourceCodeNavigationRequest.m", r8, @"((expression)) != nil", @"%s should not be nil.", "(expression)");
    }
    rax = [r15 location];
    rax = [rax retain];
    rdx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._startLocation;
    rdi = *(var_30 + rdx);
    *(var_30 + rdx) = rax;
    [rdi release];
    rcx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._startPoint;
    xmm0 = intrinsic_movsd(xmm0, var_1A0);
    *(int128_t *)(var_30 + rcx) = intrinsic_movsd(*(int128_t *)(var_30 + rcx), xmm0);
    xmm0 = intrinsic_movsd(xmm0, var_198);
    *(int128_t *)(var_30 + rcx + 0x8) = intrinsic_movsd(*(int128_t *)(var_30 + rcx + 0x8), xmm0);
    rdi = var_30->_performanceMetric;
    if (rdi != 0x0) {
            rdx = @"Starting jump to definition";
            [rdi checkpoint:rdx];
    }
    r14 = [[IDESourceCodeNavigationRequest _navigationLogAspect] retain];
    if ((r14 != 0x0) && (*(int32_t *)(r14 + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x2)) {
            r12 = *OBJC_IVAR_$_DVTLogAspect._logLevel;
            r13 = *objc_msgSend;
            var_198 = [[r15 symbolString] retain];
            rax = [r15 location];
            rax = [rax retain];
            var_1A0 = rax;
            rax = [rax characterRange];
            rbx = [NSStringFromRange(rax) retain];
            r8 = var_198;
            [r14 _logAtLogLevel:0x2 withFormat:@"jumpToDefinitionOfExpression: %@, %@"];
            r13 = *objc_release;
            [rbx release];
            [var_1A0 release];
            [var_198 release];
            if (*(int32_t *)(r14 + *r12) >= 0x3) {
                    r8 = r15;
                    [r14 _logAtLogLevel:0x3 withFormat:@"expression: %@"];
            }
    }
    rbx = *objc_msgSend;
    var_30->_navigationEventBehavior = LODWORD([IDEEditorCoordinator _eventBehaviorForEventType:0x2]);
    var_198 = [[**NSApp currentEvent] retain];
    if ((r14 != 0x0) && (*(int32_t *)(r14 + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x2)) {
            r12 = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._navigationEventBehavior;
            rbx = *objc_msgSend;
            var_1A0 = LODWORD(*(int32_t *)(var_30 + r12));
            var_1A8 = [var_198 clickCount];
            r13 = var_198;
            rax = [var_198 modifierFlags];
            r12 = rbx;
            COND = LODWORD(LODWORD(LODWORD(rax) & 0x80000) >> 0x13) == 0x0;
            rcx = @"YES";
            rbx = @"NO";
            rax = rbx;
            if (!COND) {
                    rax = rcx;
            }
            var_1B0 = rax;
            rax = (r12)(r13, @selector(modifierFlags));
            rcx = r12;
            COND = LODWORD(LODWORD(LODWORD(rax) & 0x100000) >> 0x14) == 0x0;
            rax = rbx;
            r12 = @"YES";
            if (!COND) {
                    rax = r12;
            }
            var_1B8 = rax;
            rdi = r13;
            r13 = rcx;
            COND = LODWORD(LODWORD(LODWORD((r13)(rdi, @selector(modifierFlags))) & 0x40000) >> 0x12) == 0x0;
            rax = rbx;
            if (!COND) {
                    rax = r12;
            }
            var_1C0 = rax;
            if (LODWORD(LODWORD(LODWORD((r13)(var_198, @selector(modifierFlags))) & 0x20000) >> 0x11) != 0x0) {
                    rbx = r12;
            }
            STK29 = rbx;
            LODWORD(r8) = var_1A0;
            rbx = r13;
            (rbx)(r14, @selector(_logAtLogLevel:withFormat:), 0x2, @"Saving navigationg behavior: %u. clickCount: %lu, Option: %@, Cmd: %@, Ctrl: %@, Shift: %@", r8, var_1A8, var_1B0, var_1B8, var_1C0, STK29);
    }
    intrinsic_movsd(xmm0, *0xbfc40, @selector(_indicateProgress));
    (rbx)(var_30, @selector(performSelector:withObject:afterDelay:), @selector(_indicateProgress), 0x0, r8);
    rax = (rbx)(var_30->_sourceEditor, @selector(isExpressionModuleImport:), r15, 0x0, r8);
    if (LOBYTE(rax) != 0x0) {
            if ((r14 != 0x0) && (*(int32_t *)(r14 + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x2)) {
                    [r14 _logAtLogLevel:0x2 withFormat:@"Interpreting expression as an @import statement. Looking up imported files..."];
            }
            r13 = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._sourceEditor;
            var_1A0 = r14;
            r12 = @"(unknown)";
            [r12 retain];
            rax = [*(var_30 + r13) respondsToSelector:@selector(importStringInExpression:)];
            if (LOBYTE(rax) != 0x0) {
                    r12 = [[var_30->_sourceEditor importStringInExpression:r15] retain];
                    [@"(unknown)" release];
            }
            rdi = var_30;
            r13 = rdi->_debugAsyncRequestsLog;
            if (r13 != 0x0) {
                    rbx = *objc_msgSend;
                    r14 = r15;
                    r15 = rbx;
                    rbx = [[NSString stringWithFormat:@"Started _filesForModuleImportExpression: for jumpToDefinition with module: %@", r12] retain];
                    [r13 addObject:rbx];
                    r15 = r14;
                    [rbx release];
                    rdi = var_30;
            }
            var_78 = *_NSConcreteStackBlock;
            var_70 = 0xc2000000;
            var_6C = 0x0;
            var_68 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke;
            var_60 = ___block_descriptor_tmp168;
            r13 = *objc_retain;
            rbx = [rdi retain];
            var_58 = rbx;
            r14 = var_1A0;
            var_50 = [r14 retain];
            var_48 = r12;
            r12 = [r12 retain];
            rax = [r15 retain];
            var_40 = rax;
            rsi = @selector(_filesForModuleImportExpression:completionQueue:completionHandler:);
            rcx = *_dispatch_main_q;
            r8 = var_78;
            rdx = rax;
            [rbx _filesForModuleImportExpression:rdx completionQueue:rcx completionHandler:r8];
            rbx = *objc_release;
            [var_40 release];
            [var_48 release];
            [var_50 release];
            [var_58 release];
            rdi = r12;
    }
    else {
            var_B0 = *_NSConcreteStackBlock;
            var_A8 = 0xc2000000;
            var_A4 = 0x0;
            var_A0 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke171;
            var_98 = ___block_descriptor_tmp185;
            r12 = *objc_retain;
            rbx = [var_30 retain];
            var_90 = rbx;
            r13 = [r14 retain];
            var_88 = r13;
            r12 = [r15 retain];
            var_80 = r12;
            rsi = @selector(_destinationLocationForImportedFileInExpression:inQueue:completionBlock:);
            rcx = *_dispatch_main_q;
            r8 = var_B0;
            rdx = r12;
            rax = [rbx _destinationLocationForImportedFileInExpression:rdx inQueue:rcx completionBlock:r8];
            if (LOBYTE(rax) != 0x0) {
                    if ((r14 != 0x0) && (*(int32_t *)(r13 + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x2)) {
                            rsi = @selector(_logAtLogLevel:withFormat:);
                            LODWORD(rdx) = 0x2;
                            [r13 _logAtLogLevel:rdx withFormat:rcx];
                    }
                    rcx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._debugAsyncRequestsLog;
                    r13 = *(var_30 + rcx);
                    if (r13 != 0x0) {
                            var_1A0 = r15;
                            rbx = *objc_msgSend;
                            r12 = [[r12 symbolString] retain];
                            rcx = r12;
                            r15 = [[NSString stringWithFormat:@"Started _destinationLocationForImportedFileInExpression: for jumpToDefinition with expression: %@", rcx] retain];
                            rsi = @selector(addObject:);
                            rdx = r15;
                            [r13 addObject:rdx];
                            r13 = *objc_release;
                            rdi = r15;
                            r15 = var_1A0;
                            [rdi release];
                            [r12 release];
                    }
            }
            else {
                    if ((r14 != 0x0) && (*(int32_t *)(r13 + **OBJC_IVAR_$_DVTLogAspect._logLevel) >= 0x2)) {
                            rcx = @"Interpreting expression as an index symbol. Looking up occurrences...";
                            [r13 _logAtLogLevel:0x2 withFormat:rcx];
                    }
                    var_1A8 = r13;
                    rdi = var_30;
                    r13 = rdi->_debugAsyncRequestsLog;
                    if (r13 != 0x0) {
                            var_1A0 = NSString;
                            rbx = *objc_msgSend;
                            var_1B0 = [[r12 symbolString] retain];
                            rax = [var_1A0 stringWithFormat:@"Started _symbolOccurrencesForExpression: for jumpToDefinition with expression: %@", rcx];
                            rax = [rax retain];
                            var_1A0 = r14;
                            r14 = r15;
                            r15 = rax;
                            [r13 addObject:r15];
                            rbx = *objc_release;
                            rdi = r15;
                            r15 = r14;
                            r14 = var_1A0;
                            [rdi release];
                            [var_1B0 release];
                            rdi = var_30;
                    }
                    var_E8 = *_NSConcreteStackBlock;
                    var_E0 = 0xc2000000;
                    var_DC = 0x0;
                    var_D8 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke196;
                    var_D0 = ___block_descriptor_tmp209;
                    r13 = *objc_retain;
                    rbx = [rdi retain];
                    var_C8 = rbx;
                    var_C0 = [var_1A8 retain];
                    rax = [r12 retain];
                    var_B8 = rax;
                    rsi = @selector(_symbolOccurrencesForExpression:includeCurrentLoc:onlyCurrentDeclarator:inQueue:completionBlock:);
                    LODWORD(rcx) = 0x0;
                    LODWORD(r8) = 0x0;
                    rdx = rax;
                    (*objc_msgSend)(rbx, rsi);
                    rbx = *objc_release;
                    [var_B8 release];
                    [var_C0 release];
                    [var_C8 release];
            }
            rbx = *objc_release;
            [var_80 release];
            [var_88 release];
            rdi = var_90;
    }
    (rbx)(rdi, rsi, rdx, rcx, r8);
    var_120 = *_NSConcreteStackBlock;
    var_118 = 0xc2000000;
    var_114 = 0x0;
    var_110 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke214;
    var_108 = ___block_descriptor_tmp236;
    rbx = *objc_retain;
    r12 = [var_30 retain];
    var_100 = r12;
    rax = [r14 retain];
    var_1A0 = rax;
    var_F8 = rax;
    rax = [r15 retain];
    r14 = rbx;
    r15 = rax;
    var_F0 = r15;
    rax = [r12 dvt_newObserverForKeyPath:@"readyToJumpToDestination" options:0x3 withHandlerBlock:var_120];
    rdx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._readyToJumpObserverToken;
    rdi = *(var_30 + rdx);
    *(var_30 + rdx) = rax;
    r13 = *objc_release;
    [rdi release];
    var_158 = *_NSConcreteStackBlock;
    var_150 = 0xc2000000;
    var_14C = 0x0;
    var_148 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke241;
    var_140 = ___block_descriptor_tmp250;
    rbx = [var_30 retain];
    var_138 = rbx;
    r12 = [r15 retain];
    var_130 = r12;
    r15 = [var_1A0 retain];
    var_128 = r15;
    rax = [rbx dvt_newObserverForKeyPath:@"readyToDisambiguateOccurrences" options:0x3 withHandlerBlock:var_158];
    rdx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._readyToDisambiguateOccurrencesObserverToken;
    rdi = *(var_30 + rdx);
    *(var_30 + rdx) = rax;
    [rdi release];
    var_190 = *_NSConcreteStackBlock;
    var_188 = 0xc2000000;
    var_184 = 0x0;
    var_180 = ___79-[IDESourceCodeNavigationRequest jumpToDefinitionOfExpression:fromScreenPoint:]_block_invoke253;
    var_178 = ___block_descriptor_tmp260;
    rbx = [var_30 retain];
    var_170 = rbx;
    var_168 = r12;
    var_1A0 = [r12 retain];
    var_160 = r15;
    r15 = [r15 retain];
    rax = [rbx dvt_newObserverForKeyPath:@"readyToDisambiguateHeaderFiles" options:0x3 withHandlerBlock:var_190];
    rdx = *_OBJC_IVAR_$_IDESourceCodeNavigationRequest._readyToDisambiguateHeadersObserverToken;
    rdi = *(var_30 + rdx);
    *(var_30 + rdx) = rax;
    [rdi release];
    [var_160 release];
    [var_168 release];
    [var_170 release];
    [var_128 release];
    [var_130 release];
    [var_138 release];
    [var_F0 release];
    [var_F8 release];
    [var_100 release];
    [r15 release];
    [var_1A0 release];
    rax = [var_198 release];
    return;
}
```

***

##Syntaxt highlighting

The one which doesn't highlight anything doesn't include IDEIndex here, why?
Because IDESourceCodeEditor.workspace is nil, why?


```
(lldb) po [$rdi valueForKey:@"_syntaxColoringContext"]
{
    IDESourceCodeEditor = "<IDESourceCodeEditor: 0x1161129c0 representing: <DVTExtension 0x6080008b44c0: Source Code Document (Xcode.IDEKit.EditorDocument.SourceCode) v0.2>>";
}
```

```
void -[IDEViewController _resolveWorkspaceDocumentProvider](void * self, void * _cmd) {
    rbx = self;
    var_30 = rbx;
    var_38 = _cmd;
    rax = [self isValid];
    if (LOBYTE(rax) == 0x0) {
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDEViewController _resolveWorkspaceDocumentProvider]", "/SourceCache/IDEFrameworks/IDEFrameworks-6776/IDEKit/ViewControllers/IDEViewController.m", 0x84, @"self.isValid", @"");
            rbx = var_30;
    }
    r13 = *objc_msgSend;
    r14 = [[rbx view] retain];
    rbx = [[r14 superview] retain];
    [r14 release];
    if (rbx == 0x0) goto loc_2486f5;
    goto loc_248615;

loc_2486f5:
    rdi = var_30;
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
                    [var_30 willChangeValueForKey:@"workspaceDocumentProvider"];
                    objc_storeStrong(var_30 + *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider, var_40);
                    [var_30 didChangeValueForKey:@"workspaceDocumentProvider"];
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
    [var_30 willChangeValueForKey:@"workspaceDocumentProvider"];
    rcx = *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider;
    r12 = *(var_30 + rcx);
    *(var_30 + rcx) = r15;
    r15 = [r15 retain];
    r14 = *objc_release;
    [r12 release];
    [var_30 didChangeValueForKey:@"workspaceDocumentProvider"];
    [r15 release];
    goto loc_2486f5;

loc_248662:
    [r15 release];
    goto loc_24866b;
}
```

https://www.clarkcox.com/blog/2009/02/04/inspecting-obj-c-parameters-in-gdb/
https://github.com/XVimProject/XVim/blob/master/Documents/Developers/DevNotes.txt

***

#Two very important methods

 -[IDEViewController _resolveWorkspaceTabController]:
```
void -[IDEViewController _resolveWorkspaceTabController](void * self, void * _cmd) {
    rbx = self;
    var_30 = rbx;
    var_38 = _cmd;
    rax = [self isValid];
    if (LOBYTE(rax) == 0x0) {
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDEViewController _resolveWorkspaceTabController]", "/SourceCache/IDEFrameworks/IDEFrameworks-6776/IDEKit/ViewControllers/IDEViewController.m", 0x52, @"self.isValid", @"");
            rbx = var_30;
    }
    rax = [rbx isKindOfClass:[IDEWorkspaceTabController class]];
    rdi = var_30;
    if (LOBYTE(rax) == 0x0) goto loc_24829a;
    goto loc_24824e;

loc_24829a:
    r14 = [[rdi view] retain];
    r15 = @selector(superview);
    r12 = @selector(viewController);
    r13 = @selector(respondsToSelector:);
    LODWORD(rax) = 0x0;

loc_2482c9:
    var_40 = rax;

loc_2482cd:
    rbx = [[r14 superview] retain];
    [r14 release];
    if (rbx == 0x0) goto loc_2483d5;
    goto loc_2482f6;

loc_2483d5:
    rdi = var_30;
    if (rdi->_workspaceTabController == 0x0) {
            r15 = *objc_msgSend;
            r14 = [[rdi view] retain];
            rax = [r14 window];
            r12 = r15;
            r15 = [rax retain];
            [r14 release];
            if (r15 != 0x0) {
                    rax = [r15 isSheet];
                    if (LOBYTE(rax) != 0x0) {
                            rdx = @selector(_documentWindow);
                            rax = [r15 respondsToSelector:rdx];
                            LODWORD(r14) = 0x0;
                            if (LOBYTE(rax) != 0x0) {
                                    r14 = [[r15 _documentWindow] retain];
                            }
                            rdx = (r12)(IDEWorkspaceWindow, @selector(class), rdx);
                            rax = (r12)(r14, @selector(isKindOfClass:), rdx);
                            if (LOBYTE(rax) != 0x0) {
                                    r13 = *_OBJC_IVAR_$_IDEViewController._workspaceTabController;
                                    rax = (r12)(r14, @selector(windowController), rdx);
                                    rax = [rax retain];
                                    var_48 = r14;
                                    r14 = rax;
                                    (r12)(var_30, @selector(willChangeValueForKey:), @"workspaceTabController");
                                    rax = (r12)(r14, @selector(activeWorkspaceTabController), @"workspaceTabController");
                                    rax = [rax retain];
                                    rdi = *(var_30 + r13);
                                    *(var_30 + r13) = rax;
                                    r13 = *objc_release;
                                    [rdi release];
                                    (r12)(var_30, @selector(didChangeValueForKey:), @"workspaceTabController");
                                    rdi = r14;
                                    r14 = var_48;
                                    [rdi release];
                            }
                            [r14 release];
                    }
            }
            [r15 release];
    }
    r14 = *objc_release;
    [rbx release];
    rax = [var_40 release];

loc_24854e:
    return;

loc_2482f6:
    rax = [rbx respondsToSelector:rdx];
    r14 = rbx;
    if (LOBYTE(rax) == 0x0) goto loc_2482cd;
    r14 = [[rbx viewController] retain];
    var_48 = r14;
    [var_40 release];
    COND = r14 == 0x0;
    rax = r14;
    r14 = rbx;
    if (COND) goto loc_2482c9;
    rax = [var_48 isKindOfClass:[IDEWorkspaceTabController class]];
    COND = LOBYTE(rax) == 0x0;
    r14 = rbx;
    rax = var_48;
    if (COND) goto loc_2482c9;
    r13 = *objc_msgSend;
    [var_30 willChangeValueForKey:@"workspaceTabController"];
    r12 = *_OBJC_IVAR_$_IDEViewController._workspaceTabController;
    [var_48 retain];
    rdi = *(var_30 + r12);
    *(var_30 + r12) = var_48;
    [rdi release];
    [var_30 didChangeValueForKey:@"workspaceTabController"];
    var_40 = var_48;
    goto loc_2483d5;

loc_24824e:
    r12 = *objc_msgSend;
    [rdi willChangeValueForKey:@"workspaceTabController"];
    r15 = *_OBJC_IVAR_$_IDEViewController._workspaceTabController;
    rax = [var_30 retain];
    rdi = *(var_30 + r15);
    *(var_30 + r15) = rax;
    [rdi release];
    rax = [var_30 didChangeValueForKey:@"workspaceTabController"];
    goto loc_24854e;
}

```
 -[IDEViewController _resolveWorkspaceDocumentProvider]:
```
void -[IDEViewController _resolveWorkspaceDocumentProvider](void * self, void * _cmd) {
    rbx = self;
    var_30 = rbx;
    var_38 = _cmd;
    rax = [self isValid];
    if (LOBYTE(rax) == 0x0) {
            _DVTAssertionFailureHandler(var_30, var_38, "-[IDEViewController _resolveWorkspaceDocumentProvider]", "/SourceCache/IDEFrameworks/IDEFrameworks-6776/IDEKit/ViewControllers/IDEViewController.m", 0x84, @"self.isValid", @"");
            rbx = var_30;
    }
    r13 = *objc_msgSend;
    r14 = [[rbx view] retain];
    rbx = [[r14 superview] retain];
    [r14 release];
    if (rbx == 0x0) goto loc_2486f5;
    goto loc_248615;

loc_2486f5:
    rdi = var_30;
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
                    [var_30 willChangeValueForKey:@"workspaceDocumentProvider"];
                    objc_storeStrong(var_30 + *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider, var_40);
                    [var_30 didChangeValueForKey:@"workspaceDocumentProvider"];
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
    [var_30 willChangeValueForKey:@"workspaceDocumentProvider"];
    rcx = *_OBJC_IVAR_$_IDEViewController._workspaceDocumentProvider;
    r12 = *(var_30 + rcx);
    *(var_30 + rcx) = r15;
    r15 = [r15 retain];
    r14 = *objc_release;
    [r12 release];
    [var_30 didChangeValueForKey:@"workspaceDocumentProvider"];
    [r15 release];
    goto loc_2486f5;

loc_248662:
    [r15 release];
    goto loc_24866b;
}

```
