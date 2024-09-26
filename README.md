# Example Swift Package with SWIFT_PACKAGE define usage

This repository showcases two targets, a Swift and Objective-C target, that use the `SWIFT_PACKAGE` define to conditionally compile code.

Defined in the Objective-C target's header file behind the `SWIFT_PACKAGE` define:

```c
#if SWIFT_PACKAGE
int foo();
#endif
```

Then used in the Swift target:

```swift
import Foo

public func fooSwift() {
    print("FooSwift")
    print("ObjC foo: \(foo())")
}
```

Without proper compiler options, the defines are not set correctly and `foo` ends up being undefined.

```swift
swift build
```

Fails with:

```sh
swift-package-defines-example/Sources/FooSwift/Foo.swift:5:24: error: cannot find 'foo' in scope
3 | public func fooSwift() {
4 |     print("FooSwift")
5 |     print("ObjC foo: \(foo())")
  |                        `- error: cannot find 'foo' in scope
6 | }
7 |
```

If we add `cSettings` to the `Package.swift` file, we can set the `SWIFT_PACKAGE` define:

```swift
.target(
    name: "FooSwift",
    dependencies: ["Foo"],
    cSettings: [
        .define("SWIFT_PACKAGE"),
    ]
),
```

If we run `swift build --verbose` we can see the compiler options being set by SwiftPM:

```sh
-Xcc -DSWIFT_PACKAGE
```

When the C compiler is invoked and

```sh
-D SWIFT_PACKAGE
```

When the Swift compiler is invoked.
