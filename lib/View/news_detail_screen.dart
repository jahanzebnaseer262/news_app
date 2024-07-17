import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
class NewsDetailScreen extends StatefulWidget {
  String newsImage,newsTitle,newsDate,author,description,content,source;
   NewsDetailScreen({required this.newsImage,
     required this.newsTitle,
     required this.newsDate,
     required this.author,
     required this.content,
     required this.source,
     required this.description,});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height*.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40)
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                placeholder: (context,url)=>Center(child: CircularProgressIndicator(),),
              ),
            ),
          ),
          Container(
            height: height*.6,
            margin: EdgeInsets.only(top: height*.4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40)
              ),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.newsTitle,style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),),
                ),
                SizedBox(height: height*.02,),
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.source,style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      ),),
                    ),
                    Text(widget.newsDate,style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                    ),)
                  ],
                ),
                SizedBox(height: height*.3,),
                Text(widget.description,style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
