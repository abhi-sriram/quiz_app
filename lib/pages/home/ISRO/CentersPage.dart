import 'package:flutter/material.dart';

import '../../../backend/Centers.dart';

class CentersPage extends StatefulWidget {
  static const routeName = "/home/isroknowledge/centers";
  const CentersPage({Key? key}) : super(key: key);

  @override
  _CentersPageState createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  Widget appBarTitle = const Text("Centers");
  Icon actionIcon = const Icon(Icons.search);
  List<Map<String, dynamic>> centers = [];
  List<Map<String, dynamic>> searchedCenters = [];
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void buildSearchList(String val) {
    setState(() {
      searchedCenters.clear();
    });

    if (val.trim().isEmpty) {
    } else {
      for (int i = 0; i < centers.length; i++) {
        // searching via name
        String name = centers.elementAt(i)['name'];
        if (name.toLowerCase().contains(val.toLowerCase())) {
          searchedCenters.add(centers.elementAt(i));
        }

        // searching via place
        String place = centers.elementAt(i)['Place'];
        if (place.toLowerCase().contains(val.toLowerCase())) {
          searchedCenters.add(centers.elementAt(i));
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
                appBarTitle = const Text("Centers");
              }
            });
          },
        ),
      ]),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Centers().fetchData(),
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
              itemCount: searchedCenters.length,
              itemBuilder: (ctx, i) {
                return ExpansionTile(
                  title: Text(
                    '${data.data!['data']['centres'][i]["name"]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Place: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${data.data!['data']['centres'][i]["Place"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "State: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${data.data!['data']['centres'][i]["State"]}'),
                      ],
                    ),
                  ],
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: data.data!['data']['centres'].length,
            itemBuilder: (ctx, i) {
              centers.add(data.data!['data']['centres'][i]);

              return ExpansionTile(
                title: Text(
                  '${data.data!['data']['centres'][i]["name"]}',
                  style: const TextStyle(color: Colors.white),
                ),
                textColor: Colors.white,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Place: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${data.data!['data']['centres'][i]["Place"]}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "State: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${data.data!['data']['centres'][i]["State"]}'),
                    ],
                  ),
                ],
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
