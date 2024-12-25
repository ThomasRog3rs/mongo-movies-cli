import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'movie-model.dart';

Future<List<Movie>> getMovies() async {
	final response = await http.get(Uri.parse("http://localhost:5000/api/get-all-movies"));

	List<dynamic> moviesJson = json.decode(response.body);

	List<Movie> movies = [];

	for(final movie in moviesJson){
		try{
			final Movie theMovie = Movie.fromJson(movie);
			movies.add(theMovie);
		}catch(error){
			print("Error, movie was not added to list: $error");
			continue;
		}
	}

	return movies;
}

Future<List<Movie>> searchMovies(String searchValue) async {
    Map<String, String> headers = {
        "search-value": searchValue
    };

    final response = await http.get(
        Uri.parse("http://localhost:5000/api/search"),
        headers: headers
    );

    List<dynamic> searchResultJson = json.decode(response.body);

    List<Movie> foundMovies = [];

    for(final movie in searchResultJson){
        try{
            final Movie theMovie = Movie.fromJson(movie);
            foundMovies.add(theMovie);
        }catch(error){
			print("Error, movie was not added to list: $error");
			continue;
		}
    }

    return foundMovies;
}


Future<Movie?> getMovieById(String id) async {
	Map<String, String> headers = {
		"id": id
	};

	final response = await http.get(
		Uri.parse("http://localhost:5000/api/get-by-id"),
		headers: headers
	);

	Map<String, dynamic> movieJson = json.decode(response.body);

	if(movieJson["error"] != null){
		print(movieJson["error"]);
		return null;
	}

	final Movie theMovie = Movie.fromJson(movieJson);

	return theMovie;
}

Future<Movie?> addMovie(Map<String, String> movieToAdd) async {
    // Map<String, dynamic> movieToAddJson = json.encode(movieToAdd);

    print(movieToAdd);

    http.Response response;

    try{
        response = await http.post(
            Uri.parse("http://localhost:5000/api/add-movie"),
            body: movieToAdd
        );
    }catch (e,s){
        print("Fail: $e");
        print("$s");
        return null;
    }


    Map<String, dynamic> newMovieJson = json.decode(response.body);


	if(newMovieJson["error"] != null){
		print(newMovieJson["error"]);
		return null;
	}

    if(newMovieJson["_message"] != null){
		print(newMovieJson["message"]);
		return null;
	}

    final Movie theNewMovie = Movie.fromJson(newMovieJson);

    return theNewMovie;
}