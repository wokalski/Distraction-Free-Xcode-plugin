
# IDEKit notes

## Editor navigation utilities

Xcode's command+click navigation makes it really easy to navigate quickly through ~~files~~ related pieces of code.

This feature comes with a great cost though. It is possible thanks to a few dependencies. Some of them are implicit and resolved lazyly in not-so-obvious manner. The other ones are values returned from the delegate or just properties. (The thing I'm missing in this infrastructure is some configuration object which encapsulets those dependencies).

In a nutshell:

1. `DVTSourceTextView` calls it's delegate (the view controller) upon click (`- (void)textView:(DVTSourceTextView *)textView didClickOnTemporaryLinkAtCharacterIndex:(NSUInteger)index event:(NSEvent *)event isAltEvent:(BOOL)altEvent`)
2. After some time Xcode realizes the single cmd click was **the** desired action and begins the whole "procedure".
3. It creates a `IDESourceCodeNavigationRequest` by initializing it with the source editor (the editor the action was performed in).
4. It determines what kind of symbol it was (depending on the document it has)
5. It obtains the global "symbol index" and resolves the given index. (it happens through climbing up to the `workspaceTabController.workspace.index`)
6. Thanks to the global index it collects the occurencies of the symbol and navigates to the best result for a given text.

***

In ~~Xcode~~ IDEKit architecture (just bear in mind my limited knowledge about the architecture derived from reverse engineering) there's a very *interesting* approach to resolve dependencies climibing throught the hierarchy and finding what's needed. It results in tight relationship between various objects, what makes testing impossible and reusability laughable.

#Two very important methods of `IDEViewController`

There are two very important methods in the `IDEViewController` which is a superclass for many classes in the Xcode UI part.

`-[IDEViewController _resolveWorkspaceTabController]:`

It is called when the `workspaceTabController` property is nil. It lazyly resolves a **view/window controller** whose class is `IDEWorkspaceTabController`. In order to do that it goes up through the **view hierarchy**. Ok, I agree it's weird, but nothing we can do about it.

The question remains though, how does it happen? Guess what. Some views have `viewController` property. If a view responds to `viewController` selector and the view controller is `IDEWorkspaceTabController` kind of class, this view controller is assigned to the `workspaceTabController` property. This method fails silently because... there's also a possibility to directly set the property, which makes even the core class's behaviour ambigous.

`-[IDEViewController _resolveWorkspaceDocumentProvider]:`

Does the same thing with `IDEWorkspaceDocumentProvider` protocol as `_resolveWorkspaceTabController` with `IDEWorkspaceTabController` class. It traverses the superview hierarchy in order to find a controller conforming to the protocol.


# Useful links

There's not too much about Xcode plugins in the web. Please do create a pull request with another useful link if you know something interesting.

https://github.com/XVimProject/XVim/blob/master/Documents/Developers/DevNotes.txt
