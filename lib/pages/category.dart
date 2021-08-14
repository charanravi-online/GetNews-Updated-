import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getnews/models/model.dart';
import 'package:getnews/pages/homepage.dart';
import 'package:getnews/pages/newsview.dart';
import 'package:http/http.dart';
import 'package:share/share.dart';

class Category extends StatefulWidget {
  // const Category({ Key? key }) : super(key: key);

  String query;
  Category({required this.query});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  List<NewsQuery> newsModelList = <NewsQuery>[];

  bool isLoading = true;
  getNewsByQuery(String query) async {
    Map element;
    int i = 0;
    String url;
    if (query == "Trending News" || query == "India") {
      url =
          "https://newsapi.org/v2/top-headlines?country=in&language=en&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    } else if (query == "technology" ||
        query == "entertainment" ||
        query == "sports" ||
        query == "business" ||
        query == "science" ||
        query == "health") {
      url =
          "https://newsapi.org/v2/top-headlines?country=in&category=$query&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    } else if (query == "the-times-of-india" ||
        query == "bbc-news" ||
        query == "national-geographic" ||
        query == 'google-news' ||
        query == 'bloomberg' ||
        query == 'cnn' ||
        query == "news24" ||
        query == "techradar" ||
        query == "mashable" ||
        query == "buzzfeed" ||
        query == "bbc-sport" ||
        query == "bleacher-report" ||
        query == "crypto-coins-news" ||
        query == "hacker-news" ||
        query == "espn") {
      url =
          "https://newsapi.org/v2/top-headlines?sources=$query&apiKey=2944d5dc48ef4b14ac81054d6c748062";
      // "https://newsapi.org/v2/everything?q=$query&language=en&sortBy=popularity&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    } else
    // if  (query == "Latest")
    {
      url =
          "https://newsapi.org/v2/everything?q=$query&language=en&sortBy=publishedAt&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    }
    // else {
    //   url =
    //       "https://newsapi.org/v2/everything?q=$query&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    // }

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      // data['articles'].forEach((element) {
      for (element in data["articles"]) {
        try {
          i++;
          NewsQuery recipeModel = new NewsQuery();
          recipeModel = NewsQuery.fromMap(element);
          newsModelList.add(recipeModel);
          setState(() {
            isLoading = false;
          });
          if (i == 11) {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text('GetNews'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xff574b90),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white70,
        color: Color(0xff303a52),
        onRefresh: getRefresh,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    15,
                    25,
                    0,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          widget.query,
                          style: TextStyle(
                            color: Color(0xff303a52),
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height - 450,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (context, index) {
                          try {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: InkWell(
                                onLongPress: () =>
                                    share(newsModelList[index].newsUrl),
                                onTap: () {
                                  Navigator.push(
                                      //newsview for categories section
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsView(
                                              newsModelList[index].newsUrl)));
                                },
                                child: Card(
                                  color: Color(0xff303a52), //card in category
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 4.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          newsModelList[index].newsImg,
                                          fit: BoxFit.fitHeight,
                                          width: double.infinity,
                                          height: 230,
                                        ),
                                        //     Image.network(
                                        //   //error handling in process
                                        //   newsModelList[index].newsImg == null
                                        //       ? AssetImage(
                                        //           'images/breakingnews.jpg')
                                        //       : newsModelList[index].newsImg,
                                        //   fit: BoxFit.fitHeight,
                                        //   width: double.infinity,
                                        //   height: 230,
                                        // ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.black.withOpacity(0),
                                                ],
                                                // begin: Alignment.topCenter,
                                                // end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 10, 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  newsModelList[index]
                                                              .newsDes
                                                              .length >
                                                          50
                                                      ? "${newsModelList[index].newsDes.substring(0, 54)}..."
                                                      : newsModelList[index]
                                                          .newsDes,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            return Container();
                          }
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void share(String newsUrl) {
  // final RenderBox box = context.findRenderObject();
  final String longpress = "{$newsUrl}";
  Share.share(longpress);
}
