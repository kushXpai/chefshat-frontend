import 'package:flutter/material.dart';

import '../../constants/colors/customColors.dart';

class RecipeButton {
  String name;
  bool isSelected;

  RecipeButton(
    this.name,
    this.isSelected,
  );
}

class recipeGenerator extends StatefulWidget {
  const recipeGenerator({Key? key}) : super(key: key);

  static int ingredientsSelected = 0;
  static List<String> selectedIngredients = [];

  @override
  State<recipeGenerator> createState() => _recipeGeneratorState();
}

class _recipeGeneratorState extends State<recipeGenerator> {
  static var category = "";

  TextEditingController searchController = TextEditingController();
  List<RecipeButton> filteredIngredients = [];
  bool _isShowSearch = false;

  bool _isShowPantryEssentials = false;
  static int selectedPantryEssentials = 0;
  List<String> selectedIngredientsPantryEssentials = [];
  List<RecipeButton> pantryEssentials = [
    RecipeButton('baking powder', false),
    RecipeButton('baking soda', false),
    RecipeButton('basil', false),
    RecipeButton('bell pepper', false),
    RecipeButton('bread', false),
    RecipeButton('brown sugar', false),
    RecipeButton('butter', false),
    RecipeButton('carrot', false),
    RecipeButton('cheddar', false),
    RecipeButton('chicken breast', false),
    RecipeButton('chilli powder', false),
    RecipeButton('cinnamon', false),
    RecipeButton('cumin', false),
    RecipeButton('egg', false),
    RecipeButton('flour', false),
    RecipeButton('garlic', false),
    RecipeButton('garlic powder', false),
    RecipeButton('honey', false),
    RecipeButton('italian seasoning', false),
    RecipeButton('ketchup', false),
    RecipeButton('mayonnaise', false),
    RecipeButton('milk', false),
    RecipeButton('Mustard', false),
    RecipeButton('olive oil', false),
    RecipeButton('onion', false),
    RecipeButton('onion powder', false),
    RecipeButton('oregano', false),
    RecipeButton('paprika', false),
    RecipeButton('parmesan', false),
    RecipeButton('parsley', false),
    RecipeButton('peanut butter', false),
    RecipeButton('potato', false),
    RecipeButton('rice', false),
    RecipeButton('soy sauce', false),
    RecipeButton('spaghetti', false),
    RecipeButton('sugar', false),
    RecipeButton('thyme', false),
    RecipeButton('tomato', false),
    RecipeButton('vanilla', false),
    RecipeButton('vegetable oil', false),
  ];

  bool _isShowVegetables = false;
  static int selectedVegetables = 0;
  List<String> selectedIngredientsVegetables = [];
  List<RecipeButton> vegetables = [
    RecipeButton('Artichoke', false),
    RecipeButton('Asparagus', false),
    RecipeButton('Baby Corn', false),
    RecipeButton('Beetroot', false),
    RecipeButton('Bell Pepper Green', false),
    RecipeButton('Bell Pepper Red', false),
    RecipeButton('Bell Pepper Yellow', false),
    RecipeButton('Bell Pepper', false),
    RecipeButton('Broccoli', false),
    RecipeButton('Brussels sprouts', false),
    RecipeButton('cabbage', false),
    RecipeButton('carrot', false),
    RecipeButton('Cauliflower', false),
    RecipeButton('Celery Stalk', false),
    RecipeButton('Cucumber', false),
    RecipeButton('Eggplant', false),
    RecipeButton('Garlic', false),
    RecipeButton('Ginger', false),
    RecipeButton('Kale', false),
    RecipeButton('Lettuce', false),
    RecipeButton('Okra', false),
    RecipeButton('Onion Red', false),
    RecipeButton('Onion White', false),
    RecipeButton('Potato', false),
    RecipeButton('Pumpkin', false),
    RecipeButton('Radish', false),
    RecipeButton('Spinach', false),
    RecipeButton('Squash', false),
    RecipeButton('Sweet Potato', false),
    RecipeButton('Tomatoes Cherry Red', false),
    RecipeButton('Tomatoes Cherry Yellow', false),
    RecipeButton('Tomatoes', false),
    RecipeButton('Turnip', false),
    RecipeButton('Zucchini', false),
  ];

