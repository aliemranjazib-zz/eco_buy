class Category {
  String? title;
  String? image;

  Category({required this.title, this.image});
}

List<Category> categories = [
  Category(title: "GROCERY", image: 'assets/c_images/grocery.png'),
  Category(title: "ELECTRONICES", image: 'assets/c_images/electronics.png'),
  Category(title: "COSMETICS", image: 'assets/c_images/cosmatics.png'),
  Category(title: "PHARMACY", image: 'assets/c_images/pharmacy.png'),
  Category(title: "GARMENTS", image: 'assets/c_images/garments.png'),
];
