# flutterQRDecode
scan Health record QR code (encoded in CRED or SHC format) and decode it

**#qrcode_flutter**
It uses qrcode_flutter: ^3.0.0-nullsafety.0 which is a pre-release version. 

Also, in-order for qrcode_flutter compile correctly we need to use Android Buid Tool v 3.5.0 instead of 4.1.0. 
Android\Gradle\build.gradle
dependencies {
        classpath 'com.android.tools.build:gradle:3.5.0'
        
We might want to 
