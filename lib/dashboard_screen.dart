import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'transaction_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Chạy thử kiểm tra cơ sở dữ liệu ngay khi màn hình mở lên
    _chayThuDatabase();
  }

  void _chayThuDatabase() async {
    // 1. Thêm thử một giao dịch vào SQLite
    await DatabaseHelper.instance.insertTransaction(
      TransactionModel(
        title: 'Cơm trưa',
        amount: 35000,
        date: DateTime.now().toString(),
        category: 'Ăn uống',
        isExpense: 1,
      ),
    );

    // 2. Truy vấn đọc dữ liệu ra màn hình Console
    final danhSach = await DatabaseHelper.instance.getAllTransactions();
    print('================ KẾT QUẢ TEST SQLITE ================');
    print('Tổng số giao dịch trong Database: ${danhSach.length}');
    for (var item in danhSach) {
      print('Mã: ${item.id} | Khoản: ${item.title} | Số tiền: ${item.amount} đ | Phân loại: ${item.category}');
    }
    print('====================================================');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header xanh dương: "Xin chào! Hôm nay là một ngày tốt lành!"
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E88E5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Hôm nay là một ngày tốt lành!',
                              style: TextStyle(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                        // Avatar profile tròn
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Thẻ số dư màu trắng
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Số dư hiện tại',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '5.000.000 đ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.account_balance_wallet, color: Color(0xFF1E88E5), size: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Hàng Thu nhập & Chi tiêu
                    Row(
                      children: [
                        // Cột Thu nhập
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                                    SizedBox(width: 4),
                                    Text('Thu nhập', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '10.000.000 đ',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Cột Chi tiêu
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_downward, color: Colors.red, size: 16),
                                    SizedBox(width: 4),
                                    Text('Chi tiêu', style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '5.000.000 đ',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Tiêu đề: Chi tiêu gần đây
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chi tiêu gần đây',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Danh sách các mục giao dịch mẫu
                    _buildItem(Icons.restaurant, Colors.redAccent, 'Ăn uống', '12/04/2025', '-100.000 đ', Colors.red),
                    _buildItem(Icons.shopping_cart, Colors.blue, 'Mua sắm', '10/04/2025', '-500.000 đ', Colors.red),
                    _buildItem(Icons.attach_money, Colors.green, 'Lương', '05/04/2025', '+10.000.000 đ', Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Nút cộng (+) mở sang Thêm giao dịch
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E88E5),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/add_transaction');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // Thanh điều hướng đáy
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1E88E5),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Giao dịch'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/transaction_list');
          }
        },
      ),
    );
  }

  static Widget _buildItem(IconData icon, Color iconColor, String title, String date, String amount, Color amountColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.15),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(color: amountColor, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}