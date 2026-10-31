import 'dart:math';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            'Thống kê',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // 3 nút chọn kỳ: Tháng này, Tháng trước, Năm nay
              Row(
                children: [
                  _buildPeriodTab('Tháng này', true),
                  const SizedBox(width: 8),
                  _buildPeriodTab('Tháng trước', false),
                  const SizedBox(width: 8),
                  _buildPeriodTab('Năm nay', false),
                ],
              ),
              const SizedBox(height: 32),

              // Biểu đồ tròn Donut nhiều màu vẽ bằng CustomPainter
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(200, 200),
                        painter: _MultiSegmentPiePainter(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '5.000.000 đ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tổng chi tiêu',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Danh sách chi tiết tỷ lệ % các mục
              _buildStatRow(const Color(0xFFEF4444), 'Ăn uống', '2.000.000 đ', '40%'),
              _buildStatRow(const Color(0xFFF87171), 'Mua sắm', '1.500.000 đ', '30%'),
              _buildStatRow(const Color(0xFF10B981), 'Đi lại', '700.000 đ', '14%'),
              _buildStatRow(const Color(0xFF3B82F6), 'Học tập', '500.000 đ', '10%'),
              _buildStatRow(const Color(0xFF8B5CF6), 'Khác', '300.000 đ', '6%'),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar - đang ở vị trí tab số 2 (Thống kê)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/transaction_list');
          }
        },
      ),
    );
  }

  Widget _buildPeriodTab(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(Color dotColor, String title, String amount, String percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 36,
            child: Text(
              percent,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Vẽ biểu đồ tròn Donut chia đúng tỷ lệ % của các màu
class _MultiSegmentPiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 14;

    final segments = [
      {'color': const Color(0xFFEF4444), 'percent': 0.40}, // Ăn uống 40%
      {'color': const Color(0xFFF87171), 'percent': 0.30}, // Mua sắm 30%
      {'color': const Color(0xFF10B981), 'percent': 0.14}, // Đi lại 14%
      {'color': const Color(0xFF3B82F6), 'percent': 0.10}, // Học tập 10%
      {'color': const Color(0xFF8B5CF6), 'percent': 0.06}, // Khác 6%
    ];

    double startAngle = -pi / 2;

    for (var seg in segments) {
      final sweepAngle = (seg['percent'] as double) * 2 * pi;
      final paint = Paint()
        ..color = seg['color'] as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 26;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}