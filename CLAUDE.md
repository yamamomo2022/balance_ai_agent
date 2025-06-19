# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Flutter App
```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build for release
flutter build apk
flutter build ios

# Run tests
flutter test

# Analyze code (linting)
flutter analyze

# Run a specific test file
flutter test test/widget_test.dart
```

### Node.js Backend (Genkit)
```bash
cd genkit

# Install dependencies
npm install

# Development commands
npm run build        # Build TypeScript
npm run build:watch  # Build TypeScript in watch mode
npm run lint         # Run ESLint
npm start           # Start the server (after building)

# Development workflow
npm run build && npm start
```

## Architecture Overview

### High-Level Structure
This is a Flutter mobile app with a Node.js backend that provides AI-powered lifestyle advice through Genkit/Gemini integration.

**Flutter App (`/lib/`):**
- **State Management**: Provider pattern with `UserProvider` and `LifestyleProvider`
- **Authentication Flow**: Firebase Auth with dual mode support (authenticated users + guest mode)
- **Data Layer**: SQLite local database + REST API calls to Node.js backend
- **UI Flow**: AuthWrapper → LoginSignupPage OR ChatRoomPage (based on auth state)

**Node.js Backend (`/genkit/`):**
- **Framework**: Express.js with TypeScript
- **AI Integration**: Google Genkit with Gemini Pro 1.5 Flash
- **Authentication**: Firebase Admin SDK for JWT token verification
- **API**: Single `/chat` endpoint with Bearer token authentication

### Key Architectural Patterns

#### Dual Authentication System
The app supports both authenticated users and guest mode:
- `UserProvider.isLoggedIn` returns true for both authenticated users AND guest mode
- Guest mode bypasses Firebase Auth but still provides app functionality
- API calls include Firebase ID tokens when available, skip auth for guest users

#### Environment Configuration
- Uses `.env.development` and `.env.production` files
- Environment switching based on Flutter's `kReleaseMode` flag
- API server URL configurable via `API_SERVER` environment variable

#### AI Integration Flow
1. Flutter app sends user input + lifestyle context to `/chat` endpoint
2. Node.js backend verifies Firebase token (if provided)
3. Genkit processes the request through Gemini AI with lifestyle-aware prompts
4. Response flows back through the chain with structured JSON parsing

#### Data Storage Strategy
- **Local SQLite**: Stores lifestyle preferences (`goals`, `aspirations`) locally
- **No server-side persistence**: Chat history and lifestyle data remain on device
- **Firebase Auth**: Handles user authentication state only

#### Lifestyle-Aware Prompting
When user has lifestyle data, the app constructs enhanced prompts:
```
Goals: [user goals]
Aspirations: [user aspirations]
しかし，以下の逆効果のことをやろうとしてしまっています．願望と目標に沿った代替案を具体的に30字程度で提案してください．

[user input]
```

## Configuration Files

- **Flutter linting**: `analysis_options.yaml` (uses flutter_lints with custom rules)
- **Environment variables**: `.env.development` and `.env.production`
- **Firebase config**: `firebase_options.dart`, `GoogleService-Info.plist`, `google-services.json`
- **Node.js service account**: `genkit/service-account-key.json` (not in repo)

## Development Workflow Notes

- The Node.js backend must be running locally for the Flutter app to work in development
- Default backend URL is `http://127.0.0.1:4300`
- Firebase configuration is required for authentication features
- SQLite database is created automatically on first run
- Guest mode allows testing without Firebase setup