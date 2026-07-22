# 🏥 Rafiq (رفيق) — Digital Healthcare & Telemedicine Ecosystem

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-4CAF50?style=for-the-badge)
![State Management](https://img.shields.io/badge/State--Management-BLoC%20%2F%20Cubit-FF9800?style=for-the-badge)
![Database](https://img.shields.io/badge/Database-ObjectBox%20%2B%20Hive-009688?style=for-the-badge)
![Video Calls](https://img.shields.io/badge/Telehealth-Agora%20RTC-00A8FF?style=for-the-badge)
![Payments](https://img.shields.io/badge/Payments-Stripe-6772E5?style=for-the-badge)
![Backend](https://img.shields.io/badge/Backend-Dockerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)

<p align="center">
  <b>Rafiq (رفيق)</b> is a comprehensive, production-grade cross-platform mobile healthcare ecosystem built with <b>Flutter</b> and <b>Clean Architecture</b>. Designed as a complete telehealth companion, Rafiq seamlessly bridges the gap between patients and medical professionals—offering real-time video consultations, AI-powered health assistance, smart encrypted medication reminders, digital lab diagnostics, and secure online payments.
</p>

</div>

---

## 📋 Table of Contents

- [Features Breakdown](#-features-breakdown)
- [Tech Stack & Dependencies](#-tech-stack--dependencies)
- [Architecture Overview](#-architecture-overview)
- [Backend & Docker Setup](#-backend--docker-setup)
- [Project Directory Structure](#-project-directory-structure)
- [Getting Started](#-getting-started)
- [Useful Commands](#-useful-commands)
- [License](#-license)

---

## ✨ Features Breakdown

Rafiq is equipped with a rich set of modules tailored for both **Patients** and **Doctors**:

### 👨‍⚕️ Doctor Discovery & Telehealth Consultations
* **Smart Doctor Search:** Filter doctors by medical specialization, consultation fees, ratings, and availability.
* **Detailed Profiles:** View doctor credentials, biography, work experience, and pricing details.
* **Real-time HD Video & Audio Calls:** Powered by the **Agora RTC Engine**, enabling seamless virtual appointments with preview controls (mute, camera toggle, flip).
* **Slot Reservation System:** Real-time appointment booking with temporary slot holding and confirmation.

### 🤖 AI Health Chatbot & Voice Assistant
* **Interactive AI Assistant:** Built-in health bot to provide quick health answers and guidance.
* **Voice Messaging:** Record, send, and playback audio messages natively using `record` and `audioplayers`.

### 💊 Smart Medication Tracker & Reminders
* **Offline Caching & Sync:** Local storage powered by **ObjectBox** and **Hive** for high-speed offline access.
* **Medication Encryption:** Client-side cryptography for sensitive health data.
* **Group Management:** Organize medications into custom categories or treatment plans.
* **Local Notifications & Background Tasks:** Schedules exact medication reminders via `flutter_local_notifications` and `workmanager`.

### 🧪 Digital Lab Tests & Diagnostics Hub
* **Lab Test Upload & Processing:** Upload digital lab reports and track test result histories.
* **Diagnostic Confirmations:** Review, update, and manage diagnostic results directly in the app.

### 💳 Secure Payments Integration
* **Stripe Payment Gateway:** Fully integrated with `flutter_stripe` for safe consultation bookings and service payment flows.

### 🔐 Dual Onboarding & Security
* **Multi-Role Authentication:** Dedicated onboarding flows for Patients and Doctors.
* **Doctor Credential Verification:** Doctor ID upload step during signup for license verification.
* **Authentication Options:** Google Sign-In, OTP verification via Pinput, and token/cookie management.

### ⭐ Feedback & Ratings
* **Patient Reviews:** Leave star ratings and written reviews after completed consultations.

---

## 🛠️ Tech Stack & Dependencies

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) (SDK ^3.8.1) | Cross-platform mobile development (Android & iOS) |
| **Language** | [Dart](https://dart.dev) (SDK ^3.8.1) | Strongly typed Dart programming |
| **State Management** | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) & [`bloc`](https://pub.dev/packages/bloc) | Predictable state management via BLoC / Cubit |
| **Dependency Injection** | [`get_it`](https://pub.dev/packages/get_it) | Service locator pattern for clean dependency injection |
| **Networking** | [`dio`](https://pub.dev/packages/dio), [`dio_cookie_manager`](https://pub.dev/packages/dio_cookie_manager) | HTTP client with cookie management & refresh interceptors |
| **Real-time Media** | [`agora_rtc_engine`](https://pub.dev/packages/agora_rtc_engine) | Real-time video & audio consultations |
| **Local Storage** | [`objectbox`](https://pub.dev/packages/objectbox), [`hive`](https://pub.dev/packages/hive) | High-performance local NoSQL database & offline storage |
| **Payments** | [`flutter_stripe`](https://pub.dev/packages/flutter_stripe) | Stripe payment SDK integration |
| **Auth & Security** | [`google_sign_in`](https://pub.dev/packages/google_sign_in), [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage), [`cryptography`](https://pub.dev/packages/cryptography) | Authentication, encrypted local data, secure tokens |
| **Audio Processing** | [`record`](https://pub.dev/packages/record), [`audioplayers`](https://pub.dev/packages/audioplayers), [`ffmpeg_kit_flutter_new`](https://pub.dev/packages/ffmpeg_kit_flutter_new) | Voice note recording, audio playback, audio processing |
| **Notifications** | [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications), [`workmanager`](https://pub.dev/packages/workmanager) | Scheduled pill reminders & background tasks |
| **UI Scalability** | [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil) | Dynamic screen scaling & responsive layouts |

---

## 🏗️ Architecture Overview

The project adheres strictly to **Clean Architecture** principles and **Feature-First Project Structure**, ensuring high maintainability, testability, and separation of concerns:

```text
lib/
├── core/                       # Shared modules, core utilities, & app infra
│   ├── constants/              # App constants & secure key storage
│   ├── database/               # ObjectBox & Hive DB initialization
│   ├── di/                     # GetIt dependency injection registry
│   ├── errors/                 # Standardized Failure & Exception classes
│   ├── networking/             # Dio client, API endpoints, interceptors
│   ├── router/                 # App Router & Route definitions
│   ├── services/               # Notification & Background services
│   ├── theme/                  # Color tokens, typography, and themes
│   └── widgets/                # Reusable UI components & buttons
│
└── features/                   # Feature-based modular architecture
    ├── auth/                   # Authentication (Login, Register, OTP, Google Sign-In)
    ├── call/                   # Agora Video/Voice call preview & room management
    ├── chat_bot/               # AI chatbot, voice recording & playback
    ├── consultation/           # Consultation booking & details lifecycle
    ├── doctor_discovery/       # Search doctors, view slots, reserve appointments
    ├── doctor_profile/         # Doctor self-profile management (Bio, Pricing, Experience)
    ├── feedback/               # Ratings & review system
    ├── groups/                 # Medication grouping logic
    ├── home/                   # Dashboard & Quick action screens
    ├── lab_test/               # Lab test uploading & results management
    ├── landing/                # Onboarding & Welcome screens
    ├── medications/            # Offline-first medication management & reminders
    ├── payment/                # Stripe checkout & payment confirmation
    └── schedule/               # Doctor weekly schedule planner
```

Each feature module is organized into three distinct layers:
1. **Data Layer:** Remote Data Sources, Services, ObjectBox Local Data Sources, DTO Models, and Repository implementations.
2. **Domain Layer:** Pure Dart entities, Repository interfaces, and explicit Use Cases (`Either<Failure, T>`).
3. **Presentation Layer:** BLoC / Cubit state management controllers, state classes, UI screens, and custom widgets.

---

## 🐳 Backend & Docker Setup

The backend services for **Rafiq** run locally inside **Docker** containers. 

> [!IMPORTANT]
> **Notice for Developers & Evaluators:**
> The backend Docker configuration files (`docker-compose.yml` / `.yaml`) are managed by the backend team. You will need to request these files directly from the backend team before running the backend locally.

### 1. Prerequisites
Ensure you have **Docker** and **Docker Compose** installed on your system:
* **Windows / macOS:** Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* **Linux:** Install `docker-ce` and the `docker-compose-plugin`:
  ```bash
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  ```

### 2. Obtaining & Running the Docker Containers
1. Request the `docker-compose.yml` file from the backend development team and place it in your local backend working directory.
2. Open a terminal in that directory and pull the required Docker images:
   ```bash
   docker compose pull
   ```
3. Start the backend services in detached mode:
   ```bash
   docker compose up -d
   ```
4. Verify that all container services (API server, Database, Redis, etc.) are running cleanly:
   ```bash
   docker ps
   ```

### 3. Configuring the Flutter App Backend URL
Once the Docker containers are running, update the base URL in the Flutter codebase to target your local server:

1. Open [`lib/core/networking/api_constants.dart`](file:///home/waellasheen/FlutterProjects/G.P/rafiq/lib/core/networking/api_constants.dart).
2. Update `baseURL` with your local IP address or host:
   ```dart
   class ApiConstants {
     // Add you physical device IP "Laptop or Computer not phone 👀"
     static const String baseURL = "http://<YOUR_LOCAL_IP>:8030";
     // Example
     // static const String baseURL = "http://192.168.0.104:8030";
   }
   ```

---

## 🚀 Getting Started

Follow these steps to set up and run the Rafiq mobile application on your local device or emulator.

### 1. Prerequisites
* **Flutter SDK:** ^3.8.1 ([Installation Guide](https://docs.flutter.dev/get-started/install))
* **Dart SDK:** ^3.8.1 (Bundled with Flutter)
* **Android Studio** or **VS Code** with Flutter & Dart plugins installed
* **Android SDK** (for Android testing) or **Xcode** (for iOS testing on macOS)

### 2. Clone the Repository
```bash
git clone https://github.com/Rafiq-Health-Care/rafiq-mobile.git
cd rafiq
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run Code Generation (ObjectBox DB & Models)
Rafiq uses ObjectBox for high-performance local caching. Run `build_runner` to generate the required ObjectBox database bindings:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Launch the Application
Ensure an active emulator or physical device is connected:
```bash
# Check connected devices
flutter devices

# Run the app in debug mode
flutter run
```

---

## ⚙️ Useful Commands & Scripts

Here is a quick reference for common commands used during development:

| Action | Command |
| :--- | :--- |
| **Get Dependencies** | `flutter pub get` |
| **Run Code Generator** | `flutter pub run build_runner build --delete-conflicting-outputs` |
| **Watch Code Generator** | `flutter pub run build_runner watch --delete-conflicting-outputs` |
| **Generate App Icons** | `flutter pub run flutter_launcher_icons` |
| **Run Linter Checks** | `flutter analyze` |
| **Run Unit Tests** | `flutter test` |
| **Clean Build Cache** | `flutter clean && flutter pub get` |

---

## 📄 License

This project is developed as part of a Graduation Project (**G.P**). All rights reserved.

<div align="center">
  <sub>Built with ❤️ for modern digital healthcare accessibility.</sub>
</div>
