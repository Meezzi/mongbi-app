# Flutter specific rules.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.android.**  { *; }
-keep class io.flutter.embedding.engine.**  { *; }
-keep class io.flutter.embedding.engine.plugins.**  { *; }
-keep class io.flutter.embedding.engine.plugins.shim.**  { *; }
-keep class io.flutter.embedding.engine.renderer.**  { *; }
-keep class io.flutter.embedding.engine.system.**  { *; }

# Project specific rules.
-keep class com.codepoets.mongbi.** { *; }
-dontwarn com.codepoets.mongbi.**

# General Android rules.
-keep class * extends android.app.Activity
-keep class * extends android.app.Application
-keep class * extends android.app.Service
-keep class * extends android.content.BroadcastReceiver
-keep class * extends android.content.ContentProvider
-keep class * extends android.view.View

# Firebase rules.
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keepattributes Signature,InnerClasses,EnclosingMethod
-keepnames class com.google.android.gms.common.api.internal.TaskApiCall

# Kakao SDK rules.
-keep class com.kakao.sdk.** { *; }
-dontwarn com.kakao.sdk.**

# Naver Login rules.
-keep class com.nhn.android.naverlogin.** { *; }
-dontwarn com.nhn.android.naverlogin.**

# Google Sign-In rules
-keep class com.google.android.gms.auth.api.signin.** { *; }
-dontwarn com.google.android.gms.auth.api.signin.**

# Sentry rules
-keep class io.sentry.** { *; }
-dontwarn io.sentry.**

# Play Core rules
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# OkHttp rules
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE
