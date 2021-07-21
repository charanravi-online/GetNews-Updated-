class NewsQuery {
  String newsHead;
  String newsDes;
  String newsImg;
  String newsUrl;
  NewsQuery(
      {this.newsHead = 'News Headline',
      this.newsDes = 'News Description',
      this.newsImg = 'News Image',
      this.newsUrl = 'News Url'});

  factory NewsQuery.fromMap(Map news) {
    return NewsQuery(
      newsHead: news['title'],
      newsDes: news['description'],
      newsImg: news['urlToImage'],
      newsUrl: news['url'],
    );
  }
}