  bool _isShowMushrooms = false;
  static int selectedMushrooms = 0;
  List<String> selectedIngredientsMushrooms = [];
  List<RecipeButton> mushrooms = [
    RecipeButton('button', false),
    RecipeButton('oyster', false),
    RecipeButton('Portabello', false),
    RecipeButton('wild', false),
  ];

  bool _isShowFruits = false;
  static int selectedFruits = 0;
  List<String> selectedIngredientsFruits = [];
  List<RecipeButton> fruits = [
    RecipeButton('Apple', false),
    RecipeButton('Banana', false),
    RecipeButton('Grapes Black', false),
    RecipeButton('Grapes Green', false),
    RecipeButton('Peach', false),
    RecipeButton('Pineapple', false),
    RecipeButton('Watermelon', false),
  ];

  bool _isShowBerries = false;
  static int selectedBerries = 0;
  List<String> selectedIngredientsBerries = [];
  List<RecipeButton> berries = [
    RecipeButton('Blackberry', false),
    RecipeButton('Blueberry', false),
    RecipeButton('Mixed', false),
    RecipeButton('Raspberry', false),
    RecipeButton('Strawberry', false),
  ];

  bool _isShowNutsSeeds = false;
  static int selectedNutsSeeds = 0;
  List<String> selectedIngredientsNutsSeeds = [];
  List<RecipeButton> nutsSeeds = [];

  bool _isShowCheeses = false;
  static int selectedCheeses = 0;
  List<String> selectedIngredientsCheeses = [];
  List<RecipeButton> cheeses = [
    RecipeButton('Blue', false),
    RecipeButton('Cheddar', false),
    RecipeButton('Mozzarella', false),
    RecipeButton('Parmesan', false),
  ];

  bool _isShowDairy = false;
  static int selectedDairy = 0;
  List<String> selectedIngredientsDairy = [];
  List<RecipeButton> dairy = [
    RecipeButton('Butter', false),
    RecipeButton('ButterMilk', false),
    RecipeButton('Fresh Cream', false),
    RecipeButton('Heavy Cream', false),
    RecipeButton('Sour Cream', false),
    RecipeButton('Milk', false),
  ];

  bool _isShowEggs = false;
  static int selectedEggs = 0;
  List<String> selectedIngredientsEggs = [];
  List<RecipeButton> eggs = [
    RecipeButton('Eggs Chicken', false),
  ];

  bool _isShowPasta = false;
  static int selectedPasta = 0;
  List<String> selectedIngredientsPasta = [];
  List<RecipeButton> pasta = [
    RecipeButton('Egg Noodles', false),
    RecipeButton('Fusilli', false),
    RecipeButton('Gnocchi', false),
    RecipeButton('Macaroni', false),
    RecipeButton('Penne', false),
  ];

  bool _isShowMeat = false;
  static int selectedMeat = 0;
  List<String> selectedIngredientsMeat = [];
  List<RecipeButton> meat = [
    RecipeButton('Bacon', false),
    RecipeButton('Beef Ground', false),
    RecipeButton('Beef Sirloin', false),
    RecipeButton('Pork Ribs', false),
    RecipeButton('Pork', false),
  ];

  bool _isShowPoultry = false;
  static int selectedPoultry = 0;
  List<String> selectedIngredientsPoultry = [];
  List<RecipeButton> poultry = [
    RecipeButton('Chicken Breast', false),
    RecipeButton('Chicken Drumsticks', false),
    RecipeButton('Chicken Whole', false),
    RecipeButton('Chicken Wings', false),
  ];

  bool _isShowFish = false;
  static int selectedFish = 0;
  List<String> selectedIngredientsFish = [];
  List<RecipeButton> fish = [];

