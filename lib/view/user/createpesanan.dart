import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redlenshoescleaning/controller/pesanancontroller.dart';
import 'package:redlenshoescleaning/model/pesananmodel.dart';
import 'package:redlenshoescleaning/view/user/dashboarduser.dart';

class CreatePesanan extends StatefulWidget {
  const CreatePesanan({Key? key}) : super(key: key);

  @override
  State<CreatePesanan> createState() => _CreatePesananState();
}

class _CreatePesananState extends State<CreatePesanan> {
  final _formKey = GlobalKey<FormState>();
  final pesananController = PesananController();

  String? selectedDate;
  String? namapemilik;
  String? notelepon;
  String? sepatu;
  String? harga;
  String? listitem;

  final TextEditingController hargaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardUser(),
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        centerTitle: true,
        title: Text(
          'Tambahkan Pesanan',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 350,
              height: 900,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tanggal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: _tanggalController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime? tanggal = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2025),
                                );

                                if (tanggal != null) {
                                  selectedDate =
                                      DateFormat('dd-MM-yyyy').format(tanggal);

                                  setState(() {
                                    _tanggalController.text =
                                        selectedDate.toString();
                                  });
                                }
                              },
                            ),
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nama Pemilik',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Nama Pemilik',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama pemilik tidak boleh kosong!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            namapemilik = value;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'No. Telepon',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'No. Telepon',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'No. Telepon tidak boleh kosong!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            notelepon = value;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sepatu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Sepatu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sepatu tidak boleh kosong!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            sepatu = value;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Jenis Treatment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('treatments')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            List<DropdownMenuItem<String>> dropdownItems = [];
                            final items = snapshot.data!.docs;
                            for (var item in items) {
                              // Assuming the 'jenistreatment' field exists in each document
                              String itemName = item['jenistreatment'];
                              dropdownItems.add(
                                DropdownMenuItem(
                                  value: itemName,
                                  child: Text(itemName),
                                ),
                              );
                            }
                            return Container(
                              width: 300,
                              child: DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(10.0),
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_rounded),
                                value: listitem,
                                items: dropdownItems,
                                onChanged: (item) async {
                                  setState(() {
                                    listitem = item;
                                  });
                                  harga = await getHargaByItem(
                                      item!); // Fetch the harga for the selected item
                                },
                                decoration: InputDecoration(
                                  hintText: 'Pilih Jenis Treatment',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Jenis treatment tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            );
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Harga',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: FutureBuilder<String?>(
                          future: listitem != null
                              ? getHargaByItem(listitem!)
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              String harga = snapshot.data ?? '';
                              return TextFormField(
                                initialValue: harga,
                                decoration: InputDecoration(
                                  hintText: 'Harga',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                readOnly: true,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Konfirmasi Pesanan'),
                                  content: const Text(
                                      'Apakah Anda yakin ingin menyimpan pesanan?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Batal',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        PesananModel pesmodel = PesananModel(
                                          status: "Pending",
                                          selectedDate: selectedDate!,
                                          namapemilik: namapemilik!,
                                          notelepon: notelepon!,
                                          sepatu: sepatu!,
                                          listitem: listitem!,
                                          harga: harga!,
                                        );
                                        pesananController.addPesanan(pesmodel);
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Pesanan Ditambahkan'),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardUser(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Tambahkan Pesanan',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF454BE0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          minimumSize: const Size(150, 50),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> getHargaByItem(String selectedItem) async {
  try {
    // Perform a query to get the harga from Firestore based on the selected item
    var snapshot = await FirebaseFirestore.instance
        .collection('treatments')
        .where('jenistreatment', isEqualTo: selectedItem)
        .limit(1)
        .get();

    // Assuming the 'harga' field exists in each document
    if (snapshot.docs.isNotEmpty) {
      var document = snapshot.docs.first;
      if (document.data().containsKey('harga')) {
        return document.data()['harga'].toString();
      }
    }
  } catch (e) {
    print('Error fetching harga: $e');
  }

  return null;
}
