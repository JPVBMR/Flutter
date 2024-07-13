import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

/* Create a color schema for flutter to use automatically */
var kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 18, 31),
);

/* DarkTheme Color Scheme */
var kColorSchemaDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      /* Dark Theme */
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorSchemaDark,
        cardTheme: const CardTheme().copyWith(
          color: kColorSchemaDark.secondaryContainer,
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchemaDark.primaryContainer,
          ),
        ),
      ),

      /* Ligh Theme */
      theme: ThemeData().copyWith(
        colorScheme: kColorSchema,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorSchema.onPrimaryContainer,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorSchema.secondaryContainer,
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchema.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kColorSchema.primaryContainer,
              ),
              titleMedium: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
        /* scaffoldBackgroundColor: Color.fromARGB(186, 224, 188, 186), */
      ),
      /* Control the Theme mode: Dark or light */
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
