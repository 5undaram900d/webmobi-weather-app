
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webmobi_weather_app/Controllers/a03_api_controllers.dart';
import 'package:webmobi_weather_app/Models/a02_weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var nameController = TextEditingController();
  var nameValue = 'kanpur';

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 38,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async{
                      var name = nameController.text.toString();
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('name', name);
                      nameValue = name;
                      setState(() {

                      });
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: FutureBuilder(
        future: fetchWeather(nameValue),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          debugPrint(nameController.toString());
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              WeatherModel data = snapshot.data;
              debugPrint(data.location.city);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.location.city.toString(), style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 30),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/main_logo.png', height: 80, width: 80,),
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${data.currentObservation.condition.temperature.toString()}℉',         // by default it has white color
                                      style: const TextStyle(color: Colors.black, fontSize: 35)
                                  ),
                                  TextSpan(
                                      text: '  ${data.currentObservation.condition.text.toString()}',         // by default it has white color
                                      style: const TextStyle(color: Colors.black, fontSize: 15, letterSpacing: 2)
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(onPressed: null, icon: const Icon(CupertinoIcons.sunrise, color: Colors.yellow, size: 20,), label: Text(data.currentObservation.astronomy.sunrise, style: const TextStyle(color: Colors.black),),),
                          TextButton.icon(onPressed: null, icon: const Icon(CupertinoIcons.sunset, color: Colors.yellowAccent, size: 20,), label: Text(data.currentObservation.astronomy.sunset, style: const TextStyle(color: Colors.black),),),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(3, (index) {

                          var iconList = [
                            "assets/images/visible.png",
                            "assets/images/humidity.png",
                            "assets/images/speed.png"
                          ];
                          var values = [(data.currentObservation.atmosphere.visibility.toString()), data.currentObservation.atmosphere.humidity.toString(), '${data.currentObservation.wind.speed.toString()} km/hour, ${data.currentObservation.wind.direction.toString()}'];

                          return Column(
                            children: [
                              const SizedBox(height: 10,),

                              Image.asset(iconList[index], width: 80, height: 80,),

                              const SizedBox(height: 10,),

                              Text(values[index], style: TextStyle(color: Colors.grey[600]),)
                            ],
                          );
                        }),
                      ),

                      const SizedBox(height: 10,),
                      const Divider(thickness: 2,),
                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Forecasts', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                          TextButton(onPressed: (){}, child: const Text('View All'))
                        ],
                      ),

                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index){

                          return Card(
                            color: Colors.grey.shade300,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(data.forecasts[index].day.toString(), style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),)),

                                  Expanded(
                                    child: TextButton(
                                      onPressed: null,
                                      child: Text(data.forecasts[index].text.toString(), style: const TextStyle(color: Colors.black),),
                                    ),
                                  ),

                                  RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: data.forecasts[index].high.toString(),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
                                          ),

                                          TextSpan(
                                            text: '/${data.forecasts[index].low.toString()}',
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            else{
              return const Text('Data not fetch either API limit extends', style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),);
            }
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }



  void getValue() async{
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString('name');
    nameValue = getName ?? 'kanpur';
    setState(() {

    });
  }

}
