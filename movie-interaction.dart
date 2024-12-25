import 'dart:io';
import 'movie-model.dart';
import 'movie-api-service.dart';

void displayAllMovies(List<Movie> movies){
	if(movies.length == 0){
		print("No movies foud.");
		returnToMenu();
		return;
	}

	print("\nHere are all the movies:\n");
	movies.forEach((movie){
		print(movie.toString());
	});

	returnToMenu();
}

Future<void>  displayMovieDetailsById() async{
	print("Please provide a movie id: ");
	final String? movieId = stdin.readLineSync();

	if(movieId == null || movieId.isEmpty){
		print("No id provided, no movie found.");	
		returnToMenu();
		return;
	}

	if(int.tryParse(movieId) == null){
		print("Ids must be numbers.");
		returnToMenu();
		return;
	}

	final Movie? theMovie = await getMovieById(movieId);
	
	if(theMovie == null){
		returnToMenu();
		return;
	}

	print("\nThe Found movie: ");
	print(theMovie.toDetailedString());

	returnToMenu();
}

Future<void> searchAndDisplayMovies() async{
	print("Please provide your search term: ");
	final String? searchValue = stdin.readLineSync();

	if(searchValue == null || searchValue.isEmpty){
		print("No search term provided");
		returnToMenu();
		return;
	}

	final List<Movie> foundMovies = await searchMovies(searchValue);

	if(foundMovies.length == 0){
		print("No movies for search '${searchValue}' was found.");
		returnToMenu();
		return;
	}

	print("\nHere are the found movies for search '${searchValue}':\n");
	foundMovies.forEach((movie){
		print(movie.toDetailedString());
	});

	returnToMenu();
}

Future<void> createAndDisplayNewMovie() async {
	print("To be implimented")
}

void printMenu(){
	print('''
What would you like to do?\n
[1] View all current movies
[2] View one movie (by id)
[3] Search Movies (by Name)
[4] Add a new movie
[5] Delete a movie
[6] Exit app
	''');
}

void navigateToMenu(){
	print("Press any ENTER to go back to menu");
	stdin.readLineSync();
	clearConsole();
}

void clearConsole() {
  if (Platform.isWindows) {
    // Windows command to clear the console
    print(Process.runSync('cls', [], runInShell: true).stdout);
  } else {
    // Unix/Linux/macOS command to clear the console
    print(Process.runSync('clear', [], runInShell: true).stdout);
  }
}