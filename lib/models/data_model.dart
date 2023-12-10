class DataModel {
  final String title;
  final String image;
  DataModel(
    this.title,
    this.image,
  );
}

List<DataModel> dataList = [
  DataModel(
    "SUMMER",
    "assets/summer.webp",
  ),
  DataModel(
    "FORMAL",
    "assets/formal.webp",
  ),
  DataModel(
    "WINTER",
    "assets/winter.webp",
  ),
];
