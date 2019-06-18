class CoffeeRecipe{
  String name;
  String brew_method;
  int coffee_volume_grams;
  String grind_size;
  int water_volume_grams;
  int temperature;
  List<RecipeStep> steps;

  CoffeeRecipe(this.name, this.brew_method, this.coffee_volume_grams, this.grind_size, this.water_volume_grams, this.temperature, this.steps);
}

class RecipeStep{
  String text;
  String subtext;
  int time;

  RecipeStep(this.text, this.subtext, this.time);
}

CoffeeRecipe makeClassicRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "120 grams", 10),
    RecipeStep("Stir", "", 20),
    RecipeStep("Steep", "", 15),
    RecipeStep("Plunge", "", 15),
    ];
  CoffeeRecipe classic =CoffeeRecipe("The Classic", "Traditional", 30, "medium fine", 120, 185, steps);
  return classic;
}

CoffeeRecipe makeChargerRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "250 grams", 10),
    RecipeStep("Stir", "", 10),
    RecipeStep("Steep", "", 70),
    RecipeStep("Stir", "", 10),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Charger", "Traditional", 17, "medium fine", 250, 200, steps);
  return recipe;
}

CoffeeRecipe makeInvertedRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "120 grams", 15),
    RecipeStep("Stir", "", 15),
    RecipeStep("Steep", "", 45),
    RecipeStep("Stir", "", 15),
    RecipeStep("Stir", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Inverted", "Inverted", 17, "medium", 120, 205, steps);
  return recipe;
}