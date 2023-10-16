import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'additional.dart';
import 'hour.dart';
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
    double temp =0; 
    late Future<Map<String,dynamic>> weather;
     Future<Map<String,dynamic>> getCurrentWeather() async{
    try{
    //  setState(() {
    //    isLoading=true;
    //  });
      String cityName ='London';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'
        ),
      );

      final data = jsonDecode(res.body);

      if(data['cod'] !='200')
      {
        throw 'An Unexpected error occurred';
      }
      return data ;
      
    // setState(() {
    // temp=(data['list'][0]['main']['temp']);
   //    isLoading=false; 
    // }
    // );
      }
      catch(e){
        throw e.toString();
      }
  }
@override
void initState() {
    super.initState();
    weather = getCurrentWeather();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Weather App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  ))),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  weather =getCurrentWeather();
                });
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body:FutureBuilder(
            future: weather,
             builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator.adaptive());
              }
              if(snapshot.hasError){
                return Text(snapshot.error.toString()
                
                 );
              }
              final data= snapshot.data!;
              final currentWeatherData = data['list'][0];
              final currentTemp = currentWeatherData ['main']['temp'];
              final currentsky = currentWeatherData['weather'][0 ]['main'];
              final currentPressure =currentWeatherData['main']['pressure'];
              final currentWind =currentWeatherData['wind']['speed'];
              final currentHumidity =currentWeatherData['main']['humidity'];
              
               return Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp k",
                                  style: TextStyle(
                                    fontSize: 32,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Icon(
                                 currentsky=='Clouds ' || currentsky=='Rain'?Icons.cloud:Icons.sunny,
                                  size: 64,
                                ),
                                SizedBox(height: 20),
                                Text(
                                currentsky,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child:
                  Text(
                    "Weather Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                //  SingleChildScrollView(
                //    scrollDirection: Axis.horizontal,
                //    child: Row(
                //      children: [
                //        for (int i = 0; i < 5; i++)
                //         HourlyForecastItem(
                //           icon:data['list'][i+1]['weather'][0]['main']=='Clouds'|| data['list'][i+1]['weather'][0]['main'] == 'Rain'?Icons.cloud : Icons.sunny,
                //           temperature: data['list'][i+1]['main']['temp'].toString(),
                //           time: data['list'][i+1]['dt'].toString(),
                //         ),
                //        
                //      ],
                //    ),
                //  ),
                SizedBox( 
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context,index){
                      final time = DateTime.parse(data['list'][index+1]['dt_txt'].toString());
                       return HourlyForecastItem(
                       icon:data['list'][index+1]['weather'][0]['main']=='Clouds'|| data['list'][index+1]['weather'][0]['main'] == 'Rain'?Icons.cloud : Icons.sunny,
                        time: DateFormat.j().format(time)  ,
                        temperature: data['list'][index+1]['main']['temp'].toString()
                         );
                    },),
                ),
                  SizedBox(height: 20),
                  Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                    
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalinfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      AdditionalinfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWind.toString(),
                      ),
                      AdditionalinfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),
                ],
              ),
           );
             }
           
        )
         );
  }
 
} 