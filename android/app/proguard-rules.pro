# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class plugins.flutter.io.**  { *; }

# Firebase Rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

-dontwarn io.flutter.plugin.**
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**
