class Movie {
    final String title;
    // final int releaseYear;
    // final String rated;
    // final String actors;
    // final String? plot;
    // final String director;
    // final int stars;
    // final String? posterUrl;

    Movie._(
        this.title,
        // this.releaseYear,
        // this.rated,
        // this.actors,
        // this.plot,
        // this.director,
        // this.starts,
        // this.posterUrl
    );

    factory Movie.fromJson(Map<String, dynamic> json){
        return Movie._(
            json["title"]
        );
    }
}