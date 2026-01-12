# Firebase Setup Guide for AgriAssist AI

## 🔥 Complete Firebase Configuration Guide

### **Step 1: Create Firebase Project**

1. **Visit Firebase Console:** https://console.firebase.google.com/
2. **Create Project:** Click "Create a project"
   - Project name: `agriassist-ai`
   - Enable Google Analytics: Yes (recommended)
   - Choose your country/region

### **Step 2: Add Web App**

1. **Add Web App:** Click the web icon (`</>`)
   - App nickname: `AgriAssist AI Web`
   - Enable Firebase Hosting: Optional
2. **Copy Configuration:** You'll get something like this:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "agriassist-ai-xxxxx.firebaseapp.com",
  projectId: "agriassist-ai-xxxxx",
  storageBucket: "agriassist-ai-xxxxx.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abcdefghijklmnop",
  measurementId: "G-XXXXXXXXXX"
};
```

### **Step 3: Enable Services**

#### **Authentication:**
1. Go to **Authentication** → **Get started**
2. **Sign-in method** tab:
   - ✅ Enable **Email/Password**
   - ✅ Enable **Phone** (for SMS verification)

#### **Firestore Database:**
1. Go to **Firestore Database** → **Create database**
2. **Start in test mode** (we'll update rules later)
3. Choose your **location** (closest to your users)

#### **Storage (Optional):**
1. Go to **Storage** → **Get started**
2. Accept default rules
3. Choose same location as Firestore

### **Step 4: Get Service Account Key**

1. **Project Settings:** Click gear icon ⚙️ → **Project settings**
2. **Service accounts** tab
3. **Generate new private key** → **Generate key**
4. **Download JSON file** (keep it secure!)

### **Step 5: Update Configuration Files**

#### **Frontend Configuration (.env):**
Replace the values in your `.env` file:

```bash
# Replace with your actual Firebase config
VITE_FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VITE_FIREBASE_AUTH_DOMAIN=agriassist-ai-xxxxx.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=agriassist-ai-xxxxx
VITE_FIREBASE_STORAGE_BUCKET=agriassist-ai-xxxxx.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
VITE_FIREBASE_APP_ID=1:123456789012:web:abcdefghijklmnop
VITE_FIREBASE_MEASUREMENT_ID=G-XXXXXXXXXX

# Keep these settings
VITE_USE_FIREBASE_EMULATOR=false
VITE_DATABASE_TYPE=firebase
VITE_API_BASE_URL=http://localhost:4001/api
```

#### **Backend Service Account:**
1. **Rename** the downloaded JSON file to `firebase-service-account.json`
2. **Place it** in `backend/src/config/firebase-service-account.json`
3. **Add to .gitignore** (never commit this file!)

### **Step 6: Deploy Security Rules**

#### **Update Firestore Rules:**
```bash
cd backend
npm run firebase:rules
```

#### **Deploy Indexes:**
```bash
npm run firebase:indexes
```

### **Step 7: Seed Database**

```bash
cd backend
npm run firebase:seed-marketplace
```

### **Step 8: Test Your Setup**

1. **Start Backend:**
```bash
cd backend
npm run dev
```

2. **Start Frontend:**
```bash
npm run dev
```

3. **Test Registration:**
   - Go to http://localhost:3000/signup
   - Create a new account
   - Verify it works with real Firebase

### **🔒 Security Checklist**

- ✅ **Service Account Key:** Never commit to Git
- ✅ **Environment Variables:** Use `.env` for sensitive data
- ✅ **Firestore Rules:** Deploy production-ready rules
- ✅ **Authentication:** Enable only needed providers
- ✅ **API Keys:** Restrict to your domains in production

### **🚀 Production Deployment**

#### **Frontend Hosting:**
```bash
# Build for production
npm run build

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

#### **Backend Deployment:**
- Deploy to **Google Cloud Run**, **Heroku**, or **Vercel**
- Set environment variables for production
- Update CORS origins for your domain

### **📊 Monitoring & Analytics**

1. **Firebase Console:** Monitor usage and performance
2. **Authentication:** Track user registrations and logins
3. **Firestore:** Monitor database reads/writes
4. **Analytics:** Track user behavior (if enabled)

### **🛠 Troubleshooting**

#### **Common Issues:**

1. **"Firebase project not found"**
   - Check project ID in configuration
   - Ensure service account has correct permissions

2. **"Permission denied"**
   - Check Firestore security rules
   - Verify user authentication

3. **"API key invalid"**
   - Regenerate API key in Firebase console
   - Update environment variables

4. **"Service account error"**
   - Check JSON file path and format
   - Verify service account permissions

### **💡 Best Practices**

1. **Environment Management:**
   - Use different Firebase projects for dev/staging/prod
   - Keep API keys secure and rotate regularly

2. **Database Design:**
   - Use subcollections for related data
   - Implement proper indexing for queries
   - Monitor usage and optimize costs

3. **Security:**
   - Implement proper Firestore rules
   - Use Firebase App Check for additional security
   - Monitor for suspicious activity

4. **Performance:**
   - Use Firebase Performance Monitoring
   - Implement offline capabilities
   - Optimize bundle size with tree shaking

---

## 🎉 **You're Ready!**

Once you complete these steps, your AgriAssist AI application will be running on a real Firebase infrastructure with:

- ✅ **Real-time database** with Firestore
- ✅ **User authentication** with Firebase Auth
- ✅ **File storage** with Firebase Storage
- ✅ **Analytics** and monitoring
- ✅ **Scalable infrastructure** ready for production

Your marketplace functionality will work with real data persistence, user authentication, and all the benefits of Firebase's cloud infrastructure!