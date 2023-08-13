class Event {
  Content content;
  bool status;

  Event({required this.content, required this.status});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      content: Content.fromJson(json['content']),
      status: json['status'],
    );
  }
}

class Content {
  List<Datum> data;
  Meta meta;

  Content({
    required this.data,
    required this.meta,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      data: (json['data'] as List).map((data) => Datum.fromJson(data)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Datum {
  int id;
  String title;
  String description;
  String bannerImage;
  DateTime dateTime;
  String organiserName;
  String organiserIcon;
  String venueName;
  String venueCity;
  String venueCountry;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: DateTime.parse(json['date_time']),
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }
}

class Meta {
  int total;

  Meta({
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
    );
  }
}
