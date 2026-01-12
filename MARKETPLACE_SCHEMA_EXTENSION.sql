-- ============= MARKETPLACE EXTENSION =============
-- Add BUYER role to existing User model (extend role enum)
-- Current roles: FARMER, EXPERT, ADMIN
-- New role: BUYER

-- ============= MARKETPLACE CORE MODELS =============

-- Product Listings by Farmers
model Product {
  id            String   @id @default(cuid())
  farmerId      String
  farmer        User     @relation("FarmerProducts", fields: [farmerId], references: [id])
  name          String
  description   String?
  cropType      String   // Vegetables, Fruits, Grains, Pulses, Spices, etc.
  variety       String?  // Specific variety of the crop
  category      String   // Fresh, Processed, Organic, etc.
  
  // Pricing & Inventory
  pricePerUnit  Float
  unit          String   @default("kg") // kg, ton, piece, bunch, etc.
  availableQty  Float
  minOrderQty   Float    @default(1)
  maxOrderQty   Float?
  
  // Product Details
  harvestDate   DateTime?
  expiryDate    DateTime?
  quality       String   @default("A") // A, B, C grade
  isOrganic     Boolean  @default(false)
  certifications String? // Array of certifications
  
  // Location & Logistics
  farmLocation  String
  coordinates   String?  // GPS coordinates
  deliveryRadius Float?  // km radius for delivery
  pickupAvailable Boolean @default(true)
  deliveryAvailable Boolean @default(false)
  
  // Media & Marketing
  images        String?  // Array of image URLs
  videos        String?  // Array of video URLs
  tags          String?  // Array of searchable tags
  
  // Status & Visibility
  status        String   @default("ACTIVE") // ACTIVE, SOLD_OUT, INACTIVE, EXPIRED
  isVisible     Boolean  @default(true)
  isFeatured    Boolean  @default(false)
  
  // Ratings & Reviews
  averageRating Float    @default(0)
  totalReviews  Int      @default(0)
  
  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  // Relations
  orders        OrderItem[]
  reviews       ProductReview[]
  favorites     ProductFavorite[]
  priceHistory  ProductPriceHistory[]
}

-- Product Price History for Analytics
model ProductPriceHistory {
  id        String   @id @default(cuid())
  productId String
  product   Product  @relation(fields: [productId], references: [id])
  price     Float
  date      DateTime @default(now())
  reason    String?  // Market change, seasonal, demand, etc.
}

