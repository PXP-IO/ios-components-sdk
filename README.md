# PXPCheckout Swift Package

A comprehensive iOS SDK for payment processing with Apple Pay, PayPal, and card payments.

## Features

- 🍎 **Apple Pay Integration**: Complete Apple Pay support with DPAN consent and advanced payment features
- 💰 **PayPal Integration**: PayPal, Pay Later, and Venmo with consent management
- 💳 **Card Payments**: Secure card input and processing with consent components
- 🔒 **Security**: Built-in fraud detection with Kount integration and 3DS support
- 📊 **Analytics**: Comprehensive payment analytics and event tracking
- 🎨 **UI Components**: Pre-built, customizable payment components for iOS
- 🌍 **Localization**: Multi-language support (EN, ES, EL)

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://dev.azure.com/pxphq/Unity/_git/Pxp.Unity.Components.iOS.SDK", branch: "main")
]
```

Or add it through Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL: `https://dev.azure.com/pxphq/Unity/_git/Pxp.Unity.Components.iOS.SDK`
3. Select branch (`main`) or version and add to target

## Quick Start

### 1. SDK Initialization

The SDK requires session data from the Unity API. The sample app includes a utility class that handles initialization:

```swift
import PXPCheckoutSDK

// Create checkout configuration
let checkoutData = PXPCheckoutData(
    merchant: "Unity",
    site: "Unity",
    amount: 100.0,
    currency: .usd,
    entryType: .ecom,
    intentType: .authorisation,
    merchantTransactionId: UUID().uuidString.lowercased(),
    merchantShopperId: "Shopper_Demo"
)

// Initialize SDK with real API data (fallback to mock on failure)
let pxpCheckout = try await PxpCheckoutSdkUtils.getPxpCheckoutSdk(
    checkoutData: checkoutData,
    analyticsEventHandler: { event in
        // Handle analytics events
        print("Analytics: \(event.eventName)")
    }
)
```

### 2. Create Components

Use type-safe component creation:

```swift
// Create Apple Pay Button Component
let applePayConfig = ApplePayButtonComponentConfig()
applePayConfig.currencyCode = "USD"
applePayConfig.countryCode = "US"
applePayConfig.buttonType = .plain
applePayConfig.buttonStyle = .black

let applePayComponent = try pxpCheckout.create(
    .applePayButton,
    componentConfig: applePayConfig
)

// Create PayPal Button Component
let paypalConfig = PayPalButtonComponentConfig()
paypalConfig.clientId = "your-paypal-client-id"
paypalConfig.environment = .sandbox
paypalConfig.fundingSource = .paypal

let paypalComponent = try pxpCheckout.create(
    .paypalButton,
    componentConfig: paypalConfig
)
```

## Analytics

The SDK provides comprehensive analytics for tracking payment events:

```swift
let checkout = try await PxpCheckoutSdkUtils.getPxpCheckoutSdk(
    checkoutData: checkoutData,
    analyticsEventHandler: { event in
        print("Event: \(event.eventName)")
        print("Session ID: \(event.sessionId)")
        print("Timestamp: \(event.timestamp)")
        
        // Handle different event types
        if let interactionEvent = event as? ComponentInteractionAnalyticsEvent {
            print("Component: \(interactionEvent.componentId)")
            print("Interaction: \(interactionEvent.interactionType)")
        }
    }
)
```

## Troubleshooting

### SSL Certificate Issues (QA Environment)

The sample app includes an `SSLTrustDelegate` for QA environments that bypasses SSL validation for `*.qa.kube.qa` domains. Remove this for production:

```swift
// For production, use default SSL validation
let session = URLSession(configuration: sessionConfig)
```

### PayPal Not Enabled

If you see error `SDK0108: PayPal is not enabled for this merchant`:

1. Check Unity API response includes `allowedFundingTypes.wallets.paypal`
2. Verify merchant/site configuration in Unity backend
3. Contact backend team to enable PayPal for your merchant

### Component Creation Failures

Always wrap component creation in error handling:

```swift
do {
    let component = try checkout.create(.applePayButton, componentConfig: config)
    // Use component
} catch {
    print("Failed to create component: \(error.localizedDescription)")
}
```