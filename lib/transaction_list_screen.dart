import 'package:flutter/material.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  String selectedFilter = 'Tất cả';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> allTransactions = [
    {
      'icon': Icons.restaurant,
      'iconColor': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEE2E2),
      'title': 'Ăn uống',
      'date': '12/04/2025',
      'amount': '-100.000 đ',
      'rawAmount': '100.000',
      'note': 'Ăn trưa',
      'isExpense': true,
    },
    {
      'icon': Icons.shopping_cart,
      'iconColor': const Color(0xFF0EA5E9),
      'bgColor': const Color(0xFFE0F2FE),
      'title': 'Mua sắm',
      'date': '10/04/2025',
      'amount': '-500.000 đ',
      'rawAmount': '500.000',
      'note': 'Mua quần áo',
      'isExpense': true,
    },
    {
      'icon': Icons.attach_money,
      'iconColor': const Color(0xFF10B981),
      'bgColor': const Color(0xFFD1FAE5),
      'title': 'Lương',
      'date': '05/04/2025',
      'amount': '+10.000.000 đ',
      'rawAmount': '10.000.000',
      'note': 'Lương tháng 4',
      'isExpense': false,
    },
    {
      'icon': Icons.directions_car,
      'iconColor': const Color(0xFF6366F1),
      'bgColor': const Color(0xFFEEF2FF),
      'title': 'Đi lại',
      'date': '03/04/2025',
      'amount': '-200.000 đ',
      'rawAmount': '200.000',
      'note': 'Đổ xăng',
      'isExpense': true,
    },
    {
      'icon': Icons.menu_book,
      'iconColor': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFFF3E8FF),
      'title': 'Học tập',
      'date': '01/04/2025',
      'amount': '-300.000 đ',
      'rawAmount': '300.000',
      'note': 'Mua sách',
      'isExpense': true,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = allTransactions.where((item) {
      final matchesFilter = (selectedFilter == 'Tất cả') ||
          (selectedFilter == 'Thu nhập' && item['isExpense'] == false) ||
          (selectedFilter == 'Chi tiêu' && item['isExpense'] == true);

      final matchesSearch = item['title'].toString().toLowerCase().contains(searchQuery.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Giao dịch',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm giao dịch...',
                        hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/filter');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_list, color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildFilterButton('Tất cả'),
                const SizedBox(width: 8),
                _buildFilterButton('Thu nhập'),
                const SizedBox(width: 8),
                _buildFilterButton('Chi tiêu'),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: filteredTransactions.isEmpty
                ? const Center(
              child: Text(
                'Không tìm thấy giao dịch nào',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final item = filteredTransactions[index];
                return _buildTransactionItem(
                  context: context,
                  icon: item['icon'] as IconData,
                  iconColor: item['iconColor'] as Color,
                  bgColor: item['bgColor'] as Color,
                  title: item['title'] as String,
                  date: item['date'] as String,
                  amount: item['amount'] as String,
                  rawAmount: item['rawAmount'] as String,
                  note: item['note'] as String,
                  isExpense: item['isExpense'] as bool,
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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
          if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (index == 2) Navigator.pushReplacementNamed(context, '/statistics');
          if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
        },
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    final isSelected = selectedFilter == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String date,
    required String amount,
    required String rawAmount,
    required String note,
    required bool isExpense,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/edit_transaction',
          arguments: {
            'title': title,
            'date': date,
            'amount': rawAmount,
            'note': note,
            'isExpense': isExpense,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 4),
                  Text(date, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isExpense ? const Color(0xFFEF4444) : const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 18, color: Color(0xFFCBD5E1)),
          ],
        ),
      ),
    );
  }
}