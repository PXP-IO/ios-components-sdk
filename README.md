# PXPCheckout Swift Package

PXP Unity iOS SDK for integrating secure payment processing with multiple payment methods.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.9+

## Installation

### Swift Package Manager

#### Option 1: Add via Xcode (Recommended)

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:
   - **Production**: `https://github.com/PXP-IO/ios-components-sdk.git`
   - **Development/QA**: `https://dev.azure.com/pxphq/Unity/_git/Pxp.Unity.Components.iOS.SDK`
4. Select the version rule: **Up to Next Major Version** starting from `1.0.1`
5. Click **Add Package**
6. Select **`PXPCheckout`** and add to your target (re-exports `PXPCheckoutSDK` and `KountDataCollector`)

#### Option 2: Add via Package.swift

Add the following to your `Package.swift` file:

```swift
dependencies: [
    // Production
    .package(url: "https://github.com/PXP-IO/ios-components-sdk.git", from: "1.0.1")
    
    // Or Development/QA
    // .package(url: "https://dev.azure.com/pxphq/Unity/_git/Pxp.Unity.Components.iOS.SDK", from: "1.0.0")
]
```

Then add `PXPCheckout` to your target dependencies:

```swift
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "PXPCheckout", package: "ios-components-sdk")
        ]
    )
]
```

#### Version Options

```swift
// Specific version
.package(url: "...", exact: "1.2.3")

// Version range
.package(url: "...", from: "1.0.0")

// Branch (for development)
.package(url: "...", branch: "development")
```

#### Troubleshooting SPM resolution

If Xcode shows `unexpectedly did not find the new dependency in the package graph` after a tag update:

1. Quit Xcode
2. Delete your project's `Package.resolved` (in `.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/`)
3. Clear SPM caches:
   ```bash
   rm -rf ~/Library/Caches/org.swift.swiftpm
   rm -rf ~/Library/org.swift.swiftpm
   ```
4. Reopen Xcode → **File → Packages → Reset Package Caches** → **Resolve Package Versions**
5. Add the package again using version `1.0.1` or later

### Azure DevOps Authentication (for QA/Dev)

If using the Azure DevOps repository, you may need to configure authentication:

1. Generate a Personal Access Token (PAT) in Azure DevOps
2. Configure Xcode to use the PAT for authentication
3. Or use the HTTPS URL with credentials embedded

## Usage

### Basic Setup

```swift
import PXPCheckoutSDK

// 1. Create session data (obtained from your backend via PXP Unity API)
let sessionData = SessionData(
    sessionId: "session-id-from-api",
    hmacKey: "hmac-key-from-api",
    encryptionKey: "encryption-key-from-api",
    allowedFundingTypes: AllowedFundingType(
        cards: ["visa", "mastercard", "amex"],
        wallets: Wallets(
            paypal: Paypal(
                allowedFundingOptions: ["paypal", "paylater"],
                merchantId: "your-paypal-merchant-id"
            ),
            applePay: ApplePay(merchantId: "merchant.com.yourapp")
        )
    )
)

// 2. Create transaction data
let transactionData = TransactionData(
    amount: 99.99,
    currency: "USD",
    entryType: .ecom,
    intent: TransactionIntentData(
        card: .authorisation,      // or .capture
        paypal: .authorisation     // or .capture
    ),
    merchantTransactionId: "order-12345",
    merchantTransactionDate: { Date() }
)

// 3. Create checkout configuration
let config = CheckoutConfig(
    environment: .test,            // .test or .live
    session: sessionData,
    transactionData: transactionData,
    merchantShopperId: "shopper-123",
    ownerType: "MerchantGroup",
    ownerId: "your-owner-id",
    onGetShippingAddress: {
        // Return shipping address for AVS
        return ShippingAddress(
            countryCode: "US",
            postalCode: "12345",
            address: "123 Main St"
        )
    },
    onGetShopper: {
        // Return shopper info for saved cards
        return TransactionShopper(
            id: "shopper-123",
            firstName: "John",
            lastName: "Doe",
            email: "john@example.com"
        )
    },
    analyticsEvent: { event in
        print("Analytics: \(event)")
    }
)

// 4. Initialize SDK
let pxpCheckout = try PxpCheckout.initialize(config: config)
```

### Using Checkout Drop-In (Recommended)

The Drop-In provides a complete pre-built UI with all payment methods:

```swift
import SwiftUI
import PXPCheckoutSDK

struct CheckoutView: View {
    @State private var checkoutDropIn: CheckoutDropIn?
    
    var body: some View {
        VStack {
            if let dropIn = checkoutDropIn {
                dropIn.Content()
            }
        }
        .task {
            await initializeCheckout()
        }
    }
    
    private func initializeCheckout() async {
        let dropInConfig = CheckoutDropInConfig(
            environment: .test,
            session: sessionData,
            transactionData: DropInTransactionData(
                amount: 99.99,
                currency: "USD",
                entryType: .ecom,
                intent: TransactionIntentData(card: .authorisation, paypal: .authorisation),
                merchantTransactionId: "order-12345",
                merchantTransactionDate: { Date() }
            ),
            merchantShopperId: "shopper-123",
            ownerId: "your-owner-id",
            onSuccess: { result in
                print("Payment successful: \(result.systemTransactionId)")
            },
            onError: { paymentMethod, error in
                print("Payment failed: \(error.errorMessage)")
            }
        )
        
        do {
            checkoutDropIn = try CheckoutDropIn(config: dropInConfig)
            await checkoutDropIn?.create()
        } catch {
            print("Failed to initialize: \(error)")
        }
    }
}
```

## Dependencies

This package includes the following dependencies (automatically resolved by SPM):

| Dependency | Version | Purpose |
|------------|---------|---------|
| [Alamofire](https://github.com/Alamofire/Alamofire) | 5.8.0+ | HTTP networking |
| [Kount iOS SDK](https://github.com/Kount/kount-ios-swift-package) | 4.2.2+ | Fraud detection and risk management |
| [PayPal iOS SDK](https://github.com/paypal/paypal-ios) | 2.0.0+ | PayPal payments integration |
| [Swinject](https://github.com/Swinject/Swinject) | 2.8.0+ | Dependency injection |

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Documentation: [Link to docs]
- Issues: [Link to issues]
- Contact: [Support email]