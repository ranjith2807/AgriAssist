# 🌾 AgriAssist AI - Smart Agricultural Management Platform

A comprehensive agricultural management platform built with React and Firebase, designed to help farmers optimize their crop production through data-driven insights and modern technology.

## 🚀 Live Demo
**Website:** [https://agriassest-ai.web.app](https://agriassest-ai.web.app)

## ✨ Features

### 🌱 **Core Agricultural Management**
- **Plant Health Monitoring**: AI-powered crop health assessment with scoring system
- **Pest & Disease Detection**: Image-based identification with treatment recommendations
- **Soil Analysis**: Comprehensive soil testing with fertilizer recommendations
- **Irrigation Scheduling**: Smart water management and scheduling system
- **Fertilizer Management**: Application tracking and optimization
- **Yield Predictions**: Data-driven crop yield forecasting
- **Weather Integration**: Real-time weather data and agricultural alerts

### 🏪 **Marketplace & Commerce**
- **Direct Farmer-to-Buyer Platform**: Eliminate middlemen and increase profits
- **Product Management**: Easy listing and inventory management
- **Order Processing**: Complete order lifecycle management
- **Analytics Dashboard**: Sales insights and performance metrics

### 📊 **Data & Analytics**
- **Farm Inventory**: Track seeds, fertilizers, equipment, and supplies
- **Expert Consultation**: Connect with agricultural experts
- **Market Intelligence**: Real-time crop prices and market trends
- **Financial Tracking**: Monitor expenses, revenue, and profitability

## 🏗️ Technology Stack

### **Frontend**
- **Framework**: React.js with modern hooks
- **Build Tool**: Vite (fast development & optimized builds)
- **Styling**: Tailwind CSS (utility-first styling)
- **Charts**: Recharts (data visualization)
- **State Management**: React Context API

### **Backend & Database**
- **Database**: Firebase Firestore (NoSQL, real-time)
- **Authentication**: Firebase Auth (secure user management)
- **Storage**: Firebase Storage (file uploads)
- **Hosting**: Firebase Hosting (global CDN)

### **Development Tools**
- **Package Manager**: npm
- **Linting**: ESLint
- **Deployment**: Firebase CLI

## 📁 Project Structure

```
agriassist-ai/
├── 📂 src/                    # Frontend source code
│   ├── 📂 components/         # Reusable UI components
│   │   ├── 📂 auth/          # Authentication components
│   │   └── 📂 marketplace/   # Marketplace components
│   ├── 📂 pages/             # Application pages
│   ├── 📂 services/          # API and business logic
│   ├── 📂 hooks/             # Custom React hooks
│   └── 📂 config/            # Configuration files
├── 📂 backend/               # Backend services (Node.js)
├── 📂 docs/                  # 📚 Organized Documentation
│   ├── 📂 workflow/          # Development progress & milestones
│   ├── 📂 guides/            # Setup & configuration guides
│   ├── 📂 troubleshooting/   # Error fixes & solutions
│   └── 📂 architecture/      # System design & database schema
├── 📂 tools/                 # 🛠️ Development Tools
│   ├── 📂 scripts/           # Automation scripts
│   └── 📂 testing/           # Testing & debugging tools
└── 📂 public/               # Static assets
```

## 🚀 Quick Start

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- Firebase account

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/agriassist-ai.git
cd agriassist-ai
```

2. **Install dependencies:**
```bash
npm install
```

3. **Firebase Setup:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Firestore, Authentication, and Hosting
   - Copy your Firebase config to `.env` file
   - Follow detailed setup: [`docs/guides/FIREBASE_SETUP_GUIDE.md`](docs/guides/FIREBASE_SETUP_GUIDE.md)

4. **Start development server:**
```bash
npm run dev
```

5. **Build for production:**
```bash
npm run build
npm run deploy
```

## 📚 Documentation

### 📖 **For New Developers**
- [Firebase Setup Guide](docs/guides/FIREBASE_SETUP_GUIDE.md)
- [System Architecture](docs/architecture/DATABASE_SCHEMA.md)
- [Authentication System](docs/architecture/AUTHENTICATION_SYSTEM.md)

### 🔧 **For Troubleshooting**
- [Authentication Errors](docs/troubleshooting/AUTHENTICATION_ERROR_FIX.md)
- [Network Issues](docs/troubleshooting/NETWORK_REQUEST_FAILED_FIX.md)
- [OTP Problems](docs/troubleshooting/OTP_PERMISSIONS_FIX.md)

### 🚀 **For Deployment**
- [Deployment Guide](docs/guides/DEPLOYMENT_GUIDE.md)
- [Final Deployment Summary](docs/workflow/FINAL_DEPLOYMENT_SUMMARY.md)

### 📋 **Complete Documentation Index**
See [`docs/README.md`](docs/README.md) for the complete documentation structure and navigation guide.

## 🛠️ Development Tools

### **Project Planning & Design**
- **Idea to Design Generator** - Convert natural language project ideas into structured requirements and design documents
  - **CLI Tool**: `tools/scripts/idea-to-design-generator.js` - Interactive command-line generator
  - **Web Interface**: `/idea-to-design` - User-friendly web-based wizard
  - **Documentation**: `docs/workflow/idea-to-design-flow.md` - Complete methodology guide

### **Automation Scripts** (`tools/scripts/`)
- `setup-firebase.js` - Firebase configuration automation
- `deploy.js` - Deployment automation
- `verify-auth-config.js` - Authentication verification
- `idea-to-design-generator.js` - Requirements and design document generator

### **Testing Tools** (`tools/testing/`)
- Various HTML testing interfaces for different features
- JavaScript testing utilities for Firebase services
- Debugging and diagnostic tools

## 🌟 Key Features Implemented

### ✅ **Authentication System**
- Email/Password authentication with OTP verification
- Secure user session management
- Password reset functionality

### ✅ **Agricultural Management**
- Complete CRUD operations for all agricultural data
- Real-time data synchronization
- User-specific data isolation

### ✅ **Marketplace Integration**
- Farmer and buyer interfaces
- Product management and ordering
- Analytics and reporting

### ✅ **Mobile-First Design**
- Responsive design for all screen sizes
- Progressive Web App capabilities
- Optimized for rural internet conditions

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support & Contact

- **Documentation**: Check [`docs/`](docs/) directory for comprehensive guides
- **Issues**: Open a GitHub issue for bug reports or feature requests
- **Email**: support@agriassist.ai
- **Community**: Join our Discord server for discussions

## 🏆 Project Status

**Status**: ✅ **Production Ready**  
**Version**: 1.0  
**Last Updated**: January 2026  
**Live Demo**: [https://agriassest-ai.web.app](https://agriassest-ai.web.app)

---

**Built with ❤️ for farmers worldwide** 🌾