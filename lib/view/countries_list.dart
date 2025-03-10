import 'package:covid_19_app/modal/services/states_services.dart';
import 'package:covid_19_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriiesListScreen extends StatefulWidget {
  const CountriiesListScreen({super.key});

  @override
  State<CountriiesListScreen> createState() => _CountriiesListScreenState();
}

class _CountriiesListScreenState extends State<CountriiesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Country Name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.countriesList(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // return Column(
                              //   children: [
                              //     ListTile(
                              //       title:
                              //           Text(snapshot.data![index]['country']),
                              //       subtitle: Text(snapshot.data![index]
                              //               ['cases']
                              //           .toString()),
                              //       leading: Image(
                              //           height: 50,
                              //           width: 50,
                              //           image: NetworkImage(
                              //               snapshot.data![index]["countryInfo"]
                              //                   ["flag"])),
                              //     ),
                              //   ],
                              // );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      image: snapshot
                                                                  .data![index]
                                                              ["countryInfo"]
                                                          ["flag"],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totalTests:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      activeCases:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      criticalCases:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ["countryInfo"]["flag"])),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      image: snapshot
                                                                  .data![index]
                                                              ["countryInfo"]
                                                          ["flag"],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totalTests:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      activeCases:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      criticalCases:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ["countryInfo"]["flag"])),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }

                              // return Column(
                              //   children: [
                              //     ListTile(
                              //       title:
                              //           Text(snapshot.data![index]['country']),
                              //       subtitle: Text(snapshot.data![index]
                              //               ['cases']
                              //           .toString()),
                              //       leading: Image(
                              //           height: 50,
                              //           width: 50,
                              //           image: NetworkImage(
                              //               snapshot.data![index]["countryInfo"]
                              //                   ["flag"])),
                              //     ),
                              //   ],
                              // );
                            });
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
