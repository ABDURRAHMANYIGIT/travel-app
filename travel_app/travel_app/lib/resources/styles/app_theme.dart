import 'package:flutter/material.dart'
    show
        BottomAppBarTheme,
        Brightness,
        ColorScheme,
        ElevatedButton,
        ElevatedButtonThemeData,
        ThemeData,
        VisualDensity;
import 'colors.dart';

/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your theme, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created theme or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/theme.dart';`

class ThemeDataHelper {
  ThemeData mainTheme = ThemeData(fontFamily: 'Poppins');

  final ThemeData themeData = ThemeData(
    // fontFamily: GoogleFonts.inter().fontFamily,
    fontFamily: 'Poppins',
    primaryColor: AppColors.etrexioPurple,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: GoogleFonts.interTextTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.grey,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.grey,
      ),
    ),
    cardColor: AppColors.grey,
    canvasColor: AppColors.grey,
    scaffoldBackgroundColor: AppColors.etrexioPurple,
    indicatorColor: AppColors.grey,
    hintColor: AppColors.grey,
    dividerColor: AppColors.etrexioPurple,
    hoverColor: AppColors.grey,
    focusColor: AppColors.etrexioPurple,
    splashColor: AppColors.grey,
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.grey),
  );

  final ThemeData themeDataDark = ThemeData(
    // fontFamily: GoogleFonts.inter().fontFamily,
    fontFamily: 'Poppins',
    primaryColor: AppColors.etrexioPurple,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: GoogleFonts.interTextTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.etrexioPurple,
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.etrexioPurple,
      ),
    ),
    cardColor: AppColors.grey,
    canvasColor: AppColors
        .black, // dropdown formfield uses this color as background color
    scaffoldBackgroundColor: AppColors.etrexioPurple,
    indicatorColor: AppColors.grey,
    hintColor: AppColors.grey,
    dividerColor: AppColors.transparent,
    hoverColor: AppColors.transparent,
    focusColor: AppColors.grey,
    splashColor: AppColors.transparent,
  );
}