  bool _isShowShellfish = false;
  static int selectedShellfish = 0;
  List<String> selectedIngredientsShellfish = [];
  List<RecipeButton> shellfish = [
    RecipeButton('Calms', false),
  ];

  bool _isShowHerbsNSpices = false;
  static int selectedHerbsNSpices = 0;
  List<String> selectedIngredientsHerbsNSpices = [];
  List<RecipeButton> herbsNSpices = [
    RecipeButton('Chilli Flakes', false),
    RecipeButton('Parsley', false),
    RecipeButton('Thyme', false),
    RecipeButton('Basil', false),
    RecipeButton('Chilli Powder', false),
    RecipeButton('Cinnamon Powder', false),
    RecipeButton('Garlic Powder', false),
    RecipeButton('Onion Powder', false),
    RecipeButton('Cinnamon', false),
    RecipeButton('Cumin', false),
    RecipeButton('Paprika', false),
  ];

  bool _isShowSweetsNSweetners = false;
  static int selectedSweetsNSweetners = 0;
  List<String> selectedIngredientsSweetsNSweetners = [];
  List<RecipeButton> sweetsNSweetners = [
    RecipeButton('Honey', false),
    RecipeButton('Sugar Brown', false),
    RecipeButton('Sugar White', false),
  ];

  bool _isShowSeasonings = false;
  static int selectedSeasonings = 0;
  List<String> selectedIngredientsSeasonings = [];
  List<RecipeButton> seasonings = [
    RecipeButton('Salt N Pepper', false),
    RecipeButton('Italian', false),
  ];

  bool _isShowBaking = false;
  static int selectedBaking = 0;
  List<String> selectedIngredientsBaking = [];
  List<RecipeButton> baking = [
    RecipeButton('Flour All Purpose', false),
  ];

  bool _isShowGrains = false;
  static int selectedGrains = 0;
  List<String> selectedIngredientsGrains = [];
  List<RecipeButton> grains = [
    RecipeButton('Corn', false),
  ];

