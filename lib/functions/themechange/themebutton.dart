// import 'package:flutter/material.dart';
// import 'package:musi_city/functions/themechange/themechanging.dart';
// import 'package:provider/provider.dart';
// import 'package:switcher_button/switcher_button.dart';

// class ChangeThemeButton extends StatelessWidget {
//   const ChangeThemeButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return SwitcherButton(
//       offColor: Colors.grey,
//       onColor: Colors.blue,
//       size: 40,
//       value: themeProvider.isDarkMode,
//       onChange: (value) {
//         final provider = Provider.of<ThemeProvider>(context, listen: false);
//         provider.toggleTheme(value);
//       },
//     );
//   }
// }
