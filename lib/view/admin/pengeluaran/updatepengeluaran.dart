import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redlenshoescleaning/controller/pengeluarancontroller.dart';
import 'package:redlenshoescleaning/model/pengeluaranmodel.dart';
import 'package:redlenshoescleaning/view/admin/dashboardadmin.dart';
import 'package:redlenshoescleaning/view/admin/pengeluaran/pengeluaran.dart';

class UpdatePengeluaran extends StatefulWidget {
  const UpdatePengeluaran({
    Key? key,
    this.id,
    this.selectedDate,
    this.namabarang,
    this.hargabarang,
  }) : super(key: key);

  final String? id;
  final String? selectedDate;
  final String? namabarang;
  final String? hargabarang;

  @override
  State<UpdatePengeluaran> createState() => _UpdatePengeluaranState();
}

class _UpdatePengeluaranState extends State<UpdatePengeluaran> {
  var pengeluaranController = PengeluaranController();

  final _formkey = GlobalKey<FormState>();

  String? newselectedDate;
  String? newnamabarang;
  String? newhargabarang;

  final TextEditingController _tanggalController = TextEditingController();

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Yakin ingin mengubah pengeluaran?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ubah'),
              onPressed: () {
                Navigator.of(context).pop();
                _updatePengeluaran();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatePengeluaran() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      PengeluaranModel pm = PengeluaranModel(
        id: widget.id,
        selectedDate: newselectedDate!.toString(),
        namabarang: newnamabarang!.toString(),
        hargabarang: newhargabarang!.toString(),
      );
      pengeluaranController.updatePengeluaran(pm);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengeluaran Berubah'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Pengeluaran(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tanggalController.text = widget.selectedDate!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9D9D9),
        centerTitle: true,
        title: Text(
          'Edit Pengeluaran',
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
              height: 520,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formkey,
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
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (tanggal != null) {
                                  newselectedDate = DateFormat('dd-MM-yyyy')
                                      .format(tanggal)
                                      .toString();

                                  setState(() {
                                    _tanggalController.text = newselectedDate!;
                                  });
                                }
                              },
                            ),
                          ),
                          onSaved: (value) {
                            newselectedDate = value;
                          },
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
                            'Nama Barang',
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama barang tidak boleh kosong!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newnamabarang = value;
                          },
                          initialValue: widget.namabarang,
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
                            'Harga Barang',
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harga barang tidak boleh kosong!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newhargabarang = value;
                          },
                          initialValue: widget.hargabarang,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Konfirmasi Perubahan'),
                                content: const Text(
                                    'Yakin ingin mengubah pengeluaran?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Batal',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Ubah',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();
                                        PengeluaranModel pm = PengeluaranModel(
                                          id: widget.id,
                                          selectedDate:
                                              newselectedDate!.toString(),
                                          namabarang: newnamabarang!.toString(),
                                          hargabarang:
                                              newhargabarang!.toString(),
                                        );
                                        pengeluaranController
                                            .updatePengeluaran(pm);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Pengeluaran Berubah'),
                                          ),
                                        );
                                        Navigator.pop(context, true);
                                        Navigator.pop(context, true);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
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
