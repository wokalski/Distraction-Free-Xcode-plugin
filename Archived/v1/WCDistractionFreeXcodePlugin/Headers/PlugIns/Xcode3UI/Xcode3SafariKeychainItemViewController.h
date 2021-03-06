//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "IDEProjectItemViewController.h"

@class DVTBorderedView, DVTGradientImageButton, DVTObservingToken, DVTTableView, NSArrayController, Xcode3SafariKeychainItemModel;

@interface Xcode3SafariKeychainItemViewController : IDEProjectItemViewController
{
    DVTObservingToken *_itemObserver;
    DVTBorderedView *_tableBorder;
    DVTTableView *_domainsTable;
    DVTGradientImageButton *_addDomainButton;
    DVTGradientImageButton *_removeDomainButton;
    NSArrayController *_domainsController;
}

@property(retain) NSArrayController *domainsController; // @synthesize domainsController=_domainsController;
@property(retain) DVTGradientImageButton *removeDomainButton; // @synthesize removeDomainButton=_removeDomainButton;
@property(retain) DVTGradientImageButton *addDomainButton; // @synthesize addDomainButton=_addDomainButton;
@property(retain) DVTTableView *domainsTable; // @synthesize domainsTable=_domainsTable;
@property(retain) DVTBorderedView *tableBorder; // @synthesize tableBorder=_tableBorder;
- (void).cxx_destruct;
- (void)removeSelectedDomains:(id)arg1;
- (void)addDomain:(id)arg1;
- (void)primitiveInvalidate;
- (void)viewWillUninstall;
- (void)viewDidInstall;
- (void)layout;
- (void)loadView;
- (id)initWithEditorItemModel:(id)arg1 portalInfoDelegate:(id)arg2;

// Remaining properties
@property(readonly, nonatomic) Xcode3SafariKeychainItemModel *model;

@end

