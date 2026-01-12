#!/usr/bin/env node

/**
 * Firebase Setup Helper Script
 * This script helps you configure Firebase for AgriAssist AI
 */

import { readFileSync, writeFileSync, existsSync } from 'fs'
import { createInterface } from 'readline'

const rl = createInterface({
  input: process.stdin,
  output: process.stdout
})

function question(query) {
  return new Promise(resolve => rl.question(query, resolve))
}

async function setupFirebase() {
  console.log('🔥 Firebase Setup for AgriAssist AI\n')
  
  console.log('First, make sure you have:')
  console.log('1. Created a Firebase project at https://console.firebase.google.com/')
  console.log('2. Added a web app to your project')
  console.log('3. Enabled Authentication (Email/Password and Phone)')
  console.log('4. Created a Firestore database')
  console.log('5. Downloaded your service account key\n')

  const proceed = await question('Have you completed the above steps? (y/n): ')
  
  if (proceed.toLowerCase() !== 'y') {
    console.log('\n📖 Please follow the setup guide in FIREBASE_SETUP_GUIDE.md first.')
    rl.close()
    return
  }

  console.log('\n📝 Enter your Firebase configuration:')
  
  const apiKey = await question('API Key: ')
  const authDomain = await question('Auth Domain: ')
  const projectId = await question('Project ID: ')
  const storageBucket = await question('Storage Bucket: ')
  const messagingSenderId = await question('Messaging Sender ID: ')
  const appId = await question('App ID: ')
  const measurementId = await question('Measurement ID (optional): ')

  // Create .env file
  const envContent = `# Firebase Configuration for Frontend
VITE_FIREBASE_API_KEY=${apiKey}
VITE_FIREBASE_AUTH_DOMAIN=${authDomain}
VITE_FIREBASE_PROJECT_ID=${projectId}
VITE_FIREBASE_STORAGE_BUCKET=${storageBucket}
VITE_FIREBASE_MESSAGING_SENDER_ID=${messagingSenderId}
VITE_FIREBASE_APP_ID=${appId}
VITE_FIREBASE_MEASUREMENT_ID=${measurementId}

# Development settings
VITE_USE_FIREBASE_EMULATOR=false

# Database type selection
VITE_DATABASE_TYPE=firebase

# API Configuration
VITE_API_BASE_URL=http://localhost:4001/api`

  writeFileSync('.env', envContent)
  console.log('\n✅ Created .env file with your Firebase configuration')

  // Check for service account
  const serviceAccountPath = 'backend/src/config/firebase-service-account.json'
  if (!existsSync(serviceAccountPath)) {
    console.log('\n⚠️  Service Account Key Missing:')
    console.log(`Please place your service account JSON file at: ${serviceAccountPath}`)
    console.log('Download it from: Firebase Console → Project Settings → Service Accounts → Generate new private key')
  } else {
    console.log('\n✅ Service account key found')
  }

  console.log('\n🚀 Next steps:')
  console.log('1. Deploy Firestore rules: cd backend && npm run firebase:rules')
  console.log('2. Deploy indexes: npm run firebase:indexes')
  console.log('3. Seed database: npm run firebase:seed-marketplace')
  console.log('4. Start backend: npm run dev')
  console.log('5. Start frontend: npm run dev (in root directory)')

  console.log('\n🎉 Firebase setup complete!')
  rl.close()
}

setupFirebase().catch(console.error)