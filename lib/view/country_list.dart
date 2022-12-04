import 'package:covid_app/services/states_services.dart';
import 'package:covid_app/view/details_screen_coun.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListSceen extends StatefulWidget {
  const CountryListSceen({super.key});

  @override
  State<CountryListSceen> createState() => _CountryListSceenState();
}

class _CountryListSceenState extends State<CountryListSceen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: stateServices.countriesListApi(),
                    builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(
                                          height: 10,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 10,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100);
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailsScreenCoun(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                cases: snapshot.data![index]
                                                    ['cases'], 
                                                    todayCases: snapshot.data![index]
                                                    ['todayCases'], 
                                                    deaths: snapshot.data![index]
                                                    ['deaths'], 
                                                    recovered: snapshot.data![index]
                                                    ['recovered'], 
                                                    todayDeaths: snapshot.data![index]
                                                    ['todayDeaths'], 
                                                    todayRecovered: snapshot.data![index]
                                                    ['todayRecovered'],
                                                     flag: snapshot.data![index]
                                                    ['countryInfo']['flag'],),
                                                    
                                           
                                            ));
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
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
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                         Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailsScreenCoun(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                cases: snapshot.data![index]
                                                    ['cases'], 
                                                    todayCases: snapshot.data![index]
                                                    ['todayCases'], 
                                                    deaths: snapshot.data![index]
                                                    ['deaths'], 
                                                    recovered: snapshot.data![index]
                                                    ['recovered'], 
                                                    todayDeaths: snapshot.data![index]
                                                    ['todayDeaths'], 
                                                    todayRecovered: snapshot.data![index]
                                                    ['todayRecovered'],
                                                     flag: snapshot.data![index]
                                                    ['countryInfo']['flag'],),
                                                    
                                           
                                            ));
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
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                              // return Column(
                              //   children: [
                              //     ListTile(
                              //       title: Text(snapshot.data![index]['country']),
                              //       subtitle: Text(snapshot.data![index]['cases'].toString()),
                              //       leading: Image(
                              //           height: 50,
                              //           width: 50,
                              //           image: NetworkImage(snapshot.data![index]
                              //               ['countryInfo']['flag'])),
                              //     ),
                              //   ],
                              // );
                            });
                      }
                    })))
          ],
        ),
      ),
    );
  }
}
