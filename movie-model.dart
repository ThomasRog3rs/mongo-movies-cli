class Movie {
    final String title;
    final int releaseYear;
    final String rated;
    final String actors;
    final String? plot;
    final String director;
    final int stars;
    final String? posterUrl;

    Movie._(
        this.title,
        this.releaseYear,
        this.rated,
        this.actors,
        this.plot,
        this.director,
        this.stars,
        this.posterUrl
    );

    factory Movie.fromJson(Map<String, dynamic> json){
        json.forEach((key, value) {
            if(value == null) throw "${key} is null in the data.";
        });
        
        return Movie._(
            json["title"],
            json["releaseYear"],
            json["rated"],
            json["actors"],
            json["plot"],
            json["director"],
            json["stars"],
            json["posterUrl"],
        );
    }
}