import 'dart:io';
import 'movie-model.dart';
import 'movie-api-service.dart';

void displayAllMovies(List<Movie> movies){
	if(movies.length == 0){
		print("No movies foud.");
		navigateToMenu();
		return;
	}

	print("\nHere are all the movies:\n");
	movies.forEach((movie){
		print(movie.toString());
	});

	navigateToMenu();
}

Future<void>  displayMovieDetailsById() async{
	print("Please provide a movie id: ");
	final String? movieId = stdin.readLineSync();

	if(movieId == null || movieId.isEmpty){
		print("No id provided, no movie found.");	
		navigateToMenu();
		return;
	}

	if(int.tryParse(movieId) == null){
		print("Ids must be numbers.");
		navigateToMenu();
		return;
	}

	final Movie? theMovie = await getMovieById(movieId);
	
	if(theMovie == null){
		navigateToMenu();
		return;
	}

	print("\nThe Found movie: ");
	print(theMovie.toDetailedString());

	navigateToMenu();
}

Future<void> searchAndDisplayMovies() async{
	print("Please provide your search term: ");
	final String? searchValue = stdin.readLineSync();

	if(searchValue == null || searchValue.isEmpty){
		print("No search term provided");
		navigateToMenu();
		return;
	}

	final List<Movie> foundMovies = await searchMovies(searchValue);

	if(foundMovies.length == 0){
		print("No movies for search '${searchValue}' was found.");
		navigateToMenu();
		return;
	}

	print("\nHere are the found movies for search '${searchValue}':\n");
	foundMovies.forEach((movie){
		print(movie.toDetailedString());
	});

	navigateToMenu();
}

Future<void> createAndDisplayNewMovie() async {
	print("Please provide details to the movie that you want to create: \n");

	print("Movie Name :");
	final String? movieName = stdin.readLineSync();

	Map<String, dynamic> theMovieToAdd = {
		"title": movieName
	};

	print(theMovieToAdd);

	Movie? addedMovie = await addMovie(theMovieToAdd);

	if(addedMovie == null){
		print("\nFailed to add new movie.");
		navigateToMenu();
		return;
	}

	print(addedMovie.toString());
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