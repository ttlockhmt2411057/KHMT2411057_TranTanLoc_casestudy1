import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'dashboard_screen.dart';
import 'transaction_list_screen.dart';
import 'add_transaction_screen.dart';
import 'edit_transaction_screen.dart';
import 'statistics_screen.dart';
import 'profile_screen.dart';
import 'filter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/transaction_list': (context) => TransactionListScreen(),
        '/add_transaction': (context) => const AddTransactionScreen(),
        '/edit_transaction': (context) => const EditTransactionScreen(),
        '/statistics': (context) => const StatisticsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/filter': (context) => const FilterScreen(),
      },
    );
  }
}