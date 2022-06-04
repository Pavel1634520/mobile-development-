import 'package:course_work_on_md/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../components/blurryDialog.dart';
import '../components/favorite-recipes.dart';
import '../components/recipes-list.dart';
import '../domain/recipe.dart';
import 'add-recipe.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navigationBar = CurvedNavigationBar(
      items: [
        Icon(
          Icons.receipt_long,
          color: Theme.of(context).primaryColor,
        ),
        Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ],
      index: sectionIndex,
      height: 50,
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 400),
      onTap: (int index) {
        setState(() {
          sectionIndex = index;
        });
      },
    );
    return Container(
      child: Scaffold(

          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text(
              "COOLREC ${sectionIndex == 0 ? "(поиск)" : "(избранное)"}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(
              Icons.receipt_long,
            ),
            //centerTitle: true,
            actions: [
              FlatButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlurryDialog("Выйти из аккаунта",
                              "Вы действительно хотите выйти?", () {
                            AuthService().logOut();
                          });
                        });

                    //BlurryDialog("title", "Вы действительно хотите выйти?", () {AuthService().logOut(); });
                    //AuthService().logOut();
                  },
                  label: Text(""),
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ))
            ],
          ),
          body: sectionIndex == 0 ? RecipesList() : FavoriteRecipes(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddRecipe()));
            },
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
          ),
          bottomNavigationBar: navigationBar),
    );
  }
}
