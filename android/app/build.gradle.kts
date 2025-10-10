plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.multitasking"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.multitasking"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "version"
    productFlavors {
        create("dev") {
            dimension = "version"
            resValue("string", "app_name", "Multitasking Dev")
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
        }
        create("stag") {
            dimension = "version"
            resValue("string", "app_name", "Multitasking Stag")
            applicationIdSuffix = ".stag"
            versionNameSuffix = "-stag"
        }
        create("prod") {
            dimension = "version"
            resValue("string", "app_name", "Multitasking prod")
            applicationIdSuffix = ".prod"
            versionNameSuffix = "-prod"
        }
    }

}

flutter {
    source = "../.."
}
