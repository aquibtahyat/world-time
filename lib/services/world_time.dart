import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location ui
  late String time; //time of the location
  String flag; // url to asset flag icon
  String url; //location url for api endpoint
  bool isDaytime = false; // if day time or not

  WorldTime({ required this.location,required this.flag,required this.url });

  Future<void> getTime() async {

    try{
      //make the request
      Response response = await get (Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //set the time property
      isDaytime =  now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time ='Could not get time data';

    }






  }

}



