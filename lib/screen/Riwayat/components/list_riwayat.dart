import 'package:flutter/material.dart';
import 'package:mini_project/screen/Riwayat/components/tambah_data.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/components/card_custom.dart';
import 'package:mini_project/screen/components/error_page.dart';
import 'package:mini_project/screen/components/floating_button.dart';
import 'package:mini_project/screen/components/loading_animation.dart';
import 'package:mini_project/state/enum_state.dart';
import 'package:mini_project/state/riwayat_state.dart';
import 'package:provider/provider.dart';

class ListRiwayatPage extends StatefulWidget {
  final int id;
  final String nama;
  const ListRiwayatPage({
    Key? key,
    required this.id,
    required this.nama,
  }) : super(key: key);

  @override
  State<ListRiwayatPage> createState() => _ListRiwayatPageState();
}

class _ListRiwayatPageState extends State<ListRiwayatPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getState = Provider.of<RiwayatState>(context, listen: false);
      getState.getDataRiwayat(widget.id);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Riwayat ${widget.nama}",
        page: "/riwayat",
      ),
      body: Consumer<RiwayatState>(
        builder: (ctx, state, child) {
          if (state.stateType == StateType.loading) {
            return const LoadingAnimation();
          }
          if (state.stateType == StateType.error) {
            return const ErrorPage();
          }
          return state.riwayatModel.isEmpty
              ? const Center(
                  child: Text("Data Masih Kosong!"),
                )
              : ListView.builder(
                  itemBuilder: (ctx, i) {
                    return CardCustom(
                      child: ListTile(
                        leading: const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 50,
                        ),
                        title: Text("Sudah ${state.riwayatModel[i].imunisasi}"),
                        subtitle: Text(
                            "Dilakukan Tanggal : ${state.riwayatModel[i].tanggal_imunisasi}"),
                      ),
                    );
                  },
                  itemCount: state.riwayatModel.length,
                );
        },
      ),
      floatingActionButton: FloatingBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahRiwayatPage(
                id: widget.id,
              ),
            ),
          );
        },
      ),
    );
  }
}
