# Healthcare App Architecture

## Folder Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart                    # Main app widget
│   ├── routes/                     # App routing
│   └── bindings/                   # Dependency injection
├── core/
│   ├── config/
│   │   ├── app_config.dart         # Environment config
│   │   └── hive_config.dart        # Hive setup
│   ├── constants/
│   │   ├── app_constants.dart      # Global constants
│   │   ├── api_constants.dart      # API endpoints
│   │   └── storage_keys.dart       # Hive box keys
│   ├── errors/
│   │   ├── exceptions.dart         # Custom exceptions
│   │   └── failures.dart           # Error handling
│   ├── network/
│   │   ├── api_client.dart         # HTTP client
│   │   └── network_info.dart       # Connectivity
│   ├── storage/
│   │   ├── hive_service.dart       # Hive operations
│   │   └── secure_storage.dart     # Sensitive data
│   ├── utils/
│   │   ├── validators.dart         # Input validation
│   │   ├── formatters.dart         # Data formatting
│   │   └── encryption.dart         # Data encryption
│   └── theme/
│       ├── app_theme.dart          # Theme configuration
│       └── app_colors.dart         # Color palette
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── controllers/
│   │       ├── pages/
│   │       └── widgets/
│   ├── doctor/
│   ├── patient/
│   ├── admin/
│   └── shared/
│       ├── widgets/                # Reusable widgets
│       └── models/                 # Shared models
└── generated/
    └── l10n/                       # Localization files
```

## Key Principles
- Clean Architecture with clear separation of concerns
- Feature-based organization for scalability
- Shared components for reusability
- Secure data handling with encryption
- Environment-based configuration