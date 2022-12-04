import 'package:covid_app/view/world_state.dart';
import 'package:flutter/material.dart';

class DetailsScreenCoun extends StatefulWidget {
  DetailsScreenCoun(
      {required this.name,
      required this.cases,
      required this.todayCases,
      required this.deaths,
      required this.todayDeaths, 
      required this.recovered,
      required this.todayRecovered, 
      required this.flag});

  String name, flag;
  int cases, todayCases, deaths, todayDeaths, recovered, todayRecovered;

  @override
  State<DetailsScreenCoun> createState() => _DetailsScreenCounState();
}

class _DetailsScreenCounState extends State<DetailsScreenCoun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 90),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReuseabeLRow(title: 'cases', vlaue: widget.cases.toString()),
               
                ReuseabeLRow(title: 'todayCases', vlaue: widget.todayCases.toString()),
                ReuseabeLRow(title: 'deaths', vlaue: widget.deaths.toString()),
                ReuseabeLRow(title: 'todayDeaths', vlaue: widget.todayDeaths.toString()),
                 ReuseabeLRow(title: 'recovered', vlaue: widget.recovered.toString()),
                  ReuseabeLRow(title: 'todayRecovered', vlaue: widget.todayRecovered.toString()),
            
              ],
            ),
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(widget.flag),
            ),
          ],
          
        ),
      ),
      
    );
  }
}
