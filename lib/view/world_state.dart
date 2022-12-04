import 'package:covid_app/model/world_state_model.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:covid_app/view/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorkedStateRecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                          ),
                          // Spacer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Card(
                            child: Column(
                              children: [
                                ReuseabeLRow(
                                    title: 'Total',
                                    vlaue: snapshot.data!.cases.toString()),
                                ReuseabeLRow(
                                    title: 'Recovered',
                                    vlaue: snapshot.data!.recovered.toString()),
                                ReuseabeLRow(
                                    title: 'Deaths',
                                    vlaue: snapshot.data!.deaths.toString()),
                                ReuseabeLRow(
                                    title: 'Active',
                                    vlaue: snapshot.data!.active.toString()),
                                ReuseabeLRow(
                                    title: 'Critical',
                                    vlaue: snapshot.data!.critical.toString()),
                                ReuseabeLRow(
                                    title: 'AffectedCountries',
                                    vlaue: snapshot.data!.affectedCountries
                                        .toString()),
                                ReuseabeLRow(
                                    title: 'CriticalPerOneMillion',
                                    vlaue: snapshot.data!.criticalPerOneMillion
                                        .toString()),
                                ReuseabeLRow(
                                    title: 'recoveredPerOneMillion',
                                    vlaue: snapshot.data!.recoveredPerOneMillion
                                        .toString()),
                                ReuseabeLRow(
                                    title: 'Tests',
                                    vlaue: snapshot.data!.tests.toString()),
                                ReuseabeLRow(
                                    title: 'Population',
                                    vlaue:
                                        snapshot.data!.population.toString()),
                              ],
                            ),
                          ),
                          // Spacer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CountryListSceen()));
                              },
                              child: Center(
                                  child: Text(
                                "Track Counteries",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              )),
                            ),
                          ),
                          // Spacer(
                          //   flex: 10,
                          // ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}

class ReuseabeLRow extends StatelessWidget {
  ReuseabeLRow({super.key, required this.title, required this.vlaue});

  String title, vlaue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(vlaue),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
