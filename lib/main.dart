import 'package:final_exam/countdown.dart';
import 'package:final_exam/recipe.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    final List<CoffeeRecipe> recipes = [
      makeClassicRecipe(),
      makeChargerRecipe(),
      makeInvertedRecipe(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text("AreoPRESS"),
            new Text("TIMER"),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return new ARecipe(
            recipe: recipes[index],
          );
        }
      ),
    );
  }
}

class ARecipe extends StatelessWidget {
  final CoffeeRecipe recipe;
  final Color iconColor;

  ARecipe({
    this.recipe,
    this.iconColor: Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeDetails(
              recipe: recipe,
            )),
          );
        },
        child: Container(  
          padding: EdgeInsets.all(8),
          decoration: new BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.circular(
              5,
            ),
          ), 
          child: new Row(
            children: <Widget>[
              Icon(
                Icons.ac_unit,
                color: iconColor,
              ),
              Container(
                width: 16,
              ),
              Text(recipe.name),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  final CoffeeRecipe recipe;

  RecipeDetails({
    this.recipe,
  }); 

  @override
  Widget build(BuildContext context) {
    double cubeSize = MediaQuery.of(context).size.width * (4/5);
    cubeSize /= 3;

    final List<RecipeStep> recipeSteps = recipe.steps;

    return new Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.maybePop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.chevron_left),
              Text("Back")
            ],
          ),
        ),
        centerTitle: true,
        title: Text(recipe.name),
      ),
      body: Column(
        children: <Widget>[
          new ActualDetails(
            recipe: recipe,
            cubeSize: cubeSize,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Container(
              height: 2,
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.bottomLeft,
            child: new Text(
              "Steps",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipeSteps.length,
              itemBuilder: (BuildContext context, int index) {
                return new ARecipeStep(
                  step: recipeSteps[index],
                  recipe: recipe,
                );
              }
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: new RaisedButton(
              onPressed: (){
                print("pressed");
              },
              color: Colors.pink,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerScreen(recipe)),
                  );
                },
                child: new Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.center,
                  child: new Text(
                    "Start Timer",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class ActualDetails extends StatelessWidget {
  const ActualDetails({
    Key key,
    this.recipe,
    @required this.cubeSize,
  }) : super(key: key);

  final CoffeeRecipe recipe;
  final double cubeSize;

  @override
  Widget build(BuildContext context) {
    int totalTime = 0;
    for(int i = 0; i < recipe.steps.length; i++){
      totalTime += recipe.steps[i].time;
    }

    return Container(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Cube(
                  cubeSize: cubeSize,
                  child: new Text(recipe.brew_method),
                  subtext: "Brew Method",
                ),
                new Cube(
                  cubeSize: cubeSize,
                  child: new BigNumLittleText(
                    number: recipe.coffee_volume_grams.toString(),
                    text: "grams",
                  ),
                  subtext: "Coffee Volume",
                ),
                new Cube(
                  cubeSize: cubeSize,
                  child: new Text(
                    recipe.grind_size,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtext: "Grind Size",
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Cube(
                  cubeSize: cubeSize,
                  child: new BigNumLittleText(
                    number: recipe.water_volume_grams.toString(),
                    text: "grams",
                  ),
                  subtext: "Water Volume",
                ),
                new Cube(
                  cubeSize: cubeSize,
                  child: new BigNumLittleText(
                    number: recipe.temperature.toString() + "\u00b0",
                    text: "Fahrenheit",
                  ),
                  subtext: "Temperature",
                ),
                new Cube(
                  cubeSize: cubeSize,
                  child: new BigNumLittleText(
                    number: totalTime.toString(),
                    text: "Seconds",
                  ),
                  subtext: "Total Time",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigNumLittleText extends StatelessWidget {
  const BigNumLittleText({
    this.number,
    this.text,
    Key key,
  }) : super(key: key);

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Text(text)
        ],
      ),
    );
  }
}

class Cube extends StatelessWidget {
  const Cube({
    Key key,
    @required this.cubeSize,
    this.child,
    this.subtext,
  }) : super(key: key);

  final double cubeSize;
  final Widget child;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.circular(
              5,
            ),
          ), 
          height: cubeSize,
          width: cubeSize,
          child: child,
        ),
        Container(
          padding: EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: new Text(subtext),
        )
      ],
    );
  }
}

class ARecipeStep extends StatelessWidget {
  final RecipeStep step;
  final CoffeeRecipe recipe;

  ARecipeStep({
    this.step,
    @required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: new BoxDecoration(
          color: Colors.black,
          borderRadius: new BorderRadius.circular(
            5,
          ),
        ), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: step.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  TextSpan(
                    text: " / " + step.subtext,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    )
                  ),
                ]
              ),
            ),
            new Text(
              step.time.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}