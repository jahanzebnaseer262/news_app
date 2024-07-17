import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsChannelModels.dart';
import 'package:news_app/Models/categories_news_models.dart';

class NewsRepositry{
  Future<NewsChannelModels> fetchnewsApi(String channelName) async{
    String url='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=745ddd3840cd47148195ae7dc1480e85';
    final response= await http.get(Uri.parse(url));
if(response.statusCode==200){
final body= jsonDecode(response.body);
return NewsChannelModels.fromJson(body);
}else{
  throw(Exception('Error'));
}
  }
  Future<CategoriesNewsModels> fetchcategoriesnewsApi(String category) async{
    String url='https://newsapi.org/v2/everything?q=${category}&apiKey=745ddd3840cd47148195ae7dc1480e85';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final body= jsonDecode(response.body);
      return CategoriesNewsModels.fromJson(body);
    }else{
      throw(Exception('Error'));
    }
  }
}