import 'movie-model.dart';

void main(){
	print('Hello, World!');

	const Map<String, dynamic> json = {
		"title": "Movie Name"
	};

	Movie movie = Movie.fromJson(json);

	print(movie);
	print(movie.title);
}

