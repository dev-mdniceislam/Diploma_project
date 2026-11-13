import 'package:flutter/material.dart';

import '../../profile_core.dart';

extension ProfileThemeX on BuildContext {
  TextTheme get tt => Theme.of(this).textTheme;
  ColorScheme get cs => Theme.of(this).colorScheme;
}