  void filterIngredients(String query) {
    query = query.toLowerCase();
    filteredIngredients.clear();

    for (var ingredient in pantryEssentials) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in vegetables) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in mushrooms) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in fruits) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in berries) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in nutsSeeds) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in cheeses) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in dairy) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in eggs) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in pasta) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in meat) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in poultry) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in fish) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in shellfish) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in herbsNSpices) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in sweetsNSweetners) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in seasonings) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in baking) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }

    for (var ingredient in grains) {
      if (ingredient.name.toLowerCase().contains(query)) {
        filteredIngredients.add(ingredient);
      }
    }
  }

  int? eval(String expression) {
    return expression != null ? int.tryParse(expression) : null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColors.black,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.15,
                        child: Container(
                          width: size.width,
                          height: 224,
                          child: const Image(
                            image: AssetImage(
                                'assets/recipeGeneratorPhotos/recipeGeneratotBackground.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 224,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 50, bottom: 5),
                              child: Center(
                                child: Text(
                                  'Pantry',
                                  style: TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 30),
                              child: Center(
                                child: Text(
                                  'You have ${recipeGenerator.ingredientsSelected} ingredients',
                                  style: const TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child: TextField(
                                controller: searchController,
                                onTap: () {
                                  setState(() {
                                    _isShowSearch = true;
                                  });
                                },
                                onChanged: (query) {
                                  setState(() {
                                    filterIngredients(query);
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    _isShowSearch = false;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: "Search...",
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Georgia",
                                    color: Colors.lime,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: CustomColors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                    BorderSide(width: 1, color: Colors.lime),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 66, 125, 145)),
                                  ),
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Set the border color here
                                      width: 6.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height - 380,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                        ),

                        SizedBox(
                          width: size.width,
                          height: size.height - 380,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Display filtered ingredients
                                Visibility(
                                    visible: _isShowSearch,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 15, bottom: 5),
                                      child: buildButtons(filteredIngredients),
                                    )),

                                // Pantry Essentials
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Pantry Essentials',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedPantryEssentials / ${pantryEssentials.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials =
                                                      !_isShowPantryEssentials;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowPantryEssentials == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowPantryEssentials,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsPantryEssentials(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Vegetables
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Vegetables',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedVegetables / ${vegetables.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables =
                                                      !_isShowVegetables;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowVegetables == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowVegetables,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsVegetables(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Mushroom
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Mushrooms',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedMushrooms / ${mushrooms.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms =
                                                      !_isShowMushrooms;
                                                      _isShowFruits = false;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowMushrooms == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowMushrooms,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsMushrooms(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Fruits
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Fruits',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedFruits / ${fruits.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = !_isShowFruits;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowFruits == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowFruits,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsFruits(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Berries
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Berries',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedBerries / ${berries.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries =
                                                      !_isShowBerries;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowBerries == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowBerries,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsBerries(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Nuts and Seeds
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Nuts & Seeds',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedNutsSeeds / ${nutsSeeds.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds =
                                                      !_isShowNutsSeeds;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowNutsSeeds == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowNutsSeeds,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsNutsSeeds(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Cheeses
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Cheeses',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedCheeses / ${cheeses.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses =
                                                      !_isShowCheeses;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowCheeses == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowCheeses,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsCheeses(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Dairy
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Dairy',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedDairy / ${dairy.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = !_isShowDairy;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowDairy == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowDairy,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsDairy(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Eggs
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Eggs',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedEggs / ${eggs.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = !_isShowEggs;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowEggs == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowEggs,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsEggs(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Pasta
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Pasta',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedPasta / ${pasta.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = !_isShowPasta;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowPasta == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowPasta,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsPasta(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Meat
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Meat',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedMeat / ${meat.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = !_isShowMeat;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowMeat == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowMeat,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsMeat(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Poultry
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Poultry',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedPoultry / ${poultry.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry =
                                                      !_isShowPoultry;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowPoultry == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowPoultry,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsPoultry(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Fish
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Fish',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedFish / ${fish.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = !_isShowFish;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowFish == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowFish,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsFish(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Shellfish
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'ShellFish',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedShellfish / ${shellfish.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish =
                                                      !_isShowShellfish;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowShellfish == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowShellfish,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsShellfish(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Herbs N Spices
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Herbs N Spices',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedHerbsNSpices / ${herbsNSpices.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish = false;
                                                      _isShowHerbsNSpices =
                                                      !_isShowHerbsNSpices;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowHerbsNSpices == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowHerbsNSpices,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsHerbsNSpices(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Sweets N Sweetners
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Sweets N Sweetners',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedSweetsNSweetners / ${sweetsNSweetners.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish = false;
                                                      _isShowHerbsNSpices = false;
                                                      _isShowSweetsNSweetners =
                                                      !_isShowSweetsNSweetners;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowSweetsNSweetners == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowSweetsNSweetners,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsSweetsNSweetners(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Seasonings
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Seasonings',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedSeasonings / ${seasonings.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish = false;
                                                      _isShowHerbsNSpices = false;
                                                      _isShowSweetsNSweetners = false;
                                                      _isShowSeasonings =
                                                      !_isShowSeasonings;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowSeasonings == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowSeasonings,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsSeasonings(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Baking
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Baking',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedBaking / ${baking.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish = false;
                                                      _isShowHerbsNSpices = false;
                                                      _isShowSweetsNSweetners = false;
                                                      _isShowSeasonings = false;
                                                      _isShowBaking = !_isShowBaking;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowBaking == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowBaking,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsBaking(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Grains
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Grains',
                                                style: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '($selectedGrains / ${grains.length})',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      _isShowPantryEssentials = false;
                                                      _isShowVegetables = false;
                                                      _isShowMushrooms = false;
                                                      _isShowFruits = false;
                                                      _isShowBerries = false;
                                                      _isShowNutsSeeds = false;
                                                      _isShowCheeses = false;
                                                      _isShowDairy = false;
                                                      _isShowEggs = false;
                                                      _isShowPasta = false;
                                                      _isShowMeat = false;
                                                      _isShowPoultry = false;
                                                      _isShowFish = false;
                                                      _isShowShellfish = false;
                                                      _isShowHerbsNSpices = false;
                                                      _isShowSweetsNSweetners = false;
                                                      _isShowSeasonings = false;
                                                      _isShowBaking = false;
                                                      _isShowGrains = !_isShowGrains;
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.transparent,
                                                  backgroundColor: Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor: Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding: const EdgeInsets.all(0),
                                                ),
                                                child: _isShowGrains == true
                                                    ? const Icon(
                                                  Icons.arrow_drop_up_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Visibility(
                                            visible: _isShowGrains,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.white,
                                                      thickness: 1,
                                                    ),
                                                    buildButtonsGrains(),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // Display List
                                Text(
                                  '${recipeGenerator.selectedIngredients}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                  Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 156,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 10, bottom: 0),
                                child: Container(
                                  width: 130,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.amber, width: 1), // Set the border color
                                    borderRadius: BorderRadius.circular(10),
                                    // Set the border radius
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor: Colors.white10,
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                    child: Text(
                                      "My Pantry ( ${recipeGenerator.ingredientsSelected} )",
                                      style: const TextStyle(
                                        fontFamily: 'Georgia',
                                        fontSize: 15,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 10, bottom: 0),
                                child: Container(
                                  width: 210,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.lime, width: 1), // Set the border color
                                    borderRadius: BorderRadius.circular(10),
                                    // Set the border radius
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (recipeGenerator.ingredientsSelected > 0){
                                        Navigator.pushNamed(context, 'displayDishList');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor: recipeGenerator.ingredientsSelected > 0 ? Colors.lime : Colors.transparent,
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                    child: Text(
                                      "See Recipes",
                                      style: TextStyle(
                                        fontFamily: 'Georgia',
                                        fontSize: 15,
                                        fontWeight: recipeGenerator.ingredientsSelected > 0 ? FontWeight.bold : FontWeight.normal,
                                        color: recipeGenerator.ingredientsSelected > 0 ? Colors.black : Colors.lime,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 300, right: 20, top: 50, bottom: 0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          recipeGenerator.selectedIngredients.clear();
                          recipeGenerator.ingredientsSelected = 0;

                          selectedIngredientsPantryEssentials.clear();
                          selectedPantryEssentials = 0;
                          selectedIngredientsVegetables.clear();
                          selectedVegetables = 0;
                          selectedIngredientsMushrooms.clear();
                          selectedMushrooms = 0;
                          selectedIngredientsFruits.clear();
                          selectedFruits = 0;
                          selectedIngredientsBerries.clear();
                          selectedBerries = 0;
                          selectedIngredientsCheeses.clear();
                          selectedNutsSeeds = 0;
                          selectedIngredientsCheeses.clear();
                          selectedCheeses = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildButtons(List<RecipeButton> ingredients) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: ingredients.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
            });

            if (button.isSelected) {
              selectedIngredientsPantryEssentials.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);

              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                if (pantryEssentials.any((item) => item.name == button.name)) {
                  selectedPantryEssentials += 1;
                }
                if (vegetables.any((item) => item.name == button.name)) {
                  selectedVegetables += 1;
                }
                if (mushrooms.any((item) => item.name == button.name)) {
                  selectedMushrooms += 1;
                }
                if (fruits.any((item) => item.name == button.name)) {
                  selectedFruits += 1;
                }
                if (berries.any((item) => item.name == button.name)) {
                  selectedBerries += 1;
                }
                if (nutsSeeds.any((item) => item.name == button.name)) {
                  selectedNutsSeeds += 1;
                }
                if (cheeses.any((item) => item.name == button.name)) {
                  selectedCheeses += 1;
                }
                if (dairy.any((item) => item.name == button.name)) {
                  selectedDairy += 1;
                }
                if (eggs.any((item) => item.name == button.name)) {
                  selectedEggs += 1;
                }
                if (pasta.any((item) => item.name == button.name)) {
                  selectedPasta += 1;
                }
                if (meat.any((item) => item.name == button.name)) {
                  selectedMeat += 1;
                }
                if (poultry.any((item) => item.name == button.name)) {
                  selectedPoultry += 1;
                }
                if (fish.any((item) => item.name == button.name)) {
                  selectedFish += 1;
                }
                if (herbsNSpices.any((item) => item.name == button.name)) {
                  selectedHerbsNSpices += 1;
                }
                if (sweetsNSweetners.any((item) => item.name == button.name)) {
                  selectedSweetsNSweetners += 1;
                }
                if (baking.any((item) => item.name == button.name)) {
                  selectedBaking += 1;
                }
                if (grains.any((item) => item.name == button.name)) {
                  selectedGrains += 1;
                }
              });
            } else {
              selectedIngredientsPantryEssentials.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);

              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                if (pantryEssentials.any((item) => item.name == button.name)) {
                  selectedPantryEssentials -= 1;
                }
                if (vegetables.any((item) => item.name == button.name)) {
                  selectedVegetables -= 1;
                }
                if (mushrooms.any((item) => item.name == button.name)) {
                  selectedMushrooms -= 1;
                }
                if (fruits.any((item) => item.name == button.name)) {
                  selectedFruits -= 1;
                }
                if (berries.any((item) => item.name == button.name)) {
                  selectedBerries -= 1;
                }
                if (nutsSeeds.any((item) => item.name == button.name)) {
                  selectedNutsSeeds -= 1;
                }
                if (cheeses.any((item) => item.name == button.name)) {
                  selectedCheeses -= 1;
                }
                if (dairy.any((item) => item.name == button.name)) {
                  selectedDairy -= 1;
                }
                if (eggs.any((item) => item.name == button.name)) {
                  selectedEggs -= 1;
                }
                if (pasta.any((item) => item.name == button.name)) {
                  selectedPasta -= 1;
                }
                if (meat.any((item) => item.name == button.name)) {
                  selectedMeat -= 1;
                }
                if (poultry.any((item) => item.name == button.name)) {
                  selectedPoultry -= 1;
                }
                if (fish.any((item) => item.name == button.name)) {
                  selectedFish -= 1;
                }
                if (herbsNSpices.any((item) => item.name == button.name)) {
                  selectedHerbsNSpices -= 1;
                }
                if (sweetsNSweetners.any((item) => item.name == button.name)) {
                  selectedSweetsNSweetners -= 1;
                }
                if (baking.any((item) => item.name == button.name)) {
                  selectedBaking -= 1;
                }
                if (grains.any((item) => item.name == button.name)) {
                  selectedGrains -= 1;
                }
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsPantryEssentials() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: pantryEssentials.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "pantryEssentials";
            });
            if (button.isSelected) {
              selectedIngredientsPantryEssentials.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedPantryEssentials += 1;
              });
            } else {
              selectedIngredientsPantryEssentials.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedPantryEssentials -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsVegetables() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: vegetables.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "vegetables";
            });
            if (button.isSelected) {
              selectedIngredientsVegetables.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedVegetables += 1;
              });
            } else {
              selectedIngredientsVegetables.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedVegetables -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsMushrooms() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: mushrooms.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "mushrooms";
            });
            if (button.isSelected) {
              selectedIngredientsMushrooms.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedMushrooms += 1;
              });
            } else {
              selectedIngredientsMushrooms.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedMushrooms -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsFruits() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: fruits.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "fruits";
            });
            if (button.isSelected) {
              selectedIngredientsFruits.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedFruits += 1;
              });
            } else {
              selectedIngredientsFruits.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedFruits -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsBerries() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: berries.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "berries";
            });
            if (button.isSelected) {
              selectedIngredientsBerries.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedBerries += 1;
              });
            } else {
              selectedIngredientsBerries.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedBerries -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsNutsSeeds() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: nutsSeeds.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "nutsSeeds";
            });
            if (button.isSelected) {
              selectedIngredientsNutsSeeds.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedNutsSeeds += 1;
              });
            } else {
              selectedIngredientsNutsSeeds.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedNutsSeeds -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsCheeses() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: cheeses.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "cheeses";
            });
            if (button.isSelected) {
              selectedIngredientsCheeses.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedCheeses += 1;
              });
            } else {
              selectedIngredientsCheeses.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedCheeses -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsDairy() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: dairy.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "dairy";
            });
            if (button.isSelected) {
              selectedIngredientsDairy.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedDairy += 1;
              });
            } else {
              selectedIngredientsDairy.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedDairy -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsEggs() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: eggs.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "eggs";
            });
            if (button.isSelected) {
              selectedIngredientsEggs.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedEggs += 1;
              });
            } else {
              selectedIngredientsEggs.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedEggs -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsPasta() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: pasta.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "pasta";
            });
            if (button.isSelected) {
              selectedIngredientsPasta.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedPasta += 1;
              });
            } else {
              selectedIngredientsPasta.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedPasta -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsMeat() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: meat.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "meat";
            });
            if (button.isSelected) {
              selectedIngredientsMeat.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedMeat += 1;
              });
            } else {
              selectedIngredientsMeat.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedMeat -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsPoultry() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: poultry.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "poultry";
            });
            if (button.isSelected) {
              selectedIngredientsPoultry.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedPoultry += 1;
              });
            } else {
              selectedIngredientsPoultry.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedPoultry -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsFish() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: fish.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "fish";
            });
            if (button.isSelected) {
              selectedIngredientsFish.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedFish += 1;
              });
            } else {
              selectedIngredientsFish.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedFish -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsShellfish() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: shellfish.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "shellfish";
            });
            if (button.isSelected) {
              selectedIngredientsShellfish.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedShellfish += 1;
              });
            } else {
              selectedIngredientsShellfish.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedShellfish -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsHerbsNSpices() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: herbsNSpices.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "herbsNSpices";
            });
            if (button.isSelected) {
              selectedIngredientsHerbsNSpices.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedHerbsNSpices += 1;
              });
            } else {
              selectedIngredientsHerbsNSpices.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedHerbsNSpices -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsSweetsNSweetners() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: sweetsNSweetners.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "sweetsNSweetners";
            });
            if (button.isSelected) {
              selectedIngredientsSweetsNSweetners.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedSweetsNSweetners += 1;
              });
            } else {
              selectedIngredientsSweetsNSweetners.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedSweetsNSweetners -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsSeasonings() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: seasonings.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "seasonings";
            });
            if (button.isSelected) {
              selectedIngredientsSeasonings.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedSeasonings += 1;
              });
            } else {
              selectedIngredientsSeasonings.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedSeasonings -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsBaking() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: baking.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "baking";
            });
            if (button.isSelected) {
              selectedIngredientsBaking.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedBaking += 1;
              });
            } else {
              selectedIngredientsBaking.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedBaking -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildButtonsGrains() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: grains.map((button) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              button.isSelected = !button.isSelected;
              category = "grains";
            });
            if (button.isSelected) {
              selectedIngredientsGrains.add(button.name);
              recipeGenerator.selectedIngredients.add(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected += 1;
                selectedGrains += 1;
              });
            } else {
              selectedIngredientsGrains.remove(button.name);
              recipeGenerator.selectedIngredients.remove(button.name);
              setState(() {
                recipeGenerator.ingredientsSelected -= 1;
                selectedGrains -= 1;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                button.isSelected ? Colors.lime : Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          child: Text(
            button.name,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: button.isSelected ? Colors.black : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
