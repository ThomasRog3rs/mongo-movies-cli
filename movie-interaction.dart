import 'dart:io';
import 'movie-model.dart';
import 'movie-api-service.dart';

void printAllMovies(List<Movie> movies){
	print("\nHere are all the movies:\n");
	movies.forEach((movie){
		print(movie.toString());
	});
}

void printMovieById() async{
	print("Please provide a movie id: ");
	final String? movieId = stdin.readLineSync();

	if(movieId == null || movieId.isEmpty){
		print("No id provided, no movie found.");	
		return;
	}

	if(int.tryParse(movieId) == null){
		print("Ids must be numbers.");
		return;
	}

	final Movie? theMovie = await getMovieById(movieId);
	
	if(theMovie == null){
		return;	
	}

	print("\nThe Found movie: ");
	print(theMovie.toDetailedString());
}

void printMovieSearch(){
	print("searching...");
}