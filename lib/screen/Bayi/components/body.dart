import 'package:flutter/material.dart';
import 'package:mini_project/screen/components/card_custom.dart';
import 'package:mini_project/screen/components/error_page.dart';
import 'package:mini_project/screen/components/loading_animation.dart';
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
                child: Text("Data Masih Kosong!"),
              )
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  return CardCustom(
                    child: ListTile(
                      leading: state.bayiModel[i].gender == "Pria"
                          ? const Icon(
                              Icons.male,
                              color: Colors.blueAccent,
                              size: 50,
                            )
                          : const Icon(
                              Icons.female,
                              color: Colors.pinkAccent,
                              size: 50,
                            ),
                      title: Text(
                        state.bayiModel[i].nama,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                          "Tanggal Lahir : ${state.bayiModel[i].tanggal_lahir}"),
                    ),
                  );
                },
                itemCount: state.bayiModel.length,
              );
      }),
    );
  }
}
