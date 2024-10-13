class Note {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final double price;
  bool isFav;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    this.isFav = false,
  });
}