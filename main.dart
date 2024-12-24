import 'movie-model.dart';

void main(){
	print('Hello, World!');

	List<Map<String, dynamic>> moviesData = [
		{
			'title': 'Inception',
			'releaseYear': 2010,
			'rated': 'PG-13',
			'actors': 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
			'plot': 'A thief who enters the minds of others through their dreams is given the task of planting an idea into the mind of a CEO.',
			'director': 'Christopher Nolan',
			'stars': 9,
			'posterUrl': 'https://example.com/inception-poster.jpg',
		},
		{
			'title': 'Inception 2',
			'releaseYear': 2015,
			'rated': 'PG-13',
			'actors': 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
			'plot': 'A thief who enters the minds of others through their dreams is given the task of planting an idea into the mind of a CEO.',
			'director': 'Christopher Nolan',
			'stars': 9,
			'posterUrl': 'https://example.com/inception-poster.jpg',
		}
	];

	List<Movie> movies = [];

	for(final movie in moviesData){
		try{
			final Movie theMovie = Movie.fromJson(movie);
			movies.add(theMovie);
		}catch(error){
			print("Error, movie was not added to list: $error");
			continue;
		}
	}

	print(movies[0]);
	print(movies[0].title);

	print("total movies: ${movies.length}");
}