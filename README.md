# Witte Dental Practice Management System (PMS)

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white" alt="Laravel">
  <img src="https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
</div>

## 🏥 Overview

Witte Dental PMS is a comprehensive, multi-tenant SaaS solution designed specifically for dental practice management. Built with Flutter for cross-platform mobile applications and Laravel for robust backend services, it provides a complete ecosystem for managing dental clinics, hospitals, and multi-location practices.

## ✨ Key Features

### 🔐 Multi-Level Authentication System
- **Super Admin**: Platform-wide management for Witte company employees
- **Business Admin**: Hospital/clinic owners with business management capabilities
- **Staff Access**: Unified login for Doctors, Staff, and Patients with role-based permissions

### 📊 Comprehensive Dashboard System
- **Business Dashboard**: Overview of all hospital branches with key metrics
- **Hospital Dashboard**: Individual hospital analytics with real-time KPIs
- **Appointment Delay Tracking**: Monitor and manage appointment delays
- **Revenue Analytics**: Financial insights and payment statistics

### 🏥 Multi-Hospital Management
- Support for multiple hospital branches under one business
- Individual hospital settings and configurations
- Centralized patient and staff management across locations

### 👥 User Management
- **Patient Management**: Complete patient records and history
- **Doctor Management**: Staff scheduling and performance tracking
- **Staff Management**: Role-based access control
- **Appointment Scheduling**: Advanced booking system with delay notifications

### 💳 Integrated Payment System
- Razorpay integration for secure payments
- Payment tracking and collection analytics
- Billing and invoice management

### 📱 Communication Features
- WhatsApp integration for patient notifications
- Automated appointment reminders
- Real-time updates and alerts

## 🏗️ Architecture

### Frontend (Flutter)
```
lib/
├── app/
│   └── routes/                 # App routing configuration
├── core/
│   ├── constants/             # App constants and configurations
│   ├── controllers/           # Global state management
│   ├── services/              # API services and utilities
│   ├── storage/               # Local data storage (Hive)
│   └── theme/                 # App theming and styling
├── features/
│   ├── auth/                  # Authentication module
│   ├── admin/                 # Admin dashboard and management
│   ├── dashboard/             # Hospital dashboards
│   ├── doctors/               # Doctor management
│   ├── patients/              # Patient management
│   └── shared/                # Shared widgets and components
└── main.dart                  # App entry point
```

### Backend (Laravel)
- RESTful API architecture
- Multi-tenant database design
- JWT authentication
- Role-based access control
- Real-time notifications

## 🚀 App Workflow

### 1. Authentication Flow

#### Super Admin Login
```
/api/superadmin/login
├── Platform-wide access
├── Business management
├── Subscription oversight
└── System administration
```

#### Business Admin Login
```
/api/admin/login
├── Business dashboard access
├── Hospital management
├── Staff and patient oversight
└── Financial analytics
```

#### Staff/Doctor/Patient Login
```
/api/login
├── Role-based dashboard
├── Hospital-specific access
├── Appointment management
└── Patient records (role-dependent)
```

### 2. Dashboard Navigation

#### Business Admin Workflow
```
Business Dashboard
├── Overview Statistics
│   ├── Total Hospitals: 2
│   ├── Total Patients: 150+
│   ├── Staff Members: 25+
│   └── Today's Appointments: 45
├── Hospital Branches
│   ├── Main Branch (⭐)
│   │   └── Click → Hospital Dashboard
│   └── Branch Locations
│       └── Click → Individual Analytics
└── Business Management
    ├── Settings Configuration
    ├── Payment Integration
    └── WhatsApp Setup
```

#### Hospital Dashboard Workflow
```
Hospital Dashboard (/api/dashboard/home?hospital_id=1)
├── Real-time KPIs
│   ├── Patient Statistics
│   ├── Appointment Metrics
│   ├── Revenue Analytics
│   └── Staff Performance
├── Appointment Management
│   ├── Today's Schedule
│   ├── Upcoming Appointments
│   └── Delay Tracking
├── Patient Analytics
│   ├── Demographics
│   ├── Retention Rates
│   └── Treatment History
└── Financial Insights
    ├── Monthly Revenue
    ├── Payment Collection
    └── Outstanding Dues
```

### 3. User Management Flow

#### Patient Management
```
Patient Module
├── Registration
│   ├── Personal Information
│   ├── Medical History
│   └── Contact Details
├── Appointment Booking
│   ├── Doctor Selection
│   ├── Time Slot Booking
│   └── Treatment Planning
└── Records Management
    ├── Treatment History
    ├── Billing Records
    └── Communication Logs
```

