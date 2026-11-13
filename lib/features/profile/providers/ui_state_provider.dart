import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void select(int v) => state = v;
}

class FilterNotifier extends Notifier<String> {
  @override
  String build() => 'all';
  void select(String v) => state = v;
}

final studentTabProvider = NotifierProvider<IndexNotifier, int>(IndexNotifier.new);
final companyTabProvider = NotifierProvider<IndexNotifier, int>(IndexNotifier.new);

final studentAppFilterProvider =
NotifierProvider<FilterNotifier, String>(FilterNotifier.new);
final postingFilterProvider =
NotifierProvider<FilterNotifier, String>(FilterNotifier.new);
final applicantFilterProvider =
NotifierProvider<FilterNotifier, String>(FilterNotifier.new);