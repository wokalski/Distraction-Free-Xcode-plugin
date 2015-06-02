
self enabled;
self indentation;

#pragma D option flowindent

BEGIN
{
    self->enabled = 0;
    self->indentation = 0;
}

objc$1:IDESourceCodeNavigationRequest:-jumpToDefinitionOfExpression?fromScreenPoint?:entry
{
	self->enabled = 1;
}

objc$1:IDESourceCodeNavigationRequest:-jumpToDefinitionOfExpression?fromScreenPoint?:return
/self->enabled == 1/
{
    self->enabled=0;
    exit(0);
}

objc$1:IDE*::entry
/self->enabled == 1/
{
}

objc$1:IDE*::return
/self->enabled == 1/
{  
}

/*
objc$1:::entry
/self->indentation < 10/
{
    this->method = (string)&probefunc[1];
    this->type = probefunc[0];
    this->class = probemod;
    printf("%*s%s %c[%s %s]\n", self->indentation, "", "->", this->type, this->class, this->method);

}

objc$1:::return
/self->indentation < 10/
{
    this->method = (string)&probefunc[1];
    this->type = probefunc[0];
    this->class = probemod;
    printf("%*s%s %c[%s %s]\n", self->indentation, "", "->", this->type, this->class, this->method);
}*/