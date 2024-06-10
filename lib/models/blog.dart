class Blog {
  String id, userId, title, desc;
  DateTime createdAt;

  Blog(
      {required this.id,
      required this.userId,
      required this.title,
      required this.desc,
      required this.createdAt});

  //convert data in to object
  factory Blog.fromMap(map) {
    return Blog(
        id: map['id'],
        userId: map['userId'],
        title: map['title'],
        desc: map['desc'],
        createdAt: DateTime.parse(map['createdAt']));
  }

  //conert blog to map. Map is return time
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'desc': desc,
      'createdAt': createdAt.toString()
    };
  }
}
