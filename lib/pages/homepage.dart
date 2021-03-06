// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:getnews/models/model.dart';
import 'package:getnews/pages/category.dart';
import 'package:getnews/pages/newsview.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = new TextEditingController();
  List<NewsQuery> newsModelList = <NewsQuery>[];
  List<NewsQuery> newsModelListCarousel = <NewsQuery>[];
  List<String> navBarItem = [
    'Trending News',
    'India',
    'World',
    'Covid-19',
    'Technology',
    'Entertainment',
    'Current Affairs',
    'Sports',
    'Lifestyle',
    'Bussiness',
    'Health',
  ];

  bool isLoading = true;
  getNewsByQuery(String query) async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/everything?q=$query&language=en&sortBy=publishedAt&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          i++;
          NewsQuery recipeModel = new NewsQuery();
          recipeModel = NewsQuery.fromMap(element);
          newsModelList.add(recipeModel);
          setState(() {
            isLoading = false;
          });
          if (i == 6) {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  getNewsOfIndia(String query) async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&language=en&apiKey=2944d5dc48ef4b14ac81054d6c748062";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          i++;
          NewsQuery recipeModel = new NewsQuery();
          recipeModel = NewsQuery.fromMap(element);
          newsModelListCarousel.add(recipeModel);
          setState(() {
            isLoading = false;
          });
          if (i == 4) {
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
    getNewsByQuery('India');
    getNewsOfIndia("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff574b90),
        title: Text('GetNews'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //Search Bar Container

              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        print("Blank Search");
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Category(query: searchController.text)));
                      }
                    },
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Color(0xff303a52),
                      ),
                      margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      cursorColor: Color(0xff303a52),
                      onSubmitted: (value) {
                        if (value == "") {
                          print('Blank Search');
                          // return Container(
                          //   child: Text('Blank Search',),
                          // );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Category(query: value)));
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search "),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: navBarItem.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // print(navBarItem[index]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Category(
                                    query: navBarItem[index],
                                  )));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff303a52),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          navBarItem[index],
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: isLoading
                  ? Container(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()))
                  : CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: newsModelListCarousel.map((instance) {
                        return Builder(builder: (BuildContext context) {
                          try {
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context, //webview for carousal news
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsView(instance.newsUrl)));
                                },
                                child: Card(
                                  color: Color(0xff303a52),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            instance.newsImg,
                                            fit: BoxFit.fitHeight,
                                            width: double.infinity,
                                            height: 230,
                                          ),

                                        //   instance.newsImg == null
                                        //       ? AssetImage(
                                        //           'images/breakingnews.jpg')
                                        //       : instance.newsImg,
                                        //   fit: BoxFit.fill,
                                        //   width: double.infinity,
                                        //   height: double.maxFinite,
                                        // ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black12.withOpacity(0),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                instance.newsHead,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            return Container();
                          } //error handling for carousel effect
                        });
                      }).toList(),
                      // options : options
                    ),
            ),
            Container(
              color: Color(0xff303a52),
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
                        Text(
                          'Latest News',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 28,
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewsView(
                                                newsModelList[index].newsUrl)));
                                  },
                                  child: Card(
                                    color: Color(0xff9e579d),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 4.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            newsModelList[index].newsImg,
                                            fit: BoxFit.fitHeight,
                                            width: double.infinity,
                                            height: 230,
                                          ),
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
                                                    newsModelList[index]
                                                        .newsHead,
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
                                                        ? "${newsModelList[index].newsDes.substring(0, 55)}..."
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
                            } //error handling for top news section
                          }),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Category(
                                            query: "Latest",
                                          )));
                            },
                            child: Text('show more')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List items = ['slide 1', 'slide 2', 'slide 3', 'slide 4'];
}
