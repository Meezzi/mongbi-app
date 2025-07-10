-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

-keep class com.google.firebase.** { *; }


# Play Feature Delivery
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter Deferred Components
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class * implements io.flutter.embedding.engine.deferredcomponents.DeferredComponentManager { *; }