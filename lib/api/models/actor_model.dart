import 'dart:convert';

//class for nested attributes
class Actor{
  String children;
  String country;
  String description;
  String dob;
  String gender;
  String height;
  String image;
  String name;
  String spouse;
  String wiki;

  Actor({
    required this.children,
    required this.country,
    required this.description,
    required this.dob,
    required this.gender,
    required this.height,
    required this.image,
    required this.name,
    required this.spouse,
    required this.wiki,
});
  factory Actor.fromJson(Map<String,dynamic> json)=> Actor(
     children:json["children"],
     country:json["country"],
     description:json["description"],
     dob:json["dob"],
     gender:json["gender"],
     height:json["height"],
     image:json["image"],
     name:json["name"],
     spouse:json["spouse"],
     wiki:json["wiki"],
);
  Map<String, dynamic> toJson() => {
    'children':children,
    'country':country,
    'description':description,
    'dob':dob,
    'gender':gender,
    'height':height,
    'image':image,
    'name':name,
    'spouse':spouse,
    'wiki':wiki,
  };
}
