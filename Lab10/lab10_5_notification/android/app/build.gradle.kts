plugins {

    id("com.android.application")

    id("kotlin-android")

    // Flutter Gradle Plugin must be applied after Android and Kotlin plugins.
    id("dev.flutter.flutter-gradle-plugin")

}



android {

    namespace = "com.example.lab10_5_notification"


    compileSdk = flutter.compileSdkVersion


    ndkVersion = flutter.ndkVersion




    compileOptions {


        sourceCompatibility =
            JavaVersion.VERSION_17


        targetCompatibility =
            JavaVersion.VERSION_17



        // Required by flutter_local_notifications
        isCoreLibraryDesugaringEnabled = true


    }




    kotlinOptions {


        jvmTarget =
            JavaVersion.VERSION_17.toString()


    }





    defaultConfig {


        applicationId =
            "com.example.lab10_5_notification"



        minSdk =
            flutter.minSdkVersion



        targetSdk =
            flutter.targetSdkVersion



        versionCode =
            flutter.versionCode



        versionName =
            flutter.versionName


    }





    buildTypes {


        release {


            signingConfig =
                signingConfigs.getByName("debug")


        }


    }


}





flutter {


    source =
        "../.."


}





dependencies {


    // Required for flutter_local_notifications
    coreLibraryDesugaring(
        "com.android.tools:desugar_jdk_libs:2.1.4"
    )


}