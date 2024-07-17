import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/NewsChannelModels.dart';
import 'package:news_app/View/news_detail_screen.dart';
import 'package:news_app/View_Model/News_View_Model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/categories_news_models.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{bbcNews,aryNews,independent,alJazeera,routers,cnn}
class _HomeScreenState extends State<HomeScreen> {
  final format=DateFormat('MMM,dd,yy');
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  String name='bbc-News';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        actions: [
PopupMenuButton<FilterList>(
  onSelected: (FilterList item){
    if(FilterList.bbcNews.name==item.name){
      name='bbc-news';
    }
    if(FilterList.aryNews.name==item.name){
      name='ary-news';
    }
    setState(() {
      selectedMenu=item;
    });
  },
  icon: Icon(Icons.more_vert,color:Colors.black),
  initialValue: selectedMenu,
    itemBuilder: (context)=><PopupMenuEntry<FilterList>>[
      PopupMenuItem<FilterList>(
        value: FilterList.bbcNews,
          child:Text('BBC News') ),
      PopupMenuItem<FilterList>(
          value: FilterList.aryNews,
          child:Text('Ary News') )
    ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelModels>(
                future: newsViewModel.fetchnewsApi(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime datetime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                         return  InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                                 newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                 newsTitle: snapshot.data!.articles![index].title.toString(),
                                 newsDate: format.format(datetime),
                                 author: snapshot.data!.articles![index].author.toString(),
                                 content: snapshot.data!.articles![index].content.toString(),
                                 source: snapshot.data!.articles![index].source!.name.toString(),
                                 description: snapshot.data!.articles![index].description.toString())));
                           },
                           child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 1,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * .02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage.toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Container(child: spinkit2),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 22,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: height*.22,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * .7,
                                              child: Text(
                                                snapshot
                                                    .data!.articles![index].title.toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.articles![index].source!.name.toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(width: MediaQuery.sizeOf(context).width*.5,),
                                                Text(
                                                  format.format(datetime),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                         );
                        });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<CategoriesNewsModels>(
                future: newsViewModel.fetchcategoriesnewsApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime datetime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.fill,
                                    height: height*.20,
                                    width: width*.1,
                                    placeholder: (context, url) =>
                                        Container(child: Center(
                                          child: SpinKitCircle(
                                            color: Colors.blue,
                                          ),
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      height: height*.18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(  snapshot.data!.articles![index].title.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700
                                            ),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(  snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              Text(  format.format(datetime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
