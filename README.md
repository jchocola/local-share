# LocalShare (like AirDrop,NearbyShare,)

Mobile application for transfering files between :
    - Android 2 Android ✅
    - Android 2 IOS ✅
    - Android 2 any OS ✅

## Tech Stack
    - Flutter 3.35.5
    - Dart 3.9.2
    - Bloc (State Management)
    - GetIt (DI)
    - bonsoir (mDNS)
    - Pure Dart Server 
    - Wiredash (feedback)
  
## Transfer Logic
    1. Android to Android (via socket + mDNS)
    Device (A) - sender, nDNS scanner
    Device (B) - receiver, mDNS , server
    Note: Only A -> B


    2. Android to other OS (via HTTP)
    Device (A) - server /  sender + receiver
    Device (B) - sender + receiver
    Note: A <-> B

