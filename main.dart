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

	print("Welcome to Mongo Movies Console App!");
	print("You currently have ${movies.length} movies stored.");

	bool appRunning = true;
	while(appRunning){
		printMenu();

		print("Enter your option: ");
		final String? userOption = stdin.readLineSync();

		clearConsole();

		switch(userOption){
			case "1":
				displayAllMovies(movies);
				break;
			case "2":
				await displayMovieDetailsById();
				break;
			case "3":
				await searchAndDisplayMovies();
				break;
			case "4":
				await createAndDisplayNewMovie();
				break;
			case "5":
				await deleteMovieAndShowDetails();
				break;
			case "6":
				appRunning = false;
				break;
			default:
				print("invalid option");
		}
	}
}