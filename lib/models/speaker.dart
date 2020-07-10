class Speaker {
  String id;
  String name;
  List<String> activities;
  String shortBio;
  String bio;
  String imageURL;
  Map<String, String> social;

  Speaker({
    this.name,
    this.id,
    this.activities,
    this.shortBio,
    this.bio,
    this.social,
    this.imageURL,
  });
}
