// import 'package:flutter/material.dart';
//
// import '../../../core/widgets/app_dropdown.dart';
// import '../../../core/widgets/labeled_text_field.dart';
//
// /// Label above an [AppDropdown].
// class LabeledDropdown<T> extends StatelessWidget {
//   const LabeledDropdown({
//     super.key,
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });
//
//   final String label;
//   final T value;
//   final List<AppDropdownItem<T>> items;
//   final ValueChanged<T> onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         formFieldLabel(context, label),
//         AppDropdown<T>(
//           value: value,
//           items: items,
//           onChanged: onChanged,
//           fillColor: formFieldFill(context),
//         ),
//       ],
//     );
//   }
// }
