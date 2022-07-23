
class InfiniteListModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const InfiniteListModel({this.userId, this.title, this.body, this.id});

  factory InfiniteListModel.fromJson(Map<String, dynamic> json) {
    return InfiniteListModel(
      title: json['title'],
      body: json['body'],
      id: json['id'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'body': body,
        'userId': userId,
      };
}
