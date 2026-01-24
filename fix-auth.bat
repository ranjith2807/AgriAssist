@echo off
echo 🔥 Opening Firebase Console to fix authentication...
echo.
echo This will open your Firebase project's Authentication section
echo where you need to:
echo.
echo 1. Click "Get started" button
echo 2. Enable Email/Password sign-in method
echo.
echo Press any key to open Firebase Console...
pause > nul
start https://console.firebase.google.com/project/agriassest-ai/authentication/users
echo.
echo ✅ Firebase Console opened!
echo.
echo After enabling authentication, test it here:
echo https://agriassest-ai.web.app/auth-test
echo.
pause