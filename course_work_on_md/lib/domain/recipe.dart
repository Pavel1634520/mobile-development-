class Recipe{
  String? uid;
  late String author;
  late String title;
  late String miniDescription;
  late String description;
  late String ingredients;
  late String complexity;
  bool? isOnline;

  Map <String,dynamic> toMap(){
    return{
    'title':title,
    'miniDescription':miniDescription,
    'description':description,
    'ingredients':ingredients,
    'complexity':complexity,
      'isOnline':false
    };
  }

  Map <String,dynamic> toPrevMap(){
    return{
      'title':title,
      'miniDescription':miniDescription,
      'complexity':complexity,
      'isOnline':true
    };
  }
  Recipe.fromJson(String this.uid, Map <String,dynamic> data){
    title = data['title'];
    miniDescription = data['miniDescription'];
    complexity = data['complexity'];
  }

  Recipe({required this.title,required this.author,required this.complexity,required this.miniDescription,required this.description,required this.ingredients,  String? uid});
}

