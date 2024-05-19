import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/data/constants.dart';

class TodoAppThemeData {
  const TodoAppThemeData._();

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData = _themeData(_lightColorScheme, _lightFocusColor);

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,
      textTheme: _textTheme,
      canvasColor: whiteColor,
      scaffoldBackgroundColor: colorScheme.background,
      focusColor: focusColor,
      hintColor: greyColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconTheme: IconThemeData(color: colorScheme.primary),
      primaryColorDark: colorScheme.primary,
      dividerColor: lightGray,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actionsIconTheme: IconThemeData(color: colorScheme.primary),
        iconTheme: IconThemeData(color: colorScheme.primary),
        backgroundColor: Colors.transparent,
        titleTextStyle: _textTheme.headlineMedium?.copyWith(color: colorScheme.primary),
      ),
      dialogTheme: DialogTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadiusValue),
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary,
        labelStyle: _textTheme.titleLarge?.copyWith(fontSize: 15),
        unselectedLabelStyle: _textTheme.titleMedium?.copyWith(fontSize: 14),
        indicator: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.secondary.withOpacity(0.5),
        margin: EdgeInsets.zero,
        elevation: 0.5,
        clipBehavior: Clip.antiAlias,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        modalElevation: 0,
        modalBarrierColor: Colors.black.withOpacity(0.2),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadiusValue),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        side: BorderSide(color: colorScheme.secondary),
      ),
    );
  }

  static const Color basePrimary = Color(0xFF6A3EA1);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xFF180E25);
  static const Color darkGray = Color(0xFF827D89);
  static const Color baseGray = Color(0xFFC8C5CB);
  static const Color lightGray = Color(0xFFEFEEF0);
  static const Color border = Color(0xFFC8C5CB);
  static const Color baseError = Color(0xFFCE3A54);
  static const Color gray = Color(0xFFBEBDBF);
  static const Color grayTitle = Color(0xFf8F8B96);

  static const Color _blackColor = Colors.black;

  static const Color greyColor = Color(0xFFB5B8BF);
  static const Color greenColor = Color(0xFF69DF9E);

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFEFE9F7),
    onPrimary: whiteColor,
    secondary: Color(0xFFDAF6E4),
    onSecondary: whiteColor,
    background: Color(0xffFAF8FC),
    onBackground: whiteColor,
    error: baseError,
    onError: baseError,
    surface: whiteColor,
    onSurface: _blackColor,
  );

  static const FontWeight _regular = FontWeight.w400;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineLarge: GoogleFonts.inter(fontWeight: _bold, fontSize: 32.0, color: blackColor),
    headlineMedium: GoogleFonts.inter(fontWeight: _bold, fontSize: 20.0),
    labelMedium: GoogleFonts.inter(fontWeight: _medium, fontSize: 16.0),

    // bodySmall: GoogleFonts.inter(fontWeight: _semiBold, fontSize: 16.0),
    // headlineSmall: GoogleFonts.inter(fontWeight: _medium, fontSize: 16.0),
    titleMedium: GoogleFonts.inter(fontWeight: _medium, fontSize: 16.0, color: blackColor),

    ///regular
    titleSmall: GoogleFonts.inter(fontWeight: _regular, fontSize: 16.0, color: darkGray),
    // labelSmall: GoogleFonts.inter(fontWeight: _medium, fontSize: 12.0, letterSpacing: 0),
    // bodyLarge: GoogleFonts.inter(fontWeight: _regular, fontSize: 14.0),
    // bodyMedium: GoogleFonts.inter(fontWeight: _regular, fontSize: 16.0),
    // titleLarge: GoogleFonts.inter(fontWeight: _bold, fontSize: 16.0, color: Colors.black),
    // labelLarge: GoogleFonts.inter(fontWeight: _semiBold, fontSize: 14.0),
  );
}
