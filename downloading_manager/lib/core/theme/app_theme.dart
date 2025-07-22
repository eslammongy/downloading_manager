import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

/// Extension methods for easier theme access
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

/// Extension for accessing custom colors
extension CustomColorsGetter on BuildContext {
  CustomColors get customColors {
    return Theme.of(this).extension<CustomColors>()!;
  }
}

// Theme provider using ChangeNotifier for state management
class AppThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // Get appropriate theme based on current mode
  ThemeData get currentTheme =>
      isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}

// Theme definitions
class AppTheme {
  // Use a private constructor to prevent instantiation
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: AppColors.textPrimaryLight,
      onSecondary: AppColors.textPrimaryLight,
      onSurface: AppColors.textPrimaryLight,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Register the CustomColors extension
      extensions: [
        CustomColors(
          deepOrange: AppColors.deepOrange,
          priorityHigh: AppColors.priorityHigh,
          priorityMedium: AppColors.priorityMedium,
          priorityLow: AppColors.priorityLow,
          borderColor: AppColors.borderColorLight,
          textPrimary: AppColors.textPrimaryLight,
          textSecondary: AppColors.textSecondaryLight,
        ),
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryLight,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondaryLight,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: AppColors.primary),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
        ),
        margin: EdgeInsets.zero,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizerUtil.p12.w,
          vertical: SizerUtil.p8.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.borderColorLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.borderColorLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyle(
          color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        errorStyle: TextStyle(
          color: AppColors.error.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        labelStyle: TextStyle(
          color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        helperStyle: TextStyle(
          color: AppColors.textSecondaryLight.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.borderColorLight,
        thickness: 1,
        space: 1,
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
          letterSpacing: -0.5,
        ),

        displaySmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
        ),
        titleLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textPrimaryLight,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryLight,
        ),
      ),

      iconTheme: IconThemeData(color: AppColors.textPrimaryLight),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: AppColors.textSecondaryLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p8.r),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.5);
          }
          return AppColors.textSecondaryLight.withValues(alpha: 0.3);
        }),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(SizerUtil.p16.r),
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p16.r),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Register the CustomColors extension
      extensions: [
        CustomColors(
          deepOrange: AppColors.deepOrange,
          priorityHigh: AppColors.priorityHigh,
          priorityMedium: AppColors.priorityMedium,
          priorityLow: AppColors.priorityLow,
          borderColor: AppColors.borderColorDark,
          textPrimary: AppColors.textPrimaryDark,
          textSecondary: AppColors.textSecondaryDark,
        ),
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryDark,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: AppColors.primary),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
        ),
        margin: EdgeInsets.zero,
      ),

      iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: EdgeInsets.all(SizerUtil.p12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.borderColorDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.borderColorDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p12.r),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyle(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        errorStyle: TextStyle(
          color: AppColors.error.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        labelStyle: TextStyle(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
        helperStyle: TextStyle(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.7),
          fontSize: 12.sp,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.borderColorDark,
        thickness: 1,
        space: 1,
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryDark,
          letterSpacing: -0.5,
        ),

        displaySmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.textPrimaryDark),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimaryDark,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: AppColors.textSecondaryDark, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p8.r),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.grey[400]!;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.5);
          }
          return AppColors.textSecondaryDark.withValues(alpha: 0.3);
        }),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(SizerUtil.p16.r),
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizerUtil.p16.r),
        ),
      ),
    );
  }
}
