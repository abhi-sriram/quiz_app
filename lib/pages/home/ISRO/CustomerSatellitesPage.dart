import 'package:flutter/material.dart';

import '../../../backend/CustomerSatellites.dart';

class CustomerSatellitesPage extends StatefulWidget {
  static const routeName = "/home/isroknowledge/customer_satellites";
  const CustomerSatellitesPage({Key? key}) : super(key: key);

  @override
  _CustomerSatellitesPageState createState() => _CustomerSatellitesPageState();
}

class _CustomerSatellitesPageState extends State<CustomerSatellitesPage> {
  Widget appBarTitle = const Text("Customer Satellites");
  Icon actionIcon = const Icon(Icons.search);
  List<Map<String, dynamic>> satellites = [];
  List<Map<String, dynamic>> searchedSatellites = [];
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void buildSearchList(String val) {
    setState(() {
      searchedSatellites.clear();
    });

    if (val.trim().isEmpty) {
    } else {
      for (int i = 0; i < satellites.length; i++) {
        // searching via ID
        String id = satellites.elementAt(i)['id'];
        if (id.toLowerCase().contains(val.toLowerCase())) {
          searchedSatellites.add(satellites.elementAt(i));
        }

        // searching via launcher
        String launcher = satellites.elementAt(i)['launcher'];
        if (launcher.toLowerCase().contains(val.toLowerCase())) {
          searchedSatellites.add(satellites.elementAt(i));
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
                appBarTitle = const Text("Customer Satellites");
              }
            });
          },
        ),
      ]),
      body: FutureBuilder<Map<String, dynamic>>(
        future: CustomerSatellites().fetchData(),
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
              itemCount: searchedSatellites.length,
              itemBuilder: (ctx, i) {
                return ExpansionTile(
                  title: Text(
                    '${data.data!['data']['customer_satellites'][i]["id"]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  textColor: Colors.white,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Country: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${data.data!['data']['customer_satellites'][i]["country"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Launch Date: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${data.data!['data']['customer_satellites'][i]["launch_date"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Mass: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${data.data!['data']['customer_satellites'][i]["mass"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Launcher: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${data.data!['data']['customer_satellites'][i]["launcher"]}'),
                      ],
                    ),
                  ],
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: data.data!['data']['customer_satellites'].length,
            itemBuilder: (ctx, i) {
              satellites.add(data.data!['data']['customer_satellites'][i]);

              return ExpansionTile(
                title: Text(
                  '${data.data!['data']['customer_satellites'][i]["id"]}',
                  style: const TextStyle(color: Colors.white),
                ),
                textColor: Colors.white,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Country: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '${data.data!['data']['customer_satellites'][i]["country"]}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Launch Date: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '${data.data!['data']['customer_satellites'][i]["launch_date"]}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Mass: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '${data.data!['data']['customer_satellites'][i]["mass"]}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Launcher: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '${data.data!['data']['customer_satellites'][i]["launcher"]}'),
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
