import 'package:flutter/material.dart';
import 'package:mini_project/screen/Riwayat/components/list_riwayat.dart';
import 'package:mini_project/screen/components/card_custom.dart';
import 'package:mini_project/screen/components/error_page.dart';
import 'package:mini_project/screen/components/loading_animation.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:mini_project/state/bayi_state.dart';
import 'package:mini_project/state/enum_state.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getState = Provider.of<BayiState>(context, listen: false);
      getState.getDataBayi();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BayiState>(
      builder: ((context, state, child) {
        if (state.stateType == StateType.loading) {
          return const LoadingAnimation();
        }
        if (state.stateType == StateType.error) {
          return const ErrorPage();
        }
        return state.bayiModel.isEmpty
            ? const Center(
                child: Text("Tambah Data Bayimu!"),
              )
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (ctx) => ListRiwayatPage(
                            id: state.bayiModel[i].id_bayi!,
                            nama: state.bayiModel[i].nama,
                          ),
                        ),
                      );
                    },
                    child: CardCustom(
                      child: ListTile(
                        title: Text(state.bayiModel[i].nama),
                        trailing: const Icon(
                          Icons.info_outline_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.bayiModel.length,
              );
      }),
    );
  }
}
