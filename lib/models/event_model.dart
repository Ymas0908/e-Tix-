class EventModel {
  String? title;
  String? lieu;
  String? prix;
  String? date;
  String? description;
  String? image;

  EventModel(
      {this.title,
        this.lieu,
        this.prix,
        this.date,
        this.description,
        this.image});

  EventModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    lieu = json['lieu'];
    prix = json['prix'];
    date = json['date'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['lieu'] = this.lieu;
    data['prix'] = this.prix;
    data['date'] = this.date;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}