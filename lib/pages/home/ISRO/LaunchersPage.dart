import 'package:flutter/material.dart';
import 'package:quiz_app/backend/Launchers.dart';

class LaunchersPage extends StatefulWidget {
  static const routeName = "/home/isroknowledge/launchers";
  const LaunchersPage({Key? key}) : super(key: key);

  @override
  _LaunchersPageState createState() => _LaunchersPageState();
}

class _LaunchersPageState extends State<LaunchersPage> {
  Widget appBarTitle = const Text("Launchers");
  Icon actionIcon = const Icon(Icons.search);
  List<String> launchers = [];
  List<String> searchedLaunchers = [];
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void buildSearchList(String val) {
    setState(() {
      searchedLaunchers.clear();
    });

    if (val.trim().isEmpty) {
    } else {
      for (int i = 0; i < launchers.length; i++) {
        String name = launchers.elementAt(i);
        if (name.toLowerCase().contains(val.toLowerCase())) {
          searchedLaunchers.add(name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                isSearching = true;

                actionIcon = const Icon(Icons.close);
                appBarTitle = TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (val) => buildSearchList(val),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                isSearching = false;
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Launchers");
              }
            });
          },
        ),
      ]),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Launchers().fetchData(),
        builder: (ctx, data) {
          if (!data.hasData) {
            return const Center(
              child: Text(
                "Preparing...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            );
          }

          if (data.data!['responseCode'] == 400) {
            return const Center(
              child: Text(
                "Data not found",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                ),
              ),
            );
          }

          if (isSearching) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: searchedLaunchers.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(searchedLaunchers[i]),
                  textColor: Colors.white,
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: data.data!['data']['launchers'].length,
            itemBuilder: (ctx, i) {
              launchers.add(data.data!['data']['launchers'][i]["id"]);
              return ListTile(
                title: Text('${data.data!['data']['launchers'][i]["id"]}'),
                textColor: Colors.white,
              );
            },
            separatorBuilder: (ctx, i) {
              return Divider(
                color: Colors.grey.shade300,
              );
            },
          );
        },
      ),
    );
  }
}
