

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") version "2.1.0"
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.codepoets.mongbi"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.codepoets.mongbi"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            storeFile = file("../" + (project.properties["MYAPP_UPLOAD_STORE_FILE"] as String))
            storePassword = project.properties["MYAPP_UPLOAD_STORE_PASSWORD"] as String
            keyAlias = project.properties["MYAPP_UPLOAD_KEY_ALIAS"] as String
            keyPassword = project.properties["MYAPP_UPLOAD_KEY_PASSWORD"] as String
        }
    }

        buildTypes {
            getByName("release") {
                isDebuggable = false
                signingConfig = signingConfigs.getByName("release")
                isMinifyEnabled = false
                isShrinkResources = false
            }
        }

}

flutter {
    source = "../.."
}

dependencies {
    implementation 'com.google.android.play:feature-delivery:2.1.0'
    implementation 'com.google.android.play:feature-delivery-ktx:2.1.0'
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.1.0")
}