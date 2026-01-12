# AgriAssist AI - Agricultural Technology Platform

A comprehensive, production-ready React.js front-end application designed to serve diverse agricultural users from smallholder farmers to agricultural extension officers.

## Features

### Core Features Implemented

1. **Dashboard** - Overview with weather, crop health, and market prices
2. **Crop Disease Diagnosis** - Upload images to identify diseases and get treatment recommendations
3. **Weather Forecasts** - Real-time and 7-day weather forecasts with hourly data
4. **Soil Analysis** - Comprehensive soil testing with NPK levels and recommendations
5. **Pest Identification** - Identify pests from images and get treatment options
6. **Fertilizer Suggestions** - Personalized fertilizer recommendations by crop
7. **Irrigation Scheduling** - Manage irrigation schedules for multiple fields
8. **Market Prices** - Real-time commodity prices with trends and market news
9. **Plant Health Monitoring** - Track health status across all fields
10. **Yield Predictions** - AI-powered yield forecasts with historical trends
11. **Farm Inventory** - Track supplies, equipment, and manage stock levels
12. **Expert Consultation** - Book consultations with agricultural experts
13. **Profile Management** - Manage farmer profile and account settings

## Design Philosophy

- **Accessibility First**: Large touch targets, readable typography, high contrast
- **Green & Earthy Palette**: Primary green colors (#16a34a) with earthy tones
- **Dual Mode Navigation**: Simple view for basic users, Advanced view for detailed analytics
- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **Progressive Disclosure**: Advanced features accessible but not overwhelming

## Technology Stack

- **React 18** - UI library
- **React Router** - Navigation and routing
- **Tailwind CSS** - Utility-first styling
- **Vite** - Build tool and dev server
- **Lucide React** - Icon library
- **Recharts** - Data visualization

## Getting Started

### Prerequisites

- Node.js 16+ and npm

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm preview
```

The development server will start on `http://localhost:3000` (or next available port) and automatically open in your browser.

## Project Structure

```
agriassistai/
├── src/
│   ├── components/       # Reusable components
│   │   ├── Layout.jsx
│   │   ├── Header.jsx
│   │   ├── Sidebar.jsx
│   │   ├── MobileMenu.jsx
│   │   ├── WeatherWidget.jsx
│   │   └── MarketPricesWidget.jsx
│   ├── pages/           # Page components
│   │   ├── Dashboard.jsx
│   │   ├── CropDisease.jsx
│   │   ├── Weather.jsx
│   │   ├── SoilAnalysis.jsx
│   │   ├── PestIdentification.jsx
│   │   ├── FertilizerSuggestions.jsx
│   │   ├── IrrigationScheduling.jsx
│   │   ├── MarketPrices.jsx
│   │   ├── PlantHealth.jsx
│   │   ├── YieldPredictions.jsx
│   │   ├── FarmInventory.jsx
│   │   ├── ExpertConsultation.jsx
│   │   └── Profile.jsx
│   ├── App.jsx          # Main app component with routing
│   ├── main.jsx         # Entry point
│   └── index.css        # Global styles
├── index.html
├── package.json
├── vite.config.js
└── tailwind.config.js
```

## Key Design Decisions

1. **Simple/Advanced View Toggle**: Allows users to switch between simplified and detailed views
2. **Mobile-First Approach**: Responsive design with touch-friendly interfaces
3. **Consistent Color Coding**: Green for positive, yellow for warnings, red for alerts
4. **Clear Visual Hierarchy**: Important information prominently displayed
5. **Helpful Tooltips and Guidance**: Supports users with varying technical backgrounds

## Accessibility Features

- Semantic HTML elements
- ARIA labels where needed
- Keyboard navigation support
- High contrast ratios
- Large touch targets (minimum 44x44px)
- Readable font sizes (minimum 16px)

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Future Enhancements

- Backend API integration
- Real-time data updates
- Push notifications
- Offline mode support
- Multi-language support
- Data export functionality

## License

This project is created for AgriAssist AI platform.

