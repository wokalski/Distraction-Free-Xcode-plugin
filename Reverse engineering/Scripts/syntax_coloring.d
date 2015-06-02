
/*
    This DTrace script analyzes what is the "workflow" of a program to determine `syntaxColoringContextForTextView:`. This call usually just returns a dictionary.

    When `syntaxColoringContextForTextView:` is called it enables logging of all calls to `IDE*` classes.
*/

self enabled;
self indentation;

#pragma D option flowindent

BEGIN
{
    self->enabled = 0;
    self->indentation = 0;
}

objc$1:IDESourceCodeEditor:-syntaxColoringContextForTextView?:entry
{
	self->enabled = 1;
}

objc$1:IDESourceCodeEditor:-syntaxColoringContextForTextView?:return
/self->enabled == 1/
{
    self->enabled=0;
    exit(0);
}

// Developing this kind of Xcode plugin I care mainly about classes starting with IDE* prefix for readability and performance reasons.

objc$1:IDE*::entry
/self->enabled == 1/
{
}

objc$1:IDE*::return
/self->enabled == 1/
{  
}
