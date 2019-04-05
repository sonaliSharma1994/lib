class Movie {
  String poster;
  String title;
  String overview;
  String releaseDate;
  Movie({this.poster, this.title, this.overview, this.releaseDate});
  getTitle(){
    return this.title;
  }
  getPoster(){
    return this.poster;
  }
  getOverview(){
    return this.overview;
  }
  getReleaseDate(){
    return this.releaseDate;
  }
}