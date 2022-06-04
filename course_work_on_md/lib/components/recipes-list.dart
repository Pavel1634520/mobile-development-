import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/recipe.dart';

class RecipesList extends StatefulWidget {
  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {


  DatabaseService  db = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text('');

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.blue[200],
                  margin: const EdgeInsets.only(left: 10,right: 10,top: 12,bottom: 3),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(snapshot.data!.docs[index].get('isOnline')==false?Icons.favorite_border:Icons.favorite,color: Colors.red,size: 33,),
                      onPressed: () {
                        setState(() {


                          if(snapshot.data!.docs[index].get('isOnline')==false) {
                            void _saveRecipe() async {
                              Recipe recipe = Recipe(title: '',
                                  author: '',
                                  complexity: '',
                                  miniDescription: '',
                                  description: '',
                                  ingredients: '');
                              recipe.title =
                                  snapshot.data!.docs[index].get('title');
                              recipe.miniDescription =
                                  snapshot.data!.docs[index].get(
                                      'miniDescription');
                              recipe.description =
                                  snapshot.data!.docs[index].get('description');
                              recipe.ingredients =
                                  snapshot.data!.docs[index].get('ingredients');
                              recipe.complexity =
                                  snapshot.data!.docs[index].get('complexity');
                              await FirebaseFirestore.instance
                                  .collection('recipeSchedules')
                                  .doc(recipe.uid)
                                  .set(recipe.toMap());
                              //await DatabaseService().addOrUpdateRecipe(recipe);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Рецепт добавлен в избранное'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                            _saveRecipe();


                            snapshot.data!.docs[index].reference.update(<String, Object> {'isOnline': true });
                          }


                        });

                        },
                    ),
                    title: Text(snapshot.data!.docs[index].get('title')),
                    onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreRecipe(
                                title:
                                snapshot.data!.docs[index].get('title'),
                                miniDescription: snapshot.data!.docs[index]
                                    .get('miniDescription'),
                                description: snapshot.data!.docs[index]
                                    .get('description'),
                                ingredients: snapshot.data!.docs[index]
                                    .get('ingredients'),
                                complexity: snapshot.data!.docs[index]
                                    .get('complexity'))));} ,
                    subtitle: Column(
                      children: [
                        Text(snapshot.data!.docs[index].get('miniDescription')),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),
                        Text('Ингредиенты: ${snapshot.data!.docs[index].get('ingredients')}',style: TextStyle(fontStyle: FontStyle.italic),),
                        SizedBox(height: 10,),
                        Subtitle(context,
                            snapshot.data!.docs[index].get('complexity'))
                      ],
                    ),
                  ),
                );
              },
            );
          });

  }
}

class MoreRecipe extends StatelessWidget {
  final String title;
  final String miniDescription;
  final String description;
  final String ingredients;
  final String complexity;

  const MoreRecipe({
    Key? key,
    required this.title,
    required this.miniDescription,
    required this.description,
    required this.ingredients,
    required this.complexity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Способ приготовления',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                        Text('\n $description',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Ингредиенты:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        Text(" $ingredients",style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Сложность приготовления:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        Subtitle(context, complexity),
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Subtitle(BuildContext context, String complexity) {
  Color color = Colors.grey;
  double indicatorLevel = 0;

  switch (complexity) {
    case 'Низкая сложность':
      color = Colors.greenAccent;
      indicatorLevel = 0.25;
      break;
    case 'Средняя сложность':
      color = Colors.yellow;
      indicatorLevel = 0.50;
      break;
    case 'Высокая сложность':
      color = Colors.orange;
      indicatorLevel = 0.75;
      break;
    case 'Невероятно сложно':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: indicatorLevel,
              valueColor: AlwaysStoppedAnimation(color))),
      SizedBox(
        width: 10,
      ),
      Expanded(flex: 4, child: Text(complexity))
    ],
  );
}
