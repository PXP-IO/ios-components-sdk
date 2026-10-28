// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PXPCheckout",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Single public SPM product — one xcframework; vendors statically linked at build time.
        .library(
            name: "PXPCheckoutSDK",
            targets: ["PXPCheckoutSDKBinary"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "PXPCheckoutSDKBinary",
            path: "Frameworks/PXPCheckoutSDK.xcframework"
        )
    ]
)
