// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-package-defines-example",
    products: [
        .library(
            name: "Foo",
            targets: ["Foo"]
        ),
        .library(
            name: "FooSwift",
            targets: ["FooSwift"]
        ),
    ],
    targets: [
        .target(
            name: "Foo"
        ),
        .target(
            name: "FooSwift",
            dependencies: ["Foo"],
            cSettings: [
                .define("SWIFT_PACKAGE"),
            ]
        ),
    ]
)
