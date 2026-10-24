import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Trạng thái cho mục Loại giao dịch
  String selectedTransactionType = 'Tất cả';

  // Trạng thái cho mục Danh mục
  String selectedCategory = 'Tất cả danh mục';

  // Trạng thái cho mục Khoảng thời gian
  String selectedTimeRange = 'Hôm nay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Quay lại màn hình giao dịch
        ),
        title: const Text(
          'Bộ lọc',
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
              // 1. Loại giao dịch
              const Text(
                'Loại giao dịch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),
              _buildCheckboxOption('Tất cả'),
              _buildCheckboxOption('Thu nhập'),
              _buildCheckboxOption('Chi tiêu'),

              const SizedBox(height: 24),

              // 2. Danh mục
              const Text(
                'Danh mục',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                    items: [
                      'Tất cả danh mục',
                      'Ăn uống',
                      'Mua sắm',
                      'Lương',
                      'Đi lại',
                      'Học tập',
                    ].map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF334155)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedCategory = value);
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 3. Khoảng thời gian
              const Text(
                'Khoảng thời gian',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),
              _buildRadioOption('Hôm nay'),
              _buildRadioOption('7 ngày qua'),
              _buildRadioOption('Tháng này'),
              _buildRadioOption('Tùy chỉnh'),

              const Spacer(),

              // Nút Áp dụng
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Áp dụng bộ lọc và quay lại màn hình danh sách giao dịch
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Áp dụng',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

  // Widget hiển thị lựa chọn kiểu Checkbox cho Loại giao dịch
  Widget _buildCheckboxOption(String title) {
    final isSelected = selectedTransactionType == title;
    return InkWell(
      onTap: () {
        setState(() => selectedTransactionType = title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị lựa chọn kiểu Radio cho Khoảng thời gian
  Widget _buildRadioOption(String title) {
    final isSelected = selectedTimeRange == title;
    return InkWell(
      onTap: () {
        setState(() => selectedTimeRange = title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}