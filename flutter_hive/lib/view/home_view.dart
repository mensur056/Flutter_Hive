import 'package:flutter/material.dart';
import 'package:flutter_hive/service/service.dart';

import '../service/user_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final IService iService;
  List<UserModel>? items;
  @override
  void initState() {
    super.initState();
    iService = GeneralService();
    fetchItem();
  }

  Future<void> fetchItem() async {
    changeLoading();
    items = await iService.fetchItemFromApi();
    changeLoading();

    print(items);
  }

  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading != isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: !isLoading
            ? ListView.builder(
                itemCount: items?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(items?[index].name ?? ''),
                    ),
                  );
                },
              )
            : const CircularProgressIndicator());
  }
}
