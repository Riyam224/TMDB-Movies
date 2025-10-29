class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
  });

  /// 🧠 Computed getter: convert genre IDs → readable names
  List<String> get genreNames {
    final map = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Sci-Fi',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };

    return genreIds.map((id) => map[id] ?? 'Unknown').toList();
  }
}
