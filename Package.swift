// swift-tools-version: 5.9
import PackageDescription

let sdkBinaryDependencies: [Target.Dependency] = [
    "PXPCheckoutSDK",
    "KountDataCollector",
    "Alamofire",
    "Swinject",
    "CorePayments",
    "PaymentButtons",
    "PayPalWebPayments",
    "CardPayments",
    "FraudProtection",
    "PPRiskMagnes",
    "aerosync_ios_sdk"
]

let package = Package(
    name: "PXPCheckout",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PXPCheckout",
            targets: ["PXPCheckout"]
        ),
        .library(
            name: "PXPCheckoutSDK",
            targets: ["PXPCheckoutSDK"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PXPCheckout",
            dependencies: sdkBinaryDependencies,
            path: "Sources/PXPCheckout"
        ),
        .binaryTarget(
            name: "PXPCheckoutSDK",
            path: "Frameworks/PXPCheckoutSDK.xcframework"
        ),
        .binaryTarget(
            name: "Alamofire",
            path: "Frameworks/Alamofire.xcframework"
        ),
        .binaryTarget(
            name: "Swinject",
            path: "Frameworks/Swinject.xcframework"
        ),
        .binaryTarget(
            name: "CorePayments",
            path: "Frameworks/CorePayments.xcframework"
        ),
        .binaryTarget(
            name: "PaymentButtons",
            path: "Frameworks/PaymentButtons.xcframework"
        ),
        .binaryTarget(
            name: "PayPalWebPayments",
            path: "Frameworks/PayPalWebPayments.xcframework"
        ),
        .binaryTarget(
            name: "CardPayments",
            path: "Frameworks/CardPayments.xcframework"
        ),
        .binaryTarget(
            name: "FraudProtection",
            path: "Frameworks/FraudProtection.xcframework"
        ),
        .binaryTarget(
            name: "PPRiskMagnes",
            path: "Frameworks/PPRiskMagnes.xcframework"
        ),
        .binaryTarget(
            name: "KountDataCollector",
            path: "Frameworks/KountDataCollector.xcframework"
        ),
        .binaryTarget(
            name: "aerosync_ios_sdk",
            path: "Frameworks/aerosync_ios_sdk.xcframework"
        )
    ]
)
