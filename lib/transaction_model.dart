class TransactionModel {
  final int? id;             // Mã giao dịch, tự tăng trong SQLite
  final String title;        // Tên khoản chi/thu (VD: Tiền trọ, Ăn sáng)
  final double amount;       // Số tiền
  final String date;         // Ngày thực hiện (chuỗi YYYY-MM-DD)
  final String category;     // Danh mục (VD: Ăn uống, Di chuyển)
  final int isExpense;       // 1: Khoản chi, 0: Khoản thu

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isExpense,
  });

  // Chuyển đối tượng TransactionModel thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
      'isExpense': isExpense,
    };
  }

  // Chuyển Map lấy từ SQLite thành đối tượng TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: map['date'] as String,
      category: map['category'] as String,
      isExpense: map['isExpense'] as int,
    );
  }
}