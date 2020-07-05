class Speaker {
  String id;
  String name;
  String activity;
  String description;
  String imageURL;
  String facebookURL;
  String githubURL;
  String linkedinURL;

  Speaker({
    this.name,
    this.id,
    this.activity,
    this.description,
    this.facebookURL,
    this.githubURL,
    this.imageURL,
    this.linkedinURL,
  });

  Speaker.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    activity = data['activity'];
    description = data['description'];
    imageURL = data['imageURL'];
    facebookURL = data['facebookURL'];
    githubURL = data['githubURL'];
    linkedinURL = data['linkedinURL'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'activity': activity,
      'description': description,
      'imageURL': imageURL,
      'facebookURL': facebookURL,
      'githubURL': githubURL,
      'linkedinURL': linkedinURL,
    };
  }
}
