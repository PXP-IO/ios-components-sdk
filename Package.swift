// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PXPCheckoutSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PXPCheckoutSDK",
            targets: ["PXPCheckoutSDK"]
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
            path: "Frameworks/PXPCheckoutSDK.xcframework"
        ),
        .binaryTarget(
            name: "Alamofire",
            path: "Frameworks/Alamofire.xcframework"
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
        )
    ]
)

