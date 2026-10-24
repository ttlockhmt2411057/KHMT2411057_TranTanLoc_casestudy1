class TransactionModel {
  final int? id;
  final String title;
  final double amount;
  final String date;
  final String category;
  final String type; // 'Thu' hoặc 'Chi'

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
  });

  // Chuyển đối tượng thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
      'type': type,
    };
  }

  // Chuyển Map từ SQLite thành đối tượng TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      date: map['date'],
      category: map['category'],
      type: map['type'],
    );
  }
}