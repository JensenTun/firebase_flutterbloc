plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jensen.myfirebase.firebase_flutterbloc"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true  // ✅ Fix: Ensure this is included
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.jensen.myfirebase.firebase_flutterbloc"
        minSdk = 23
        targetSdk = 34
        versionCode = 1 // Replace with actual versionCode
        versionName = "1.0" // Replace with actual versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Change to release signingConfig if needed
        }
    }
}


flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3") // ✅ Ensure this is present
    implementation("androidx.core:core-ktx:1.12.0")
}