-- Product Reviews by Buyers
model ProductReview {
  id        String   @id @default(cuid())
  productId String
  product   Product  @relation(fields: [productId], references: [id])
  buyerId   String
  buyer     User     @relation("BuyerReviews", fields: [buyerId], references: [id])
  orderId   String?  // Link to specific order
  rating    Int      // 1-5 stars
  title     String?
  comment   String?
  images    String?  // Array of review images
  isVerified Boolean @default(false) // Verified purchase
  helpfulVotes Int   @default(0)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

-- Buyer Favorites/Wishlist
model ProductFavorite {
  id        String   @id @default(cuid())
  productId String
  product   Product  @relation(fields: [productId], references: [id])
  buyerId   String
  buyer     User     @relation("BuyerFavorites", fields: [buyerId], references: [id])
  createdAt DateTime @default(now())
  
  @@unique([productId, buyerId])
}

-- ============= ORDER MANAGEMENT =============

-- Main Order Entity
model Order {
  id            String   @id @default(cuid())
  orderNumber   String   @unique // Human-readable order number
  buyerId       String
  buyer         User     @relation("BuyerOrders", fields: [buyerId], references: [id])
  farmerId      String
  farmer        User     @relation("FarmerOrders", fields: [farmerId], references: [id])
  
  // Order Details
  status        String   @default("PENDING") // PENDING, CONFIRMED, PREPARING, SHIPPED, DELIVERED, CANCELLED, REFUNDED
  totalAmount   Float
  discountAmount Float   @default(0)
  taxAmount     Float    @default(0)
  shippingCost  Float    @default(0)
  finalAmount   Float
  
  // Delivery Information
  deliveryType  String   // PICKUP, DELIVERY
  deliveryAddress String?
  deliveryDate  DateTime?
  deliveryTime  String?  // Time slot
  specialInstructions String?
  
  // Payment Information
  paymentStatus String   @default("PENDING") // PENDING, PAID, FAILED, REFUNDED
  paymentMethod String?  // CASH, CARD, UPI, BANK_TRANSFER
  paymentId     String?  // External payment gateway ID
  paidAt        DateTime?
  
  // Communication
  buyerNotes    String?
  farmerNotes   String?
  
  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  // Relations
  items         OrderItem[]
  tracking      OrderTracking[]
  messages      OrderMessage[]
}

-- Order Items (Products in an Order)
model OrderItem {
  id        String  @id @default(cuid())
  orderId   String
  order     Order   @relation(fields: [orderId], references: [id])
  productId String
  product   Product @relation(fields: [productId], references: [id])
  quantity  Float
  unitPrice Float
  totalPrice Float
  notes     String? // Special requests for this item
  
  @@unique([orderId, productId])
}

-- Order Tracking & Status Updates
model OrderTracking {
  id          String   @id @default(cuid())
  orderId     String
  order       Order    @relation(fields: [orderId], references: [id])
  status      String   // Status update
  description String?  // Detailed description
  location    String?  // Current location
  updatedBy   String?  // Who updated (farmer, system, delivery)
  timestamp   DateTime @default(now())
  isVisible   Boolean  @default(true) // Visible to buyer
}

-- Order Messages/Communication
model OrderMessage {
  id        String   @id @default(cuid())
  orderId   String
  order     Order    @relation(fields: [orderId], references: [id])
  senderId  String
  sender    User     @relation("OrderMessages", fields: [senderId], references: [id])
  message   String
  attachments String? // Array of file URLs
  isRead    Boolean  @default(false)
  sentAt    DateTime @default(now())
}

-- ============= FARMER MARKETPLACE PROFILE =============

-- Extended Farmer Profile for Marketplace
model FarmerMarketProfile {
  id              String  @id @default(cuid())
  farmerId        String  @unique
  farmer          User    @relation("FarmerMarketProfile", fields: [farmerId], references: [id])
  
  // Business Information
  businessName    String?
  businessType    String? // Individual, Partnership, Company
  licenseNumber   String?
  taxId           String?
  
  // Marketplace Stats
  totalSales      Float   @default(0)
  totalOrders     Int     @default(0)
  averageRating   Float   @default(0)
  totalReviews    Int     @default(0)
  responseTime    Int?    // Average response time in hours
  
  // Delivery & Service
  deliveryAreas   String? // Array of delivery locations
  deliveryCharges String? // Delivery charge structure
  minOrderAmount  Float?  // Minimum order amount
  maxOrderCapacity Int?   // Max orders per day/week
  
  // Business Hours
  businessHours   String? // Operating hours
  holidaySchedule String? // Holiday/off days
  
  // Verification & Trust
  isVerified      Boolean @default(false)
  verificationDate DateTime?
  verificationDocs String? // Array of verification documents
  
  // Marketing
  storeBanner     String? // Store banner image
  storeDescription String?
  specialties     String? // Array of specialties
  
  // Settings
  autoAcceptOrders Boolean @default(false)
  notificationPrefs String? // Notification preferences
  
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
}

-- ============= BUYER PROFILE =============

-- Buyer Profile for Marketplace
model BuyerProfile {
  id              String  @id @default(cuid())
  buyerId         String  @unique
  buyer           User    @relation("BuyerProfile", fields: [buyerId], references: [id])
  
  // Personal Information
  buyerType       String  @default("INDIVIDUAL") // INDIVIDUAL, RESTAURANT, RETAILER, WHOLESALER
  businessName    String?
  
  // Purchase Preferences
  preferredCategories String? // Array of preferred crop categories
  dietaryPreferences String?  // Organic, Non-GMO, etc.
  budgetRange     String?     // Budget preferences
  
  // Delivery Preferences
  defaultAddress  String?
  deliveryInstructions String?
  preferredTimeSlots String? // Array of preferred delivery times
  
  // Purchase History Stats
  totalPurchases  Float   @default(0)
  totalOrders     Int     @default(0)
  averageOrderValue Float @default(0)
  
  // Loyalty & Rewards
  loyaltyPoints   Int     @default(0)
  membershipTier  String  @default("BRONZE") // BRONZE, SILVER, GOLD, PLATINUM
  
  // Communication Preferences
  emailNotifications Boolean @default(true)
  smsNotifications Boolean   @default(true)
  pushNotifications Boolean  @default(true)
  
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
}

-- ============= MARKETPLACE ANALYTICS =============

-- Marketplace Analytics
model MarketplaceAnalytics {
  id          String   @id @default(cuid())
  date        DateTime @default(now())
  
  // Sales Metrics
  totalSales  Float    @default(0)
  totalOrders Int      @default(0)
  avgOrderValue Float  @default(0)
  
  // Product Metrics
  totalProducts Int    @default(0)
  activeProducts Int   @default(0)
  topCategories String? // Array of top-selling categories
  
  // User Metrics
  activeFarmers Int    @default(0)
  activeBuyers  Int    @default(0)
  newSignups    Int    @default(0)
  
  // Performance Metrics
  avgDeliveryTime Float? // Average delivery time in hours
  customerSatisfaction Float? // Average rating
  
  period      String   // DAILY, WEEKLY, MONTHLY
  createdAt   DateTime @default(now())
}

-- ============= DELIVERY & LOGISTICS =============

-- Delivery Partners/Agents
model DeliveryAgent {
  id            String  @id @default(cuid())
  name          String
  phone         String
  email         String?
  vehicleType   String  // Bike, Car, Truck, etc.
  vehicleNumber String?
  licenseNumber String?
  
  // Service Area
  serviceAreas  String  // Array of areas they serve
  maxCapacity   Float?  // Max weight/volume capacity
  
  // Status & Availability
  isActive      Boolean @default(true)
  isAvailable   Boolean @default(true)
  currentLocation String? // GPS coordinates
  
  // Performance
  totalDeliveries Int   @default(0)
  averageRating Float   @default(0)
  onTimePercentage Float @default(0)
  
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  // Relations
  deliveries    Delivery[]
}

-- Delivery Tracking
model Delivery {
  id            String        @id @default(cuid())
  orderId       String        @unique
  order         Order         @relation(fields: [orderId], references: [id])
  agentId       String?
  agent         DeliveryAgent? @relation(fields: [agentId], references: [id])
  
  // Delivery Details
  status        String        @default("ASSIGNED") // ASSIGNED, PICKED_UP, IN_TRANSIT, DELIVERED, FAILED
  pickupAddress String
  deliveryAddress String
  estimatedTime DateTime?
  actualPickupTime DateTime?
  actualDeliveryTime DateTime?
  
  // Tracking
  currentLocation String?     // GPS coordinates
  trackingUpdates String?     // Array of tracking updates
  
  // Delivery Proof
  deliveryProof String?       // Photo/signature
  receiverName  String?
  receiverPhone String?
  
  // Issues & Notes
  issues        String?       // Any delivery issues
  notes         String?
  
  createdAt     DateTime      @default(now())
  updatedAt     DateTime      @updatedAt
}

-- ============= PROMOTIONS & DISCOUNTS =============

-- Promotional Campaigns
model Promotion {
  id            String   @id @default(cuid())
  title         String
  description   String?
  type          String   // DISCOUNT, BOGO, FREE_SHIPPING, etc.
  
  // Discount Details
  discountType  String?  // PERCENTAGE, FIXED_AMOUNT
  discountValue Float?
  maxDiscount   Float?
  minOrderAmount Float?
  
  // Applicability
  applicableProducts String? // Array of product IDs or categories
  applicableUsers String?    // Array of user types or specific users
  
  // Validity
  startDate     DateTime
  endDate       DateTime
  isActive      Boolean  @default(true)
  usageLimit    Int?     // Max number of uses
  usageCount    Int      @default(0)
  
  // Conditions
  conditions    String?  // Additional conditions
  
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
}

-- ============= MARKETPLACE SETTINGS =============

-- Marketplace Configuration
model MarketplaceConfig {
  id            String   @id @default(cuid())
  key           String   @unique
  value         String
  description   String?
  category      String   // GENERAL, PAYMENT, DELIVERY, etc.
  dataType      String   @default("STRING") // STRING, NUMBER, BOOLEAN, JSON
  isEditable    Boolean  @default(true)
  updatedAt     DateTime @updatedAt
}

-- Add relations to existing User model:
-- Relations to add to User model:
-- farmerProducts     Product[] @relation("FarmerProducts")
-- buyerOrders        Order[] @relation("BuyerOrders") 
-- farmerOrders       Order[] @relation("FarmerOrders")
-- productReviews     ProductReview[] @relation("BuyerReviews")
-- productFavorites   ProductFavorite[] @relation("BuyerFavorites")
-- orderMessages      OrderMessage[] @relation("OrderMessages")
-- farmerMarketProfile FarmerMarketProfile? @relation("FarmerMarketProfile")
-- buyerProfile       BuyerProfile? @relation("BuyerProfile")