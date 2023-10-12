import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redlenshoescleaning/view/admin/pengeluaran/pengeluaran.dart';
import 'package:redlenshoescleaning/view/admin/treatment/treatment.dart';
import 'package:redlenshoescleaning/view/admin/laporanpage.dart';
import 'package:redlenshoescleaning/view/admin/pesananpage.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LaporanPage(),
    const PesananPage(),
    const Pengeluaran(),
    const Treatment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Enable immersive mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(0xFFD9D9D9),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_sharp),
                label: 'Pesanan',
                backgroundColor: Color(0xFFD9D9D9),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_down_sharp),
                label: 'Pengeluaran',
                backgroundColor: Color(0xFFD9D9D9),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_sharp),
                label: 'Treatment',
                backgroundColor: Color(0xFFD9D9D9),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
