import 'package:flutter/material.dart';
import 'package:quiz_app/backend/Spacecrafts.dart';

class SpacecraftsPage extends StatefulWidget {
  static const routeName = "/home/isroknowledge/spacecrafts";

  const SpacecraftsPage({Key? key}) : super(key: key);

  @override
  _SpacecraftsPageState createState() => _SpacecraftsPageState();
}

class _SpacecraftsPageState extends State<SpacecraftsPage> {
  Widget appBarTitle = Text("Spacecrafts");
  Icon actionIcon = Icon(Icons.search);
  List<String> spacecrafts = [];
  List<String> searchedSpacecrafts = [];
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void buildSearchList(String val) {
    setState(() {
      searchedSpacecrafts.clear();
    });

    if (val.trim().isEmpty) {
    } else {
      for (int i = 0; i < spacecrafts.length; i++) {
        String name = spacecrafts.elementAt(i);
        if (name.toLowerCase().contains(val.toLowerCase())) {
          searchedSpacecrafts.add(name);
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
                appBarTitle = const Text("AppBar Title");
              }
            });
          },
        ),
      ]),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Spacecrafts().fetchData(endPoint: 'spacecrafts'),
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
              itemCount: searchedSpacecrafts.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(searchedSpacecrafts[i]),
                  textColor: Colors.white,
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: data.data!['data']['spacecrafts'].length,
            itemBuilder: (ctx, i) {
              spacecrafts.add(data.data!['data']['spacecrafts'][i]["name"]);
              return ListTile(
                title: Text('${data.data!['data']['spacecrafts'][i]["name"]}'),
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
