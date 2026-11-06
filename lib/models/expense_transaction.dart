class ExpenseTransaction {
  final String id;
  final String title;
  final String category;
  final String note;
  final int amount;
  final DateTime date;

  const ExpenseTransaction({
    required this.id,
    required this.title,
    required this.category,
    required this.note,
    required this.amount,
    required this.date,
  });

  String get formattedAmount {
    final value = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      final remaining = value.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }
    return 'Rp$buffer';
  }
}
