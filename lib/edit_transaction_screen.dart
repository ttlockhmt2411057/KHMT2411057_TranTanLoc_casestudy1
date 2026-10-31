import 'package:flutter/material.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({super.key});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  bool isExpense = true;
  late TextEditingController amountController;
  late TextEditingController dateController;
  late TextEditingController noteController;
  String selectedCategory = 'Ăn uống';
  bool isInitialized = false;

  // Dữ liệu Icon và Màu tương ứng từng danh mục
  final Map<String, Map<String, dynamic>> categoryStyles = {
    'Ăn uống': {
      'icon': Icons.restaurant,
      'color': const Color(0xFFEF4444),
      'bgColor': const Color(0xFFFEE2E2),
    },
    'Mua sắm': {
      'icon': Icons.shopping_cart,
      'color': const Color(0xFF0EA5E9),
      'bgColor': const Color(0xFFE0F2FE),
    },
    'Lương': {
      'icon': Icons.attach_money,
      'color': const Color(0xFF10B981),
      'bgColor': const Color(0xFFD1FAE5),
    },
    'Đi lại': {
      'icon': Icons.directions_car,
      'color': const Color(0xFF6366F1),
      'bgColor': const Color(0xFFEEF2FF),
    },
    'Học tập': {
      'icon': Icons.menu_book,
      'color': const Color(0xFF8B5CF6),
      'bgColor': const Color(0xFFF3E8FF),
    },
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        selectedCategory = args['title'] ?? 'Ăn uống';
        isExpense = args['isExpense'] ?? true;
        amountController = TextEditingController(text: args['amount'] ?? '100.000');
        dateController = TextEditingController(text: args['date'] ?? '12/04/2025');
        noteController = TextEditingController(text: args['note'] ?? '');
      } else {
        amountController = TextEditingController(text: '100.000');
        dateController = TextEditingController(text: '12/04/2025');
        noteController = TextEditingController(text: 'Ăn trưa');
      }
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStyle = categoryStyles[selectedCategory] ?? categoryStyles['Ăn uống']!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sửa giao dịch',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chọn loại Chi tiêu / Thu nhập
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isExpense = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isExpense ? const Color(0xFFEF4444) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Chi tiêu',
                            style: TextStyle(
                              color: isExpense ? Colors.white : const Color(0xFF64748B),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isExpense = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isExpense ? const Color(0xFF1E88E5) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Thu nhập',
                            style: TextStyle(
                              color: !isExpense ? Colors.white : const Color(0xFF64748B),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Danh mục kèm icon động theo danh mục được chọn
              const Text(
                'Danh mục',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: currentStyle['bgColor'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        currentStyle['icon'] as IconData,
                        color: currentStyle['color'] as Color,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          items: ['Ăn uống', 'Mua sắm', 'Lương', 'Đi lại', 'Học tập'].map((cat) {
                            return DropdownMenuItem(value: cat, child: Text(cat, style: const TextStyle(fontSize: 14)));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => selectedCategory = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Số tiền
              const Text(
                'Số tiền',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  suffixText: 'đ',
                  suffixStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Ngày giao dịch
              const Text(
                'Ngày giao dịch',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF94A3B8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Ghi chú
              const Text(
                'Ghi chú',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),

              const Spacer(),

              // Nút Lưu
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
// Cập nhật cho buổi 6