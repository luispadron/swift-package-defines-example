#import "Foo.h"

#if SWIFT_PACKAGE
int foo() {
    return 42;
}
#endif
