import 'dart:io';
import 'movie-model.dart';
import 'movie-api-service.dart';

void printAllMovies(List<Movie> movies){
	if(movies.length == 0){
		print("No movies foud.");
		return;
	}
	
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

void printMovieSearch() async{
	print("Please provide your search term: ");
	final String? searchValue = stdin.readLineSync();

	if(searchValue == null || searchValue.isEmpty){
		print("No search term provided");
		return;
	}

	final List<Movie> foundMovies = await searchMovies(searchValue);

	if(foundMovies.length == 0){
		print("No movies for search '${searchValue}' was found.");
		return;
	}

	print("\nHere are the found movies for search '${searchValue}':\n");
	foundMovies.forEach((movie){
		print(movie.toDetailedString());
	});
}