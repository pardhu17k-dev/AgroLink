# 🌱 Smart Food Access

[![Flutter Version](https://img.shields.io/badge/Flutter-%E2%89%A53.11.1-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-%E2%89%A53.11.1-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase Ecosystem](https://img.shields.io/badge/Firebase-Core%20%7C%20Auth%20%7C%20Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Google Maps](https://img.shields.io/badge/Google%20Maps-Interactive-4285F4?style=for-the-badge&logo=googlemaps&logoColor=white)](https://developers.google.com/maps)
[![License: MIT](https://img.shields.io/badge/License-MIT-emerald?style=for-the-badge)](https://opensource.org/licenses/MIT)

**Smart Food Access** is a premium, state-of-the-art Flutter mobile application designed to bridge the gap between farmers, consumers, and corporate partners. By creating a direct marketplace for surplus produce and food donations, the platform actively reduces agricultural food waste, promotes community kitchens, and optimizes local supply chains using AI-assisted demand analytics.

---

## 🎨 Premium Visual Identity & Design
Built following modern mobile design patterns and rich aesthetics, the application includes:
- 🌿 **Curated Emerald Palette:** Primary theme centered around Emerald Green (`#10B981`) representing freshness, nature, and sustainability.
- 📱 **Smooth Micro-Animations:** Driven by `flutter_animate` for organic, springy transitions, and interactive role selection cards.
- ✍️ **Tailored Typography:** Combines the high-character **Outfit** font for headings and structural elements with the clean, highly legible **Inter** font for UI body content.
- 🌙 **Glassmorphic Elevations:** Soft borders and subtle shadows rather than harsh default cards.

---

## 🚀 Key Features by User Role

Smart Food Access dynamically adapts its interface depending on how the user signs in:

### 1. 🛒 Consumers ("Find Food")
- **Surplus Marketplace:** Browse local, fresh farm produce. Items include distance tags, crop listings, and countdowns until expiry.
- **Food Donation Claiming:** Spot and claim 100% free food donations listed for community kitchens and low-income families.
- **Interactive Map Search:** View items distributed on an interactive Google Map, complete with custom color-coded map pins (Blue for user, Green for farms).
- **Checkout & Digital Cart:** Seamless purchase flow with responsive quantity selectors, order checkout, and payment gateways.

### 2. 👩‍🌾 Farmers ("Provide Food")
- **Listings Manager:** Create, update, and publish surplus produce listings in seconds. Upload images, specify units (kg, boxes, bunches), set prices (or mark as donations), and set fresh/expiry indicators.
- **Active Order Tracker:** View incoming client requests, accept orders in real-time, and manage active logistics statuses.
- **Inventory Overview:** A clear administrative list showing all active listings and current availability.

### 3. 📈 Corporates ("Company Analytics")
- **AI-Predicted Demand Trends:** Interactive charts powered by `fl_chart` showing daily demand trends to help companies optimize transport and stock management.
- **Key Metrics Dashboard:** Real-time summary statistics tracking *Total App Users*, *Available Food Listings*, *Completed Orders*, and *Highest-Demand Crops*.

---

## 📁 Technical Architecture & Code Structure

The project conforms to clean architectural principles with separated concerns:

```text
lib/
├── main.dart                 # Application entry point & Provider configuration
├── theme/
│   └── app_theme.dart        # Unified light theme configuration (colors, buttons, typography)
├── models/
│   └── food_item.dart        # Food item schema & mockup data (e.g., Organic Tomatoes, Surplus Potatoes)
├── providers/
│   └── food_provider.dart    # State management for food listings and consumer cart actions
├── services/
│   ├── auth_service.dart     # Firebase Authentication helper
│   └── firestore_service.dart # Cloud Firestore CRUD operations for listings and orders
├── widgets/
│   └── food_item_card.dart   # Reusable UI card component with premium elevation & loading handles
└── screens/
    ├── auth_screen.dart      # Interactive multi-role login & onboarding screen
    ├── main_layout.dart      # Navigation bridge (Tabs: Home, Map, Orders, Profile)
    ├── home_screen.dart      # Consumer crop feed & listing browser
    ├── map_screen.dart       # Google Maps screen with nearby farmer markers
    ├── route_map_screen.dart # Interactive delivery routes map (Polyline rendering)
    ├── orders_screen.dart    # Order list and fulfillment timeline
    ├── payment_screen.dart   # Checkout details and dummy payment UI
    ├── farmer_dashboard.dart # Farmer listings, inventory, and incoming orders dashboard
    └── company_dashboard.dart # Corporate analytics and demand visualization dashboard
```

---

## ⚙️ Getting Started & Setup Guide

### 1. Prerequisites
- **Flutter SDK:** `>= 3.11.1`
- **Dart SDK:** `>= 3.11.1`
- **Firebase CLI:** Installed and configured globally.

### 2. Step-by-Step Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<your-username>/smart_food_access.git
   cd smart_food_access
   ```

2. **Retrieve dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase Integration:**
   This project relies on Firebase for authentication and database management. To register your mobile environments:
   - Initialize FlutterFire in your directory:
     ```bash
     flutterfire configure
     ```
   - Download the generated `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and ensure they are placed in their respective platform directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Configure Google Maps API:**
   To use the interactive maps page:
   - Go to [Google Cloud Console](https://console.cloud.google.com/) and enable the **Maps SDK for Android** and **Maps SDK for iOS**.
   - Generate your API key.
   - **Android Config:** In `android/app/src/main/AndroidManifest.xml`, add your key:
     ```xml
     <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="YOUR_ANDROID_API_KEY_HERE"/>
     ```
   - **iOS Config:** In `ios/Runner/AppDelegate.swift`, register the key:
     ```swift
     GMSServices.provideAPIKey("YOUR_IOS_API_KEY_HERE")
     ```

5. **Run the Application:**
   Start your emulator or plug in your physical device, then run:
   ```bash
   flutter run
   ```

---

## 🤝 Contributing
Contributions are extremely welcome! Feel free to report issues, suggest new features, or submit pull requests.
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License
Distributed under the MIT License. See [LICENSE](LICENSE) for more details.