#### Doctor/Staff Management
```
Staff Module
├── Profile Management
│   ├── Credentials
│   ├── Specializations
│   └── Schedule Settings
├── Appointment Management
│   ├── Daily Schedule
│   ├── Patient Consultations
│   └── Treatment Plans
└── Performance Analytics
    ├── Patient Satisfaction
    ├── Appointment Statistics
    └── Revenue Contribution
```

### 4. Appointment Delay Management

```
Delay Tracking System
├── Real-time Monitoring
│   ├── Scheduled vs Actual Times
│   ├── Delay Notifications
│   └── Patient Communication
├── Analytics Dashboard
│   ├── On-time Percentage: 85%
│   ├── Average Delay: 15 minutes
│   └── Peak Delay Hours
└── Automated Actions
    ├── WhatsApp Notifications
    ├── Rescheduling Options
    └── Compensation Tracking
```

### 5. Payment Integration Workflow

```
Payment System (Razorpay)
├── Configuration
│   ├── API Key Setup
│   ├── Webhook Configuration
│   └── Security Settings
├── Transaction Processing
│   ├── Online Payments
│   ├── Payment Tracking
│   └── Receipt Generation
└── Analytics
    ├── Collection Rates: 85%
    ├── Pending Payments
    └── Revenue Trends
```

## 🛠️ Technical Implementation

### State Management
- **GetX**: Reactive state management
- **Obx Widgets**: Real-time UI updates
- **Controllers**: Business logic separation

### Data Persistence
- **Hive**: Local storage for offline capability
- **Token Management**: Secure authentication persistence
- **Cache Strategy**: Optimized data loading

### API Integration
- **Dio**: HTTP client with interceptors
- **Error Handling**: Comprehensive error management
- **Retry Logic**: Network resilience

### UI/UX Features
- **Theme System**: Light/Dark mode support
- **Responsive Design**: Adaptive layouts
- **Material Design**: Modern UI components
- **Custom Colors**: Brand-consistent theming

## 🎨 Design System

### Color Palette
```dart
Primary Colors:
- Sea Blue: Color(0xFF07BDFF)
- Deep Blue: Color(0xFF145BD9)

Theme Integration:
- Automatic theme adaptation
- Context-aware color usage
- Accessibility compliance
```

### Typography
- Material Design typography scale
- Theme-aware text styling
- Consistent font weights and sizes

## 🔧 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio / VS Code
- Laravel Backend Setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/witte-dental-pms.git
   cd witte-dental-pms
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoints**
   ```dart
   // lib/core/constants/api_constants.dart
   static const String baseUrl = 'http://your-api-url.com';
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 📱 User Experience Features

### Navigation
- **Double-tap to exit**: Prevents accidental app closure
- **Logout confirmation**: Secure session management
- **Role-based routing**: Automatic dashboard selection

### Offline Capability
- **Local data caching**: Hive storage integration
- **Sync on reconnection**: Automatic data synchronization
- **Offline indicators**: Clear connectivity status

### Performance Optimizations
- **Lazy loading**: Efficient memory usage
- **Image caching**: Faster load times
- **Background sync**: Seamless data updates

## 🔒 Security Features

- **JWT Authentication**: Secure token-based auth
- **Role-based Access**: Granular permission control
- **Data Encryption**: Sensitive data protection
- **Session Management**: Automatic timeout handling

## 📊 Analytics & Reporting

### Business Intelligence
- **Revenue Analytics**: Financial performance tracking
- **Patient Demographics**: Population insights
- **Appointment Analytics**: Scheduling efficiency
- **Staff Performance**: Productivity metrics

### Real-time Dashboards
- **Live KPIs**: Instant metric updates
- **Interactive Charts**: Visual data representation
- **Export Capabilities**: Data export options

## 🚀 Future Enhancements

- [ ] **Telemedicine Integration**: Video consultation support
- [ ] **AI-powered Analytics**: Predictive insights
- [ ] **Multi-language Support**: Localization features
- [ ] **Advanced Reporting**: Custom report builder
- [ ] **Mobile Payments**: Enhanced payment options
- [ ] **Patient Portal**: Self-service capabilities

## 🤝 Contributing

We welcome contributions! Please read our contributing guidelines and submit pull requests for any improvements.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and queries:
- Email: support@witte.com
- Documentation: [docs.witte.com](https://docs.witte.com)
- Issues: [GitHub Issues](https://github.com/your-repo/issues)

---

<div align="center">
  <p><strong>Built with ❤️ for the dental community</strong></p>
  <p>© 2026 Witte Dental Solutions. All rights reserved.</p>
</div>