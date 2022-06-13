import 'package:flutter/material.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/components/card_custom.dart';
import 'package:mini_project/screen/components/error_page.dart';
import 'package:mini_project/screen/components/loading_animation.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:mini_project/screen/info_imunisasi/detail_page.dart';
import 'package:mini_project/state/enum_state.dart';
import 'package:mini_project/state/imunisasi_state.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarCustom(
        title: "Informasi Imunisasi",
        page: "/home",
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Consumer<ImunisasiState>(
            builder: (context, state, child) {
              if (state.stateType == StateType.loading) {
                return const LoadingAnimation();
              }
              if (state.stateType == StateType.error) {
                return const ErrorPage();
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        state.changeSearchString(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                  builder: (ctx) => DetailPage(
                                        title:
                                            state.getDataList[i].nama_imunisasi,
                                        desc: state.getDataList[i].deskripsi,
                                      )),
                            );
                          },
                          child: CardCustom(
                            child: ListTile(
                              title: Text(state.getDataList[i].nama_imunisasi),
                              trailing: const Icon(
                                Icons.info_outline_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.getDataList.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
