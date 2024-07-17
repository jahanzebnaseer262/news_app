import 'package:news_app/Models/NewsChannelModels.dart';
import 'package:news_app/Models/categories_news_models.dart';
import 'package:news_app/repositry/news_repositry.dart';

class NewsViewModel{
  final _repo=NewsRepositry();
  Future<NewsChannelModels> fetchnewsApi(String channelName) async{
    final response= await _repo.fetchnewsApi(channelName);
    return response;
  }
  Future<CategoriesNewsModels> fetchcategoriesnewsApi(String category) async{
    final response= await _repo.fetchcategoriesnewsApi(category);
    return response;
  }
}