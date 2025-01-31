# MultiAds Interface

MultiAds Interface is a SwiftUI plugin designed to simplify ad management in iOS applications. This core interface allows developers to handle multiple ad networks and configurations dynamically from the server side, providing greater flexibility and control over monetization strategies.

## Features
- **Server-Side Ad Management**: Configure and control ad placements remotely.
- **Support for Multiple Ad Networks**: Easily integrate various ad providers.
- **Adaptive Ad Formats**: Supports banners, interstitials, rewarded ads, and native ads.
- **Dynamic Ad Configuration**: Change ad settings without updating the app.
- **Lightweight and Efficient**: Optimized for performance and minimal resource usage.

## Installation
To install MultiAds Interface in your SwiftUI project, follow these steps:

### Using Swift Package Manager (SPM)
1. Open your Xcode project.
2. Go to **File** > **Add Packages**.
3. Enter the repository URL: `https://github.com/yourusername/MultiAdsInterface.git`
4. Choose the latest version and click **Add Package**.

## Usage
### Import the Package
```swift
import MultiAdsInterface
```

### Initialize MultiAds Interface
```swift
MultiAdsInterface().setUp(
    registerAppParameters: RegisterAppParameters(
        appVersion:"1.1",
        apiKey: ApiRegister(iosKey: "64af2e19-92fb-11ef-838a-494789d79a7e"),
        onUpdateLaunch: { LaunchUrl in
        }, onError: { InitError in
            print("Error \(InitError)")
        }, onComplete: { fetchedJson in
            print("onComplete: \(fetchedJson)")
            notFirstTime = true;
        },
        requiredAdNetworks: [
            .google : GoogleAdsMultiClient().googleAds
        ]
    )
)
```

### Display an Ad
#### Banner Ad
```swift
MultiAdsView(adType: .banner)
```

#### Interstitial Ad
```swift
multiAdsManager.showAd(ofType: .interstitial)
```

#### Rewarded Ad
```swift
multiAdsManager.showAd(ofType: .rewarded) { reward in
    print("User earned reward: \(reward)")
}
```

## Configuration
Ad settings can be managed via a JSON configuration file hosted on your server. Example:
```json
{
  "adNetwork": "AdMob",
  "placements": {
    "banner": "ca-app-pub-xxxxx/yyyyy",
    "interstitial": "ca-app-pub-xxxxx/zzzzz",
    "rewarded": "ca-app-pub-xxxxx/aaaaa"
  }
}
```

## License
MultiAds Interface is released under the MIT License. See [LICENSE](LICENSE) for details.

## Contribution
Contributions are welcome! Feel free to submit issues or pull requests.

## Contact
For support or inquiries, please reach out to [your email or website].

