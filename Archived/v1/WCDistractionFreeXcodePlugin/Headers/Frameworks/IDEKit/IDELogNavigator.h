//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <IDEKit/IDENavigator.h>

#import "NSMenuDelegate.h"

@class DVTMapTable, DVTObservingToken, DVTScopeBarView, DVTScrollView, IDELogNavigatorRootItem, IDENavigatorDataCell, IDENavigatorOutlineView, NSArray, NSButton, NSCell, NSDictionary, NSImage, NSMapTable, NSMutableArray, NSMutableSet, NSPredicate, NSSet, NSString;

@interface IDELogNavigator : IDENavigator <NSMenuDelegate>
{
    NSImage *_buildIconImage;
    NSMutableSet *_expandedItems;
    NSDictionary *_sStatusCells;
    NSArray *_sSpaceCellArray;
    NSCell *_loadMoreLoadingCell;
    IDENavigatorDataCell *_loadMoreCell;
    IDENavigatorDataCell *_botExecutionCellByTime;
    IDENavigatorDataCell *_activityLogCellByTime;
    IDENavigatorDataCell *_botExecutionCellByGroup;
    IDENavigatorDataCell *_activityLogCellByGroup;
    NSMutableArray *_stateChangeObservingTokens;
    BOOL _restoringState;
    BOOL _keepSelectionWhenRestoringState;
    BOOL _workspaceBotFilteringAllowed;
    BOOL _workspaceBotFilteringEnabled;
    NSMapTable *_weakBotsToStrongCells;
    DVTObservingToken *_outlineViewExpandingObserverToken;
    DVTObservingToken *_botWorkspaceFilterAllowedObservingToken;
    DVTObservingToken *_botWorkspaceFilterObservingToken;
    DVTMapTable *_weakExecutionNavigablesToStrongObservingTokens;
    DVTMapTable *_weakBotNavigablesToStrongObserverTokens;
    NSMutableSet *_serversOnWhichUserCanCreateAndDeleteBots;
    NSMapTable *_strongIntegrationsToStrongObservingToken;
    BOOL _recentsOnlyFilteringEnabled;
    BOOL _groupByTime;
    NSPredicate *_groupingPredicate;
    IDENavigatorOutlineView *_outlineView;
    DVTScopeBarView *_scopeBarView;
    NSString *_filterPatternString;
    NSArray *_selectedObjects;
    IDELogNavigatorRootItem *_rootItem;
    DVTObservingToken *_serverManagerObservingToken;
    NSMutableArray *_serverObservingTokens;
    NSMutableArray *_botsToDelete;
    NSMutableSet *_mutableCollapsedItemIdentifiers;
    NSMutableSet *_mutableExpandedItemIdentifiers;
    NSButton *_byGroupedButton;
    NSButton *_byTimeButton;
    DVTScrollView *_logNavigatorScrollView;
}

