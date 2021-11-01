extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    final first = this[0].toUpperCase();
    return first + substring(1);
  }
}
