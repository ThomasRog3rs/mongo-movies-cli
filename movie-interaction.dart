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

Future<void> displayMovieDetailsById() async{
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
	print("Please provide details for the movie you want to create: \n");

	// Movie Name
	print("Movie Name:");
	final String? movieName = stdin.readLineSync();
	if (movieName == null || movieName.trim().isEmpty) {
		print("Invalid input. Movie name cannot be empty.");
		navigateToMenu();
		return;
	}

	// Release Year
	print("Release Year:");
	final String? releaseYearInput = stdin.readLineSync();
	final int? releaseYear = int.tryParse(releaseYearInput ?? "");
	if (releaseYear == null || releaseYear <= 1800 || releaseYear > DateTime.now().year) {
		print("Invalid input. Please provide a valid year between 1800 and the current year.");
		navigateToMenu();
		return;
	}

	// Rated
	print("Rated (e.g., PG, PG-13, R):");
	final String? rated = stdin.readLineSync();
	if (rated == null || rated.trim().isEmpty) {
		print("Invalid input. Rating cannot be empty.");
		navigateToMenu();
		return;
	}

	// Actors
	print("Actors (comma-separated):");
	final String? actors = stdin.readLineSync();
	if (actors == null || actors.trim().isEmpty) {
		print("Invalid input. Actors cannot be empty.");
		navigateToMenu();
		return;
	}

	// Plot (optional)
	print("Plot (optional):");
	final String? plot = stdin.readLineSync();

	// Director
	print("Director:");
	final String? director = stdin.readLineSync();
	if (director == null || director.trim().isEmpty) {
		print("Invalid input. Director name cannot be empty.");
		navigateToMenu();
		return;
	}

	// Stars
	print("Stars (rating out of 5):");
	final String? starsInput = stdin.readLineSync();
	final int? stars = int.tryParse(starsInput ?? "0");
	if (stars == null || stars < 1 || stars > 5) {
		print("Invalid input. Stars must be a number between 0 and 5.");
		navigateToMenu();
		return;
	}

	// Poster URL (optional)
	print("Poster URL (optional):");
	final String? posterUrl = stdin.readLineSync();

	// Create a map for the movie details
	Map<String, String> theMovieToAdd = {
		"title": movieName.trim(),
		"releaseYear": releaseYearInput ?? "",
		"rated": rated.trim(),
		"actors": actors.trim(),
		"plot": plot?.trim() ?? "",
		"director": director.trim(),
		"stars": starsInput ?? "",
		"posterUrl": posterUrl?.trim() ?? ""
	};

	print("\nCreating the movie with the following details:");
	print(theMovieToAdd);

	// Add the movie using the API service
	Movie? addedMovie = await addMovie(theMovieToAdd);

	// Handle the response
	if (addedMovie == null) {
		print("\nFailed to add new movie.");
		navigateToMenu();
		return;
	}

	print("\nMovie successfully added! Here are the details:");
	print(addedMovie.toDetailedString());

	navigateToMenu();
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