+ (id)imageForTypeIdentifier:(id)arg1;
+ (void)configureStateSavingObjectPersistenceByName:(id)arg1;
+ (id)keyPathsForValuesAffectingWorkspaceBotFilteringEnabled;
+ (id)appHeaderImage;
+ (id)imageNamed:(id)arg1;
+ (void)initialize;
@property __weak DVTScrollView *logNavigatorScrollView; // @synthesize logNavigatorScrollView=_logNavigatorScrollView;
@property(nonatomic) BOOL groupByTime; // @synthesize groupByTime=_groupByTime;
@property(retain, nonatomic) NSButton *byTimeButton; // @synthesize byTimeButton=_byTimeButton;
@property(retain, nonatomic) NSButton *byGroupedButton; // @synthesize byGroupedButton=_byGroupedButton;
@property(readonly, copy) NSMutableSet *mutableExpandedItemIdentifiers; // @synthesize mutableExpandedItemIdentifiers=_mutableExpandedItemIdentifiers;
@property(readonly, copy) NSMutableSet *mutableCollapsedItemIdentifiers; // @synthesize mutableCollapsedItemIdentifiers=_mutableCollapsedItemIdentifiers;
@property(retain, nonatomic) NSMutableArray *botsToDelete; // @synthesize botsToDelete=_botsToDelete;
@property(retain, nonatomic) NSMutableArray *serverObservingTokens; // @synthesize serverObservingTokens=_serverObservingTokens;
@property(retain, nonatomic) DVTObservingToken *serverManagerObservingToken; // @synthesize serverManagerObservingToken=_serverManagerObservingToken;
@property(retain) IDELogNavigatorRootItem *rootItem; // @synthesize rootItem=_rootItem;
@property(retain, nonatomic) NSArray *selectedObjects; // @synthesize selectedObjects=_selectedObjects;
@property(nonatomic) BOOL recentsOnlyFilteringEnabled; // @synthesize recentsOnlyFilteringEnabled=_recentsOnlyFilteringEnabled;
@property(copy, nonatomic) NSString *filterPatternString; // @synthesize filterPatternString=_filterPatternString;
@property(retain) DVTScopeBarView *scopeBarView; // @synthesize scopeBarView=_scopeBarView;
@property(retain) IDENavigatorOutlineView *outlineView; // @synthesize outlineView=_outlineView;
@property(copy) NSPredicate *groupingPredicate; // @synthesize groupingPredicate=_groupingPredicate;
- (void).cxx_destruct;
- (double)outlineView:(id)arg1 heightOfRowByItem:(id)arg2;
- (id)outlineView:(id)arg1 dataCellForTableColumn:(id)arg2 item:(id)arg3;
- (id)outlineView:(id)arg1 selectionIndexesForProposedSelection:(id)arg2;
- (BOOL)outlineView:(id)arg1 isGroupHeaderItem:(id)arg2;
- (void)outlineViewItemDidCollapse:(id)arg1;
- (void)outlineViewItemDidExpand:(id)arg1;
- (id)cellForItem:(id)arg1;
- (id)_statusCellsForBotIntegration:(id)arg1 showOfflineIndicator:(BOOL)arg2;
- (void)_configureStatusCells:(id)arg1 forDataCell:(id)arg2;
- (id)_highLevelStatusCells;
- (id)_newHighLevelStatusItemCellWithImage:(id)arg1;
- (void)testAction:(id)arg1;
- (id)botExecutionCell;
- (id)loadMoreCell;
- (id)activityLogCellUsingByTime:(BOOL)arg1;
- (id)logHeaderCell;
- (id)botHeaderCellWithBot:(id)arg1 item:(id)arg2;
- (id)_baseCell;
- (void)setOutputSelection:(id)arg1;
- (void)updateBoundSelection;
@property(copy) NSString *visibleRectString;
@property(copy) NSDictionary *stateSavingSelectedObjects;
- (void)_revealNavigableItems:(id)arg1;
- (void)commitStateToDictionary:(id)arg1;
- (void)revertStateWithDictionary:(id)arg1;
- (void)_configureStateSavingObservers;
- (id)filterDefinitionIdentifier;
- (void)_clearFilterPredicate;
@property(nonatomic) BOOL workspaceBotFilteringEnabled;
@property(nonatomic) BOOL workspaceBotFilteringAllowed;
- (void)updateFilterPredicate;
- (id)_localLogRecords;
- (id)_recentLogRecords;
- (BOOL)_isFiltered;
- (void)setFilteringEnabled:(BOOL)arg1;
- (void)setFilterPredicate:(id)arg1;
- (void)_synchronizeFilteringWithOutlineView;
- (id)filterButtonMenu;
- (void)menuCmd_viewIntegrationInBrowser:(id)arg1;
- (void)menuCmd_viewBotInBrowser:(id)arg1;
- (void)menuCmd_deleteIntegration:(id)arg1;
- (void)menuCmd_cancelIntegration:(id)arg1;
- (void)_alertDidEnd:(id)arg1 returnCode:(long long)arg2 contextInfo:(void *)arg3;
- (void)menuCmd_cleanAndIntegrateNow:(id)arg1;
- (void)menuCmd_integrateNow:(id)arg1;
- (void)_deleteAlertDidEnd:(id)arg1 returnCode:(long long)arg2 contextInfo:(void *)arg3;
- (void)menuCmd_deleteBot:(id)arg1;
- (void)menuCmd_editBot:(id)arg1;
- (void)menuCmd_createBot:(id)arg1;
- (BOOL)validateUserInterfaceItem:(id)arg1;
- (id)selectedRepresentedNavigableObjects;
- (void)menuWillOpen:(id)arg1;
- (BOOL)_canUserCreateAndDeleteBotsOnServiceForBotOrIntegration:(id)arg1;
- (BOOL)delegateFirstResponder;
- (void)primitiveInvalidate;
- (void)viewWillUninstall;
- (void)viewDidInstall;
- (void)setRootNavigableItem:(id)arg1;
- (id)findLogInItem:(id)arg1 equalTo:(id)arg2;
- (id)_recursiveFindNavigableItemForRepresentedObject:(id)arg1 fromNavigableItem:(id)arg2;
- (void)updateByGroupAction:(id)arg1;
- (void)updateByTimeAction:(id)arg1;
- (void)loadView;
- (void)_expandLogItems;
- (id)dvtExtraBindings;
- (void)openDoubleClickedNavigableItemsAction:(id)arg1;
- (void)openClickedNavigableItemAction:(id)arg1;
- (void)openSelectedNavigableItemsKeyAction:(id)arg1;
- (id)openSpecifierForNavigableItem:(id)arg1 error:(id *)arg2;
- (id)domainIdentifier;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(copy) NSSet *expandedItems; // @dynamic expandedItems;
@property(readonly) unsigned long long hash;
@property(readonly, copy) NSMutableSet *mutableExpandedItems; // @dynamic mutableExpandedItems;
@property(readonly) Class superclass;

@end

