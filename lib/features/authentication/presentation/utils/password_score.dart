/// HTML strength meter এর মতো: length, uppercase, digit, symbol — প্রতিটি 1 point।
int passwordScore(String value) {
  if (value.isEmpty) return 0;
  return [
    value.length >= 8,
    RegExp(r'[A-Z]').hasMatch(value),
    RegExp(r'[0-9]').hasMatch(value),
    RegExp(r'[^A-Za-z0-9]').hasMatch(value),
  ].where((ok) => ok).length;
}
