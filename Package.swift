// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PXPCheckout",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PXPCheckout",
            targets: ["PXPCheckout"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PXPCheckout",
            dependencies: [
                "PXPCheckoutSDK",
                "KountDataCollector",
                "Alamofire",
                "CorePayments",
                "PaymentButtons",
                "PayPalWebPayments",
                "CardPayments",
                "FraudProtection",
                "PPRiskMagnes"
            ]
        ),
        .binaryTarget(
            name: "PXPCheckoutSDK",
            path: "Build/Frameworks/PXPCheckoutSDK.xcframework"
        ),
        .binaryTarget(
            name: "Alamofire",
            path: "Build/Frameworks/Alamofire.xcframework"
        ),
        .binaryTarget(
            name: "CorePayments",
            path: "Build/Frameworks/CorePayments.xcframework"
        ),
        .binaryTarget(
            name: "PaymentButtons",
            path: "Build/Frameworks/PaymentButtons.xcframework"
        ),
        .binaryTarget(
            name: "PayPalWebPayments",
            path: "Build/Frameworks/PayPalWebPayments.xcframework"
        ),
        .binaryTarget(
            name: "CardPayments",
            path: "Build/Frameworks/CardPayments.xcframework"
        ),
        .binaryTarget(
            name: "FraudProtection",
            path: "Build/Frameworks/FraudProtection.xcframework"
        ),
        .binaryTarget(
            name: "PPRiskMagnes",
            path: "Build/Frameworks/PPRiskMagnes.xcframework"
        ),
        .binaryTarget(
            name: "KountDataCollector",
            path: "Build/Frameworks/KountDataCollector.xcframework"
        )
    ]
)

