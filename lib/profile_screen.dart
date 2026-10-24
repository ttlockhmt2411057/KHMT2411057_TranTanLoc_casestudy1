import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            'Cá nhân',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2E8F0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 38,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Nguyễn Văn A',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'nguyenvana@example.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Thông tin cá nhân',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.tune,
                title: 'Cài đặt ngân sách',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.format_list_bulleted,
                title: 'Danh mục chi tiêu',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.cloud_upload_outlined,
                title: 'Sao lưu dữ liệu',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                title: 'Đổi mật khẩu',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.logout,
                title: 'Đăng xuất',
                isDestructive: true,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
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
          if (index == 1) Navigator.pushReplacementNamed(context, '/transaction_list');
          if (index == 2) Navigator.pushReplacementNamed(context, '/statistics');
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final textColor = isDestructive ? const Color(0xFFEF4444) : const Color(0xFF1E293B);
    final iconColor = isDestructive ? const Color(0xFFEF4444) : const Color(0xFF475569);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Color(0xFFCBD5E1),
            ),
          ],
        ),
      ),
    );
  }
}