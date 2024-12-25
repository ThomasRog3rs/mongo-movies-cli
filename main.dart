import 'dart:io';
import 'movie-model.dart';
import "movie-interaction.dart";
import "movie-api-service.dart";

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
	final String? userOption = stdin.readLineSync();

	switch(userOption){
		case "1":
			printAllMovies(movies);
		case "2":
			printMovieById();
		case "3":
			printMovieSearch();
		default:
			print("invalid option");
	}
}