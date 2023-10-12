import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redlenshoescleaning/view/loginpage.dart';

import '../../controller/authcontroller.dart';
import '../../controller/pesanancontroller.dart';
import '../../controller/pengeluarancontroller.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final AuthController authController = AuthController();
  final PesananController pesananController = PesananController();
  final PengeluaranController pengeluaranController = PengeluaranController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        centerTitle: true,
        title: Text(
          'REDLEN APPS',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<String>>(
            future: Future.wait([
              getTotalPengeluaran(),
              getTotalPendapatan(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<String> data = snapshot.data!;
                final String totalPengeluaran = data[0];
                final String totalPendapatan = data[1];

                double laba = double.parse(totalPendapatan) -
                    double.parse(totalPengeluaran);
                double rugi = double.parse(totalPendapatan) -
                    double.parse(totalPengeluaran);

                if (laba >= 0) {
                  rugi = 0;
                } else {
                  laba = 0;
                }

                return Container(
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pendapatan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 85),
                            Text(
                              'Pengeluaran',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDecorationBox(double.parse(totalPendapatan)),
                            const SizedBox(width: 20),
                            _buildDecorationBox(double.parse(totalPengeluaran)),
                          ],
                        ),
                        const SizedBox(height: 65),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Laba',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 140),
                            Text(
                              'Rugi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDecorationBox(laba),
                            const SizedBox(width: 20),
                            _buildDecorationBox(rugi),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> getTotalPengeluaran() async {
    final totalPengeluaran = await pengeluaranController.getTotalPengeluaran();
    return totalPengeluaran;
  }

  Future<String> getTotalPendapatan() async {
    final totalPendapatan = await pesananController.getTotalPendapatan();
    return totalPendapatan;
  }
}

Widget _buildDecorationBox(double value) {
  return Container(
    width: 150,
    height: 35,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        value.toStringAsFixed(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
