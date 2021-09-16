class CustomerReview{
    final String review;
  final String name;
  final String date;
  CustomerReview({
    required this.date,
    required this.name,
    required this.review
  });
  factory CustomerReview.fromJson(Map<String, dynamic> json)=>CustomerReview(
    name: json['name'],
    review: json['review'],
    date: json['date'],
  );
    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date":date
    };
}