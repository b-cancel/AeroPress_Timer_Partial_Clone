import 'dart:math';
import 'recipe.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  final CoffeeRecipe recipe;

  TimerScreen(this.recipe);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  int current_step=0;
  int total_steps=0;
  bool finished;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds)}';
  }

  @override
  void initState() {
    super.initState();

    current_step = 0;
    total_steps =widget.recipe.steps.length;
    finished = false;

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: widget.recipe.steps[current_step].time));
        animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value);
  }

  bool timerFinished(){
    return animationController.value == 0;
  }

  bool onLastStep(){
    return current_step == total_steps - 1;
  }

  bool finishedAllSteps(){
    return timerFinished() && onLastStep();
  }

  void restartTimer(){
    animationController.reverse(
    from: animationController.value == 0.0
        ? 1.0
        : animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    print("redraw");

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
            if(finishedAllSteps()){
              Navigator.of(context).maybePop();
            }else{
              if(timerFinished() && !onLastStep()){
                current_step+=1;
                restartTimer();
              }
                
              return CurrentStepScreen(
                recipe: widget.recipe,
                step: widget.recipe.steps[current_step], 
                timerString: timerString,
                stepNumber: current_step,
              );

            }
      },
    );
  }
}

class CurrentStepScreen extends StatelessWidget {
  final CoffeeRecipe recipe;
  final RecipeStep step;
  final String timerString;
  final int stepNumber;

  CurrentStepScreen({
    this.recipe,
    this.step, 
    this.timerString, 
    this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    int nextStepNumber = stepNumber; 
    List<String> upcommingSteps = new List<String>();
    if(nextStepNumber < recipe.steps.length){
      for(int i = nextStepNumber; i < recipe.steps.length; i++){
        upcommingSteps.add(recipe.steps[i].text);
      }
    }

    for(int i = 0; i < upcommingSteps.length; i++){
      print("step " + upcommingSteps[i]);
    }
    
    return Scaffold(
      body: Container(
        child: new Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                timerString,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 164,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 32,
              ),
              new Text(
                recipe.steps[stepNumber].text,
                style: TextStyle(
                  fontSize: 48,
                ),
              ),
              new Text(
                recipe.steps[stepNumber].subtext,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                height: 48,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: upcommingSteps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Text(
                      upcommingSteps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}