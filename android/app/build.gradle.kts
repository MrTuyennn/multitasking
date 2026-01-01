plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
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
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Load keystore properties from environment variables (Codemagic) or key.properties file
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = java.util.Properties()
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
    }

    signingConfigs {
        create("release") {
            // Try to get from environment variables first (Codemagic)
            val keystorePath = System.getenv("CM_KEYSTORE_PATH") ?: keystoreProperties["storeFile"] as String?
            val keystorePassword = System.getenv("CM_KEYSTORE_PASSWORD") ?: keystoreProperties["storePassword"] as String?
            val keyAlias = System.getenv("CM_KEY_ALIAS") ?: keystoreProperties["keyAlias"] as String?
            val keyPassword = System.getenv("CM_KEY_PASSWORD") ?: keystoreProperties["keyPassword"] as String?

            if (keystorePath != null && keystorePassword != null && keyAlias != null && keyPassword != null) {
                storeFile = file(keystorePath)
                storePassword = keystorePassword
                keyAlias = keyAlias
                keyPassword = keyPassword
            }
        }
    }

    buildTypes {
        release {
            // Use release signing config if available, otherwise fallback to debug
            val releaseSigningConfig = signingConfigs.findByName("release")
            if (releaseSigningConfig != null && releaseSigningConfig.storeFile != null && releaseSigningConfig.storeFile!!.exists()) {
                signingConfig = releaseSigningConfig
            } else {
                // Fallback to debug signing for local development
                signingConfig = signingConfigs.getByName("debug")
            }
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
            applicationId = "com.example.multitasking.toktok"
            versionNameSuffix = "-prod"
        }
    }

}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.mlkit:translate:17.0.3")
    implementation("com.google.mlkit:genai-image-description:1.0.0-beta1")

    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    // Needed for Task.await() extensions (kotlinx.coroutines.tasks.await)
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-play-services:1.7.3")
}
