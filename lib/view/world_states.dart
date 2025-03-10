import 'package:covid_19_app/modal/services/states_services.dart';
import 'package:covid_19_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../modal/world_states_model.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 80),
          child: Column(
            children: [
              FutureBuilder<WorldStatesModel>(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error loading data: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text("No data available"),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": snapshot.data!.cases?.toDouble() ?? 0.0,
                            "Recovered": snapshot.data!.recovered?.toDouble() ?? 0.0,
                            "Deaths": snapshot.data!.deaths?.toDouble() ?? 0.0,
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * .09),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered?.toString() ?? 'N/A',
                                ),
                                ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical?.toString() ?? 'N/A',
                                ),
                                ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths?.toString() ?? 'N/A',
                                ), ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString() ?? 'N/A',
                                ), ReusableRow(
                                  title: 'Today Cases',
                                  value: snapshot.data!.todayCases.toString() ?? 'N/A',
                                ), ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString() ?? 'N/A',
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriiesListScreen()));
                          },
                          child: Container(
                            height: 51,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                          ),

                        ),
                        ),
                  ],

                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}


