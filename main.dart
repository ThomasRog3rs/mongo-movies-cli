import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'movie-model.dart';


void main() async {
	List<Movie> movies = [];

	try{
		movies = await getMovies();
	}on SocketException{
		print("Failed to connect to API, can't fetch movies");
	}on Exception catch(error, stackTrace) {
		print("Failed to fetch movies: $error");
		print("StackTrace: $stackTrace");
	}

	assert(movies.length > 0, "No Movies, could have failed to fetch");

	if(movies.length <= 0){
		print("No movies found, would you like to add some movies?");
		return;
	}

	print("You currently have ${movies.length} movies stored");

	print('''
What would you like to do?\n
[1] View all current movies
[2] View one movie (by id)
[3] Search Movies (by Name)
[4] Add a new movie
[5] Delete a movie
	''');

	print("Enter your option: ");
	String? userOption = stdin.readLineSync();

	switch(userOption){
		case "1":
			printAllMovies(movies);
		default:
			print("invalid option");
	}
}

Future<List<Movie>> getMovies() async {
	final response = await http.get(Uri.parse("http://localhost:5000/api/get-all-movies"));

	List<dynamic> movieJson = json.decode(response.body);

	List<Movie> movies = [];

	for(final movie in movieJson){
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

void printAllMovies(List<Movie> movies){
	print("\nHere are all the movies:\n");
	movies.forEach((movie){
		print(movie.toString());
	});
}