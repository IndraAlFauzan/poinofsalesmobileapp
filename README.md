# 📱 POS Mobile - Point of Sale Application

[![Flutter](https://img.shields.io/badge/Flutter-3.8.0-02569B.svg?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.0-0175C2.svg?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Private-red.svg)](LICENSE)

A comprehensive Point of Sale (POS) mobile application built with Flutter, featuring modern clean architecture, state management with BLoC pattern, and a complete order-to-payment workflow system.

## 🌟 Features

### 🛍️ Product & Order Management

- **Product Catalog**: Browse products with categories, flavors, and spicy levels
- **Shopping Cart**: Real-time cart management with item customization
- **Order Creation**: Create orders with customer details and table assignments
- **Pending Orders**: View and manage pending orders before payment
- **Order Editing**: Modify existing orders before payment settlement

### 💳 Payment System

- **Multi-Payment Methods**: Support for cash, card, and digital payments
- **Payment Settlement**: Process single or multiple orders in one transaction
- **Change Calculation**: Real-time change amount calculation for cash payments
- **Payment History**: Complete transaction history with detailed records
- **Receipt Generation**: Digital receipt preview and print functionality

### 🎯 Core Business Features

- **Table Management**: Assign orders to specific tables
- **Customer Management**: Track customer information per order
- **Service Types**: Support for dine-in, takeaway, and delivery
- **Transaction Tracking**: Complete order lifecycle from creation to payment
- **Real-time Updates**: Live updates across all modules

### 🔐 Authentication & Security

- **Secure Login**: JWT-based authentication
- **Session Management**: Secure token storage with flutter_secure_storage
- **User Authorization**: Role-based access control

## 🏗️ Architecture

This application follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── main.dart                          # Application entry point
├── bloc/                              # State Management (BLoC)
│   ├── cart/                          # Shopping cart management
│   ├── category/                      # Product categories
│   ├── flavor/                        # Product flavors
│   ├── payment_method/                # Payment methods
│   ├── payment_settlement/            # Payment processing
│   ├── pending_transaction/           # Pending orders
│   ├── product/                       # Product catalog
│   └── spicylevel/                    # Spice levels
├── data/                              # Data Layer
│   ├── model/                         # Data models & DTOs
│   │   ├── request/                   # API request models
│   │   └── response/                  # API response models
│   └── repository/                    # Repository implementations
├── presentations/                     # Presentation Layer
│   ├── dashboard/                     # Main dashboard
│   │   ├── main_page.dart            # Dashboard navigation
│   │   ├── product/                   # Product management
│   │   ├── transaction/               # Transaction features
│   │   │   ├── addtransaction/        # Order creation
│   │   │   └── historytransaction/    # Transaction history
│   │   └── payment/                   # Payment features
│   │       ├── paymentpage/           # Payment processing
│   │       └── payment_history/       # Payment history
│   └── login/                         # Authentication
├── service/                           # External Services
│   └── service.dart                   # HTTP client configuration
├── shared/                            # Shared Components
│   ├── config/                        # App configuration
│   ├── constants/                     # Constants & themes
│   └── widgets/                       # Reusable UI components
└── dependencies_injection/            # Dependency Injection
    └── dependencies_injection.dart    # Service locator setup
```

## 🛠️ Tech Stack

### Core Technologies

- **Flutter SDK**: `^3.8.0` - Cross-platform UI framework
- **Dart**: `^3.8.0` - Programming language
- **flutter_bloc**: `^9.1.1` - State management
- **freezed**: `^3.2.0` - Code generation for immutable classes
- **get_it**: `^8.2.0` - Dependency injection

### Key Dependencies

- **HTTP Client**: `http: ^1.5.0` - API communication
- **Storage**: `flutter_secure_storage: ^9.2.4` - Secure token storage
- **Functional Programming**: `dartz: ^0.10.1` - Either type for error handling
- **UI Components**:
  - `animated_custom_dropdown: ^3.1.1` - Custom dropdowns
  - `syncfusion_flutter_datagrid: ^30.2.4` - Data tables
  - `google_fonts: ^6.3.0` - Typography
  - `flutter_svg: ^2.0.10+1` - SVG support
- **Notifications**: `another_flushbar: ^1.12.30` - In-app notifications
- **Dialogs**: `giffy_dialog: ^2.3.0` - Animated dialogs
- **Formatting**:
  - `currency_text_input_formatter: ^2.3.0` - Currency input
  - `intl: ^0.20.2` - Internationalization
- **Printing**: `printing: ^5.13.2` - Receipt printing support

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.8.0`
- Dart SDK `^3.8.0`
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd posmobile
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code (BLoC + Freezed)**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Development Setup

For active development with automatic code generation:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

This command will automatically regenerate BLoC and Freezed files when you make changes to event and state files.

## 📋 API Integration

The application integrates with a backend REST API for:

### Authentication Endpoints

- `POST /login` - User authentication
- Token-based session management

### Product Management

- `GET /categories` - Product categories
- `GET /products` - Product catalog
- `GET /flavors` - Available flavors
- `GET /spicy-levels` - Spice level options

### Transaction Management

- `POST /transactions` - Create new transaction
- `GET /pending-transactions` - Fetch pending orders
- `PUT /transactions/{id}` - Update existing transaction

### Payment Processing

- `GET /payment-methods` - Available payment methods
- `POST /payment-settlements` - Process payments
- `GET /payments` - Payment history

### Utility Endpoints

- `GET /tables` - Table management

## 🎨 UI/UX Features

### Design System

- **Material Design 3** principles
- **Custom Color Palette** with primary branding
- **Consistent Typography** using Google Fonts
- **Responsive Layout** for various screen sizes
- **Dark/Light Mode** support (configurable)

### User Experience

- **Intuitive Navigation** with bottom navigation and sidebar
- **Real-time Feedback** with loading states and animations
- **Error Handling** with user-friendly messages
- **Haptic Feedback** for enhanced interaction
- **Offline Support** with local caching (planned)

### Key UI Components

- **Custom Dropdowns** with search functionality
- **Interactive Data Tables** for transaction history
- **Modern Card Layouts** for product and order display
- **Progressive Dialogs** for multi-step processes
- **Receipt Preview** with print-ready formatting

## 🔧 State Management

The application uses **BLoC (Business Logic Component)** pattern with **Freezed** for immutable state management:

### BLoC Architecture Benefits

- **Separation of Concerns**: UI, business logic, and data layers are separated
- **Testability**: Each BLoC can be tested independently
- **Reusability**: BLoCs can be shared across multiple widgets
- **Predictable State**: Immutable states with clear state transitions

### Key BLoCs

- **AuthBloc**: Handles user authentication and session management
- **CartBloc**: Manages shopping cart state and operations
- **ProductBloc**: Handles product catalog and filtering
- **PaymentBloc**: Manages payment processing and methods
- **TransactionBloc**: Handles order creation and management

## 📱 Platform Support

### Current Support

- ✅ **Android** (Primary target)
- ✅ **iOS** (Secondary target)
- ✅ **Web** (Limited - for testing)

### Planned Support

- 🔄 **Windows** (Desktop POS)
- 🔄 **macOS** (Desktop POS)
- 🔄 **Linux** (Server deployment)

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure

```
test/
├── unit/                    # Unit tests
│   ├── bloc/               # BLoC tests
│   ├── repository/         # Repository tests
│   └── models/             # Model tests
├── widget/                 # Widget tests
└── integration/            # Integration tests
```

## 🔐 Security Features

- **Secure Token Storage**: JWT tokens stored using flutter_secure_storage
- **Input Validation**: Client-side validation for all forms
- **Error Handling**: Secure error messages without exposing sensitive data
- **Session Management**: Automatic logout on token expiration
- **API Security**: HTTPS-only communication with backend

## 🚀 Deployment

### Android Deployment

```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Deployment

```bash
# Build for iOS
flutter build ios --release
```

### Web Deployment

```bash
# Build for web
flutter build web --release
```

## 📝 Development Guidelines

### Code Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add documentation for public APIs
- Maintain consistent formatting with `dart format`

### BLoC Pattern Guidelines

- One BLoC per feature/domain
- Use Freezed for events and states
- Handle all possible states (loading, success, error)
- Keep BLoCs focused and single-responsibility

### Git Workflow

- Use feature branches for new features
- Write descriptive commit messages
- Create pull requests for code review
- Maintain clean commit history

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 Additional Documentation

- [📄 Print Receipt System Guide](PRINT_RECEIPT_GUIDE.md)
- [📄 Transaction System Documentation](TRANSACTION_SYSTEM_DOCS.md)
- API Documentation (See backend repository)

## 📞 Support

For support and questions:

- Create an issue in the repository
- Contact the development team
- Check the documentation files

## 📅 Roadmap

### Upcoming Features

- [ ] Offline mode with local database
- [ ] Inventory management
- [ ] Employee management and roles
- [ ] Advanced reporting and analytics
- [ ] Multi-language support
- [ ] Thermal printer integration
- [ ] Barcode scanning
- [ ] Customer loyalty program

---

**Built with ❤️ using Flutter**
