# AgriAssist AI - Comprehensive Database Schema

## Overview
This document describes the complete database schema for the AgriAssist AI agricultural management platform. The database is designed to support comprehensive farm management, crop monitoring, pest control, financial tracking, and expert consultation services.

## Technology Stack
- **Database**: SQLite with Prisma ORM
- **Backend**: Fastify with Node.js
- **Frontend**: React with Vite

## Database Models

### 🧑‍🌾 User Management

#### User
Core user information for farmers, experts, and administrators.
```prisma
model User {
  id          String   @id @default(cuid())
  email       String   @unique
  password    String
  name        String
  phone       String?
  address     String?
  role        String   @default("FARMER") // FARMER, EXPERT, ADMIN
  isActive    Boolean  @default(true)
  avatar      String?
  preferences String?  // JSON: User preferences
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

#### ExpertProfile
Extended profile information for agricultural experts.
```prisma
model ExpertProfile {
  id           String @id @default(cuid())
  userId       String @unique
  specialization String
  experience   Int    // years of experience
  rating       Float  @default(0)
  totalConsultations Int @default(0)
  hourlyRate   Float?
  bio          String?
  certifications String? // JSON: Array of certifications
  availability String?  // JSON: Available time slots
  isVerified   Boolean @default(false)
}
```

### 🚜 Farm Management

#### Farm
Top-level farm information containing multiple fields.
```prisma
model Farm {
  id          String   @id @default(cuid())
  name        String
  location    String
  totalArea   Float    // in hectares
  coordinates String?  // JSON: GPS coordinates
  userId      String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

#### FarmField
Individual field within a farm with specific crop information.
```prisma
model FarmField {
  id          String   @id @default(cuid())
  name        String
  cropType    String
  variety     String?
  areaHect    Float
  soilType    String?
  coordinates String?  // JSON: Field boundaries
  plantingDate DateTime?
  harvestDate DateTime?
  farmId      String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

### 🌱 Crop Management

#### CropVariety
Database of available crop varieties with characteristics.
```prisma
model CropVariety {
  id              String @id @default(cuid())
  name            String
  cropType        String
  description     String?
  growthDuration  Int    // days
  waterRequirement String
  soilRequirement String
  climateZone     String
  yieldPotential  Float
  resistantTo     String?  // JSON: Array of diseases/pests
  createdAt       DateTime @default(now())
}
```

#### CropHealth
Regular health monitoring records for crops.
```prisma
model CropHealth {
  id          String    @id @default(cuid())
  fieldId     String
  healthScore Float     // 0-100
  status      String    // Excellent, Good, Fair, Poor, Critical
  symptoms    String?   // JSON: Array of observed symptoms
  images      String?   // JSON: Array of image URLs
  notes       String?
  checkDate   DateTime  @default(now())
  checkedBy   String?
  
  // AI Analysis
  aiAnalysis  String?   // JSON: AI-generated analysis
  confidence  Float?    // AI confidence score
}
```

#### Harvest
Harvest records with quantity, quality, and financial data.
```prisma
model Harvest {
  id          String    @id @default(cuid())
  fieldId     String
  quantity    Float     // in kg or tons
  quality     String    // Grade A, B, C
  pricePerUnit Float?
  totalValue  Float?
  harvestDate DateTime
  laborCost   Float?
  notes       String?
  createdAt   DateTime  @default(now())
}
```

### 🌍 Soil & Environmental

#### SoilAnalysis
Comprehensive soil testing results and recommendations.
```prisma
model SoilAnalysis {
  id            String    @id @default(cuid())
  fieldId       String
  phLevel       Float
  nitrogen      Float     // ppm
  phosphorus    Float     // ppm
  potassium     Float     // ppm
  organicMatter Float     // percentage
  moisture      Float     // percentage
  temperature   Float?    // celsius
  salinity      Float?    // dS/m
  texture       String?   // Sandy, Clay, Loam, etc.
  recommendations String? // JSON: Fertilizer recommendations
  testMethod    String?   // Lab, Field kit, etc.
  labName       String?
  cost          Float?
  date          DateTime  @default(now())
}
```

#### WeatherData
Historical and current weather information.
```prisma
model WeatherData {
  id            String   @id @default(cuid())
  farmId        String
  temperature   Float    // celsius
  humidity      Float    // percentage
  rainfall      Float    // mm
  windSpeed     Float    // km/h
  windDirection String?
  pressure      Float?   // hPa
  uvIndex       Float?
  visibility    Float?   // km
  cloudCover    Float?   // percentage
  date          DateTime @default(now())
  source        String   @default("API") // API, Manual, Sensor
}
```

#### WeatherAlert
Weather-based alerts and warnings.
```prisma
model WeatherAlert {
  id          String   @id @default(cuid())
  userId      String
  alertType   String   // Rain, Drought, Storm, Frost, etc.
  severity    String   // Low, Medium, High, Critical
  message     String
  startDate   DateTime
  endDate     DateTime?
  isActive    Boolean  @default(true)
  isRead      Boolean  @default(false)
  createdAt   DateTime @default(now())
}
```

### 🐛 Pest & Disease Management

#### PestReport
Pest identification and treatment records.
```prisma
model PestReport {
  id            String   @id @default(cuid())
  userId        String
  pestName      String
  scientificName String?
  severity      String   // Low, Medium, High, Critical
  affectedArea  Float?   // percentage or hectares
  images        String?  // JSON: Array of image URLs
  symptoms      String?  // JSON: Array of symptoms
  location      String?  // JSON: GPS coordinates
  treatment     String?
  treatmentCost Float?
  detectedAt    DateTime @default(now())
  resolvedAt    DateTime?
  status        String   @default("Active") // Active, Treated, Resolved
  
  // AI Analysis
  aiIdentification String? // JSON: AI pest identification results
  confidence      Float?  // AI confidence score
}
```

#### DiseaseReport
Disease diagnosis and treatment tracking.
```prisma
model DiseaseReport {
  id            String   @id @default(cuid())
  userId        String
  diseaseName   String
  scientificName String?
  pathogenType  String?  // Fungal, Bacterial, Viral, etc.
  severity      String   // Low, Medium, High, Critical
  affectedArea  Float?   // percentage or hectares
  images        String?  // JSON: Array of image URLs
  symptoms      String?  // JSON: Array of symptoms
  location      String?  // JSON: GPS coordinates
  treatment     String?
  treatmentCost Float?
  analyzedAt    DateTime @default(now())
  resolvedAt    DateTime?
  status        String   @default("Active") // Active, Treated, Resolved
  
  // AI Analysis
  aiDiagnosis   String?  // JSON: AI disease diagnosis results
  confidence    Float?   // AI confidence score
}
```

#### TreatmentPlan
Standardized treatment protocols for pests and diseases.
```prisma
model TreatmentPlan {
  id          String @id @default(cuid())
  name        String
  description String
  targetPest  String?
  targetDisease String?
  steps       String   // JSON: Array of treatment steps
  duration    Int?     // days
  cost        Float?
  effectiveness Float? // percentage
  sideEffects String?  // JSON: Array of potential side effects
  createdAt   DateTime @default(now())
}
```

### 📦 Inventory & Supplies

#### InventoryItem
Comprehensive inventory management for farm supplies.
```prisma
model InventoryItem {
  id           String   @id @default(cuid())
  userId       String
  name         String
  category     String   // Seeds, Fertilizer, Pesticide, Tools, etc.
  subcategory  String?
  brand        String?
  description  String?
  quantity     Float
  unit         String   // kg, liters, pieces, bags, etc.
  unitPrice    Float?
  totalValue   Float?
  minThreshold Float
  maxThreshold Float?
  status       String   // In-Stock, Low-Stock, Out-of-Stock, Expired
  location     String?  // Storage location
  batchNumber  String?
  expiryDate   DateTime?
  supplier     String?
  lastRestocked DateTime?
  createdAt    DateTime @default(now())
  updatedAt    DateTime @updatedAt
}
```

#### InventoryTransaction
Track all inventory movements (purchases, usage, sales).
```prisma
model InventoryTransaction {
  id          String        @id @default(cuid())
  itemId      String
  type        String        // Purchase, Usage, Sale, Waste, Transfer
  quantity    Float
  unitPrice   Float?
  totalAmount Float?
  reason      String?
  reference   String?       // Invoice number, etc.
  date        DateTime      @default(now())
  notes       String?
}
```

#### Supplier
Supplier information and contact details.
```prisma
model Supplier {
  id          String @id @default(cuid())
  name        String
  contactPerson String?
  phone       String?
  email       String?
  address     String?
  products    String?  // JSON: Array of products they supply
  rating      Float?   @default(0)
  isActive    Boolean  @default(true)
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

### 💧 Fertilization & Irrigation

#### Fertilization
Fertilizer application records and results.
```prisma
model Fertilization {
  id          String    @id @default(cuid())
  fieldId     String
  fertilizerType String
  brand       String?
  quantity    Float     // kg or liters
  method      String    // Broadcasting, Foliar, Drip, etc.
  cost        Float?
  applicationDate DateTime
  nextDueDate DateTime?
  notes       String?
  weather     String?   // JSON: Weather conditions during application
  results     String?   // Observed results
  createdAt   DateTime  @default(now())
}
```

#### IrrigationLog
Detailed irrigation activity tracking.
```prisma
model IrrigationLog {
  id          String    @id @default(cuid())
  fieldId     String
  method      String    // Drip, Sprinkler, Flood, etc.
  duration    Int       // minutes
  waterAmount Float?    // liters or cubic meters
  pressure    Float?    // bar
  startTime   DateTime
  endTime     DateTime?
  cost        Float?    // water cost
  efficiency  Float?    // percentage
  soilMoistureBefore Float?
  soilMoistureAfter  Float?
  notes       String?
  automated   Boolean   @default(false)
  createdAt   DateTime  @default(now())
}
```

#### IrrigationSchedule
Automated irrigation scheduling system.
```prisma
model IrrigationSchedule {
  id          String @id @default(cuid())
  name        String
  description String?
  cropType    String
  frequency   String // Daily, Weekly, Bi-weekly, etc.
  duration    Int    // minutes per session
  startDate   DateTime
  endDate     DateTime?
  isActive    Boolean @default(true)
  schedule    String   // JSON: Detailed schedule configuration
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

### 🚜 Equipment & Machinery

#### Equipment
Farm equipment and machinery management.
```prisma
model Equipment {
  id            String @id @default(cuid())
  name          String
  type          String // Tractor, Harvester, Sprayer, etc.
  brand         String?
  model         String?
  serialNumber  String?
  purchaseDate  DateTime?
  purchasePrice Float?
  currentValue  Float?
  condition     String @default("Good") // Excellent, Good, Fair, Poor
  status        String @default("Available") // Available, In-Use, Maintenance, Broken
  location      String?
  fuelType      String? // Diesel, Petrol, Electric, etc.
  fuelCapacity  Float?
  userId        String
  farmId        String?
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
}
```

#### MaintenanceLog
Equipment maintenance and repair records.
```prisma
model MaintenanceLog {
  id          String    @id @default(cuid())
  equipmentId String
  type        String    // Routine, Repair, Inspection
  description String
  cost        Float?
  serviceProvider String?
  partsReplaced String?   // JSON: Array of parts
  nextDueDate DateTime?
  date        DateTime  @default(now())
  notes       String?
}
```

#### EquipmentUsage
Track equipment usage and operational costs.
```prisma
model EquipmentUsage {
  id          String    @id @default(cuid())
  equipmentId String
  operation   String    // Plowing, Harvesting, Spraying, etc.
  duration    Int       // hours
  fuelUsed    Float?    // liters
  areaWorked  Float?    // hectares
  operator    String?
  startTime   DateTime
  endTime     DateTime?
  cost        Float?    // operational cost
  notes       String?
}
```

### 💰 Financial Management

#### Transaction
Comprehensive financial transaction tracking.
```prisma
model Transaction {
  id          String   @id @default(cuid())
  userId      String
  type        String   // Income, Expense
  category    String   // Seeds, Fertilizer, Labor, Equipment, Sales, etc.
  subcategory String?
  amount      Float
  description String
  reference   String?  // Invoice number, receipt, etc.
  paymentMethod String? // Cash, Bank, Card, etc.
  date        DateTime @default(now())
  isRecurring Boolean  @default(false)
  recurringPattern String? // Monthly, Quarterly, etc.
  attachments String?  // JSON: Array of file URLs
  tags        String?  // JSON: Array of tags for categorization
  createdAt   DateTime @default(now())
}
```

#### Budget
Budget planning and tracking system.
```prisma
model Budget {
  id          String @id @default(cuid())
  name        String
  description String?
  totalAmount Float
  spentAmount Float  @default(0)
  category    String // Seeds, Fertilizer, Equipment, etc.
  period      String // Monthly, Quarterly, Yearly
  startDate   DateTime
  endDate     DateTime
  isActive    Boolean @default(true)
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

### 📈 Market & Sales

#### MarketPrice
Real-time market price tracking for crops.
```prisma
model MarketPrice {
  id        String   @id @default(cuid())
  crop      String
  variety   String?
  quality   String?  // Grade A, B, C
  price     Float    // per unit
  unit      String   @default("kg") // kg, ton, quintal
  change    Float    // percentage change
  trend     String   // up, down, stable
  market    String?  // Market name/location
  source    String?  // Data source
  date      DateTime @default(now())
}
```

#### Sale
Crop sales and revenue tracking.
```prisma
model Sale {
  id          String @id @default(cuid())
  crop        String
  variety     String?
  quantity    Float
  unit        String
  pricePerUnit Float
  totalAmount Float
  buyer       String?
  market      String?
  saleDate    DateTime
  paymentStatus String @default("Pending") // Pending, Partial, Paid
  paymentDate DateTime?
  commission  Float?
  transport   Float?
  netAmount   Float?
  notes       String?
  createdAt   DateTime @default(now())
}
```

### 👨‍🌾 Consultations & Expert System

#### Consultation
Expert consultation booking and management.
```prisma
model Consultation {
  id           String   @id @default(cuid())
  userId       String
  expertId     String?
  expertName   String
  topic        String
  category     String   // Crop Disease, Pest Control, Soil Health, etc.
  description  String?
  urgency      String   @default("Medium") // Low, Medium, High, Critical
  scheduledFor DateTime
  duration     Int?     // minutes
  cost         Float?
  status       String   @default("Scheduled") // Scheduled, In-Progress, Completed, Cancelled
  rating       Int?     // 1-5 stars
  feedback     String?
  notes        String?
  attachments  String?  // JSON: Array of file URLs
  createdAt    DateTime @default(now())
  updatedAt    DateTime @updatedAt
}
```

#### ConsultationMessage
Real-time messaging during consultations.
```prisma
model ConsultationMessage {
  id             String       @id @default(cuid())
  consultationId String
  senderId       String
  senderType     String       // User, Expert
  message        String
  attachments    String?      // JSON: Array of file URLs
  isRead         Boolean      @default(false)
  sentAt         DateTime     @default(now())
}
```

### 🔮 Predictions & Analytics

#### YieldPrediction
AI-powered yield prediction system.
```prisma
model YieldPrediction {
  id             String    @id @default(cuid())
  fieldId        String
  cropType       String
  predictedYield Float     // tons per hectare
  actualYield    Float?    // for comparison after harvest
  confidence     Float     // AI confidence score
  factors        String?   // JSON: Factors considered in prediction
  model          String?   // ML model used
  predictionDate DateTime  @default(now())
  harvestDate    DateTime? // Expected harvest date
  accuracy       Float?    // Calculated after actual harvest
}
```

#### Analytics
Advanced analytics and insights generation.
```prisma
model Analytics {
  id          String @id @default(cuid())
  type        String // Yield, Cost, Profit, Efficiency, etc.
  period      String // Daily, Weekly, Monthly, Seasonal, Yearly
  data        String   // JSON: Analytics data
  insights    String?  // JSON: Generated insights
  generatedAt DateTime @default(now())
}
```

### 📋 Activities & Logging

#### Activity
Comprehensive farm activity planning and tracking.
```prisma
model Activity {
  id          String     @id @default(cuid())
  userId      String
  fieldId     String?
  type        String     // Planting, Watering, Fertilizing, Harvesting, etc.
  description String
  status      String     @default("Planned") // Planned, In-Progress, Completed, Cancelled
  priority    String     @default("Medium") // Low, Medium, High
  startDate   DateTime
  endDate     DateTime?
  duration    Int?       // hours
  cost        Float?
  laborHours  Float?
  notes       String?
  weather     String?    // JSON: Weather conditions
  results     String?    // Activity results
  images      String?    // JSON: Array of image URLs
  createdAt   DateTime   @default(now())
  updatedAt   DateTime   @updatedAt
}
```

#### Notification
System notifications and alerts.
```prisma
model Notification {
  id        String   @id @default(cuid())
  userId    String
  type      String   // Alert, Reminder, Update, etc.
  title     String
  message   String
  priority  String   @default("Medium") // Low, Medium, High, Critical
  isRead    Boolean  @default(false)
  actionUrl String?  // URL to navigate when clicked
  data      String?  // JSON: Additional notification data
  createdAt DateTime @default(now())
  expiresAt DateTime?
}
```

### 💳 Subscription & Premium Features

#### Subscription
User subscription and premium feature management.
```prisma
model Subscription {
  id          String   @id @default(cuid())
  userId      String
  planType    String   // Basic, Premium, Enterprise
  features    String   // JSON: Array of included features
  startDate   DateTime
  endDate     DateTime
  isActive    Boolean  @default(true)
  autoRenew   Boolean  @default(false)
  amount      Float
  currency    String   @default("USD")
  paymentId   String?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

## Key Features

### 🔄 Data Relationships
- **Hierarchical Structure**: Users → Farms → Fields → Activities/Analysis
- **Cross-References**: Equipment, Inventory, and Consultations linked to users
- **Historical Tracking**: All major entities include creation and update timestamps

### 🧠 AI Integration
- **Crop Health Analysis**: AI-powered crop health assessment with confidence scores
- **Pest/Disease Identification**: Automated pest and disease identification
- **Yield Predictions**: Machine learning-based yield forecasting
- **Smart Recommendations**: AI-generated fertilizer and treatment recommendations

### 📊 Analytics & Reporting
- **Financial Tracking**: Comprehensive income/expense management
- **Performance Metrics**: Yield analysis, cost efficiency, ROI calculations
- **Trend Analysis**: Historical data analysis for decision making
- **Predictive Insights**: Future planning based on historical patterns

### 🔔 Smart Notifications
- **Weather Alerts**: Automated weather-based notifications
- **Maintenance Reminders**: Equipment and field maintenance scheduling
- **Inventory Alerts**: Low stock and expiry date notifications
- **Activity Reminders**: Task scheduling and deadline notifications

### 🌐 Multi-User Support
- **Role-Based Access**: Farmers, Experts, and Administrators
- **Expert Consultation**: Built-in expert booking and communication system
- **Collaborative Features**: Shared data access and consultation history

## Sample Data

The database is seeded with comprehensive sample data including:
- **Demo Farmer Account**: farmer@agriassist.com / password123
- **Expert Account**: expert@agriassist.com / password123
- **Sample Farm**: Green Valley Farm with multiple fields
- **Crop Data**: Maize and wheat fields with health records
- **Inventory Items**: Seeds, fertilizers, and equipment
- **Financial Records**: Sample transactions and budgets
- **Weather Data**: 7 days of historical weather information
- **Pest/Disease Reports**: Sample pest identification records
- **Consultations**: Scheduled expert consultation
- **Notifications**: Various alert types and reminders

## API Endpoints

The backend provides RESTful API endpoints for all database operations:
- `/api/auth` - Authentication and user management
- `/api/farms` - Farm and field management
- `/api/crops` - Crop health and variety information
- `/api/soil` - Soil analysis and recommendations
- `/api/weather` - Weather data and alerts
- `/api/pests` - Pest identification and treatment
- `/api/diseases` - Disease diagnosis and management
- `/api/inventory` - Inventory and supply management
- `/api/equipment` - Equipment and maintenance tracking
- `/api/financial` - Transaction and budget management
- `/api/market` - Market prices and sales tracking
- `/api/consultations` - Expert consultation system
- `/api/analytics` - Reports and analytics
- `/api/activities` - Activity planning and tracking
- `/api/notifications` - Notification management

## Security Features

- **Authentication**: JWT-based user authentication
- **Authorization**: Role-based access control
- **Data Validation**: Comprehensive input validation using Zod
- **API Documentation**: Swagger/OpenAPI documentation at `/docs`
- **CORS Protection**: Configurable cross-origin resource sharing
- **Rate Limiting**: API rate limiting for security

## Scalability Considerations

- **Modular Design**: Separate modules for different functionalities
- **Efficient Indexing**: Proper database indexing for performance
- **Pagination Support**: Built-in pagination for large datasets
- **Caching Strategy**: Redis caching for frequently accessed data
- **File Storage**: External file storage for images and documents
- **Backup Strategy**: Automated database backup and recovery

This comprehensive database schema provides a solid foundation for a complete agricultural management platform, supporting everything from basic farm operations to advanced AI-powered analytics and expert consultation services.