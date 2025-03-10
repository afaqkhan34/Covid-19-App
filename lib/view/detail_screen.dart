import 'package:flutter/material.dart';
import 'package:covid_19_app/view/world_states.dart';
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      activeCases,
      criticalCases,
      totalTests;

  DetailScreen(
      {required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.activeCases,
      required this.criticalCases,
      required this.totalTests});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Stack(
           alignment: Alignment.topCenter,
           children : [

             Padding(
               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
               child: Card(
                 child:Column(
                   children : [
                     SizedBox(height: MediaQuery.of(context).size.height * .04),
                    ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                    ReusableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                     ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Active Cases', value: widget.activeCases.toString()),
                     ReusableRow(title: 'Critical Cases', value: widget.criticalCases.toString()),
                     ReusableRow(title: 'Total Tests', value: widget.totalTests.toString()),

                 ],
                 ),
               ),
             ),
             CircleAvatar(
               radius: 50,
               backgroundImage: NetworkImage(widget.image),
             ),
           ],
         ),
       ],
     ),
    );
  }
}
