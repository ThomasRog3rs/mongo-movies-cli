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