class Movie {
    final String title;
    final int releaseYear;
    final String rated;
    final String actors;
    final String? plot;
    final String director;
    final int stars;
    final String? posterUrl;
    final int? id;

    Movie(
        this.title,
        this.releaseYear,
        this.rated,
        this.actors,
        this.plot,
        this.director,
        this.stars,
        this.posterUrl,
        this.id
    );

    factory Movie.fromJson(Map<String, dynamic> json){
        json.forEach((key, value) {
            if(value == null) throw "${key} is null in the data.";
        });

        return Movie(
            json["title"],
            json["releaseYear"],
            json["rated"],
            json["actors"],
            json["plot"],
            json["director"],
            json["stars"],
            json["posterUrl"],
            json["id"]
        );
    }

    @override
    String toString(){
        return "Movie Name: ${title}\nMovie ID: ${id}\n";
    }

    String toDetailedString(){
        return '''
    Movie Name: $title
    Movie ID: $id
    Release Year: $releaseYear
    Rated: $rated
    Actors: $actors
    Plot: ${plot ?? "N/A"}
    Director: $director
    Stars: $stars
    Poster URL: ${posterUrl ?? "N/A"}
        ''';
    }
}