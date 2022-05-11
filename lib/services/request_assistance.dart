import 'dart:convert';
import 'package:http/http.dart'as http;
class RequestAssistance{
  static Future<dynamic> getRequest(String url)async{

  http.Response response=await http.get(Uri.parse(url));
    try{
      if(response.statusCode==200){
        String jsonData = response.body;
        var decodeJson = jsonDecode(jsonData);
        return decodeJson;
      }
      else{
        return "Failed";
      }
    }catch(e){
      return "Failed";
    }
  }
}

