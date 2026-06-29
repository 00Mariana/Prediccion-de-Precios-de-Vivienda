import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/prediction_screen.dart';
import 'screens/comparison_screen.dart';

void main() {
  runApp(const PrediccionViviendaApp());
}

class PrediccionViviendaApp extends StatelessWidget {
  const PrediccionViviendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prediccion de Vivienda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const PredictionScreen(),
    const ComparisonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate),
            label: 'Predecir',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare),
            label: 'Comparar',
          ),
        ],
      ),
    );
  }
}
