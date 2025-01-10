import sqlitewrapper
from sqlitewrapper import types

def addRecipe(user, db):
  print("\nPlease enter the following recipe information")
  recipeName = ''
  while(recipeName == ''):
    recipeName = input("Recipe Name:\n")
    if(recipeName == ''):
      print("Invalid recipe name. Try again.")
  instructions = ''
  while(instructions == ''):
    instructions = input("Instructions:\n")
    if(instructions == ''):
      print("Invalid instructions. Try again.")
  prepTime = ''
  while(prepTime == ''):
    prepTime = input("Prep Time:\n")
    if(prepTime == ''):
      print("Invalid prep time. Try again.")
  category = ''
  while(category == ''):
    category = input("Food Category:\n")
    if(category == ''):
      print("Invalid category. Try again.")
  complexity = 0
  while(complexity < 1 or complexity > 10):
    complexity = int(input("Complexity (between 1 and 10):\n"))
    if(complexity < 1 or complexity > 10):
      print("Invalid Complexity level: Must be a number between one and ten. Try again.")
  recipeTable = db.table("recipes")
  recipeTable.add(contributor=user, recipe_name=recipeName, instructions=instructions, prep_time=prepTime, category=category, complexity=complexity)

  recipe_id = len(recipeTable.getAll("recipe_id").run()) # Gets the recipe_id of the recipe that was just added

  print("\nPlease enter the authors of this recipe. When you are finished, type 'Done'")
  created_by = db.table("created_by")
  author = ""
  while(author != "Done"):
    author = input()
    if(author == ''):
      print("Not a valid author.")
    else:
      created_by.add(associated_recipe_id=recipe_id, author=author)

  print("\nPlease enter the ingredients need by this recipe. When you are finished, type 'Done'")
  uses_ingredients = db.table("uses_ingredients")
  ingredient = ""
  while(ingredient != "Done"):
    ingredient = input()
    if(ingredient == ''):
      print("Not a valid ingredient.")
    else:
      uses_ingredients.add(associated_recipe_id=recipe_id, ingredient=ingredient)

  print("Thank you for adding a recipe for " + recipeName + ". Redirecting back to home page...")
  mainPage(user, db)


def writeReview(user, db, recipe_id):
  score = 0
  print("Please enter a score for your review")
  while(score < 1 or score > 10):
    score = int(input("Enter a number between 1 and 10:\n"))
    if(score < 1 or score > 10):
      print("Invalid score. Try again.")

  comment = input("Please enter the reasoning for your score:\n")

  allReviews = db.table("reviews")
  allReviews.add(associated_recipe_id=recipe_id, reviewer=user, score=score, comments=comment)
  print("Thank you for providing feedback on this recipe. Returning to main menu...")
  mainPage(user, db)
  

def viewReviewList(user, db, recipe_id):
  allReviews = db.table("reviews")
  reviewInfos = allReviews.getAll("reviewer", "score", "comments").where("associated_recipe_id").eq(recipe_id).run()
  if(len(reviewInfos) == 0):
    print("There are no reviews for this recipe. Returning to main menu...")
  else:
    print("Here are the reviews for this recipe:")
    for reviewTuple in reviewInfos:
        reviewer, score, comments = reviewTuple
        print("\nScore: " + str(score) + "\tReviewer: " + reviewer + "\nExplanation: " + comments)
    print("No more reviews... Returning to main menu...")

  mainPage(user, db)


def viewRecipe(user, db, recipe_id):
  allRecipes = db.table("recipes")
  category, recipe_name, instructions, prep_time, complexity, contributor = allRecipes.get("category", "recipe_name", "instructions", "prep_time", "complexity", "contributor").where("recipe_id").eq(recipe_id).run()

  allAuthors = db.table("created_by")
  authors = []
  tempAuthors = allAuthors.getAll("author").where("associated_recipe_id").eq(recipe_id).run()
  for tuple in tempAuthors:
    name = tuple[0]
    authors.append(name)

  allIngredients = db.table("uses_ingredients")
  ingredients = []
  tempIngredients = allIngredients.getAll("ingredient").where("associated_recipe_id").eq(recipe_id).run()
  for tuple in tempIngredients:
    name = tuple[0]
    ingredients.append(name)

  print("\n*****" + recipe_name + "*****")
  print("Author(s): " + ", ".join(authors))
  print("Contributed to this database by: " + contributor)
  print("Estimated time: " + prep_time)
  print("Complexity: " + str(complexity) + "/10")
  print("Category: " + category)
  print("Ingredients: " + "\n- ".join(ingredients))
  print("Instructions: " + instructions)

  print("\nWhat would you like to do next?\nSee reviews for this recipe: 1\nWrite a review for this recipe: 2\nReturn to main menu: 3")
  userAction = '0'
  while(userAction not in ['1', '2', '3']):
    userAction = input()
    if(userAction not in ['1', '2', '3']):
      print("Invalid input. Please enter a number in the range 1-3")

  if(userAction == '3'):
    mainPage(user, db)
  elif(userAction == '2'):
    writeReview(user, db, recipe_id)
  else:
    viewReviewList(user, db, recipe_id)

def viewSearchResults(user, db, searchResults):
  if(len(searchResults) == 0):
    print("\n0 matching results. Returning to the main menu...")
    mainPage(user, db)
  else:
    validActions = ['q', 'Q']
    print("\nThe search results are as follows:")
    for recipeTuple in searchResults:
      recipe_id, recipe_name, contributed_by = recipeTuple
      validActions.append(str(recipe_id))
      print("Recipe ID: " + str(recipe_id) + "\tTitle: " + recipe_name + "\t\tContributed by: " + contributed_by)

    userAction = -1
    print("Please enter the recipe id of the recipe you wish to view. Enter 'q' to return to the main menu")
    while(userAction not in validActions):
      userAction = input()
      if(userAction not in validActions):
        print("Not a valid recipe_id. Please enter a recipe_id from the list above, or 'q' to go back to the main menu")
    
    if(userAction == 'q' or userAction == 'Q'):
      mainPage(user, db)
    else:
      viewRecipe(user, db, userAction)
      

def findRecipeByContributor(user, db):
  contributor = input("\nPlease enter a contributor to search by:\n")
  allRecipes = db.table("recipes")
  searchResults = allRecipes.getAll("recipe_id", "recipe_name", "contributor").where("contributor").eq(contributor).run()
  viewSearchResults(user, db, searchResults)


def findRecipeByIngredient(user, db):
  ingredient = input("\nPlease enter an ingredient to search by:\n")
  usesIngredient = db.table("uses_ingredients")
  recipes = db.table("recipes")
  recipe_ids = usesIngredient.getAll("associated_recipe_id").where("ingredient").eq(ingredient).run()

  searchResults = []
  for idTuple in recipe_ids:
    recipe_id = idTuple[0]
    tempResult = recipes.getAll("recipe_id", "recipe_name", "contributor").where("recipe_id").eq(recipe_id).run()
    searchResults.extend(tempResult)
  viewSearchResults(user, db, searchResults)
  

def findRecipeByAuthor(user, db):
  author = input("\nPlease enter an author to search by:\n")
  createdBy = db.table("created_by")
  recipes = db.table("recipes")
  recipe_ids = createdBy.getAll("associated_recipe_id").where("author").eq(author).run()

  searchResults = []
  for idTuple in recipe_ids:
    recipe_id = idTuple[0]
    tempResult = recipes.getAll("recipe_id", "recipe_name", "contributor").where("recipe_id").eq(recipe_id).run()
    searchResults.extend(tempResult)
  viewSearchResults(user, db, searchResults)

def findRecipeByCategory(user, db):
  category = input("\nPlease enter a food category to search by:\n")
  allRecipes = db.table("recipes")
  searchResults = allRecipes.getAll("recipe_id", "recipe_name", "contributor").where("category").eq(category).run()
  viewSearchResults(user, db, searchResults)
  

def findRecipeByComplexity(user, db):
  lowerLimit = -1
  print("\nPlease enter the lower end of the complexity rating: (Number between 1-10)\n")
  while(lowerLimit < 1 or lowerLimit > 10):
    lowerLimit = int(input())
    if(lowerLimit < 1 or lowerLimit > 10):
      print("Invalid lower complexity limit. Enter a number between 1 and 10")

  upperLimit = -1
  print("Please enter the upper end of the complexity rating: (Number between " + str(lowerLimit) + "-10)\n")
  while(upperLimit < lowerLimit or upperLimit > 10):
    upperLimit = int(input())
    if(upperLimit < lowerLimit or upperLimit > 10):
      print("Invalid upper complexity limit. Enter a number between " + str(lowerLimit) + " and 10")

  searchResults = []
  complexityForSearch = lowerLimit
  allRecipes = db.table("recipes")
  while(complexityForSearch <= upperLimit):
    tempResults = allRecipes.getAll("recipe_id", "recipe_name", "contributor").where("complexity").eq(complexityForSearch).run()
    searchResults.extend(tempResults)
    complexityForSearch = complexityForSearch + 1

  viewSearchResults(user, db, searchResults)


def findRecipe(user, db):
  print("\nWhich category would you like to search by?")
  validActions = ['1', '2', '3', '4', '5']
  userAction = '0'
  while(userAction not in validActions):
    userAction = input("Contributer: 1\nIngredient: 2\nAuthor: 3\nCategory: 4\nComplexity: 5\n")
    if(userAction not in validActions):
      print("Invalid input, try again")
    
  if (userAction == '1'):
    findRecipeByContributor(user, db)
  elif(userAction == '2'):
    findRecipeByIngredient(user, db)
  elif(userAction == '3'):
    findRecipeByAuthor(user, db)
  elif(userAction == '4'):
    findRecipeByCategory(user, db)
  elif(userAction == '5'):
    findRecipeByComplexity(user, db)


def mainPage(user, db):
  print("\n\n------COMP 3005 Recipe Database------")
  print("Hi " + user + ". What would you like to do?")
  validActions = ['1', '2', '3']
  userAction = '0'
  while(userAction not in validActions):
    userAction = input("Add recipe: 1\nFind recipe: 2\nLogout: 3\n")
    if(userAction not in validActions):
      print("Invalid input, try again")
      
  if(userAction == '1'):
    addRecipe(user, db)
  elif(userAction == '2'):
    findRecipe(user, db)
  elif(userAction == '3'):
    print("\nThank you for your time. Closing COMP 3005 Recipe Database.")
  

def usernameExists(userTable, username):
  allUsers = userTable.getAll("username").run()
  for nameTuple in allUsers:
    actual = nameTuple[0]
    if(actual == username):
      return True
  return False


def signIn(db):
  userTable = db.table("users")
  signedIn = False
  username = ''
  while(signedIn == False):
    username = input("\nPlease enter your username:\n")
    inputtedPassword = input("Please enter your password:\n")
    if(usernameExists(userTable, username)):
      realPassword = userTable.get("password").where("username").eq(username).run()
      if(inputtedPassword == realPassword):
        signedIn = True

    if(signedIn == False):
      print("Wrong username/password. Please try again.")
      
  print("You have been successfully signed in")
  mainPage(username, db)
  

def createAccount(db):
  userTable = db.table("users")
  uniqueUser = False
  username = ''
  while(uniqueUser == False):
      username = input("\nPlease enter a username:\n")
      password = input("Please enter a password:\n")

      if(not usernameExists(userTable, username)):
        userTable.add(username=username, password=password)
        uniqueUser = True
      if(uniqueUser == False):
        print("That username is already taken, please try again")
  
  print("An account has successfully been created")
  mainPage(username, db)


def welcome():
  print("Welcome to the COMP 3005 Recipe Database!")
  db = sqlitewrapper.open("recipes")
  userInput = 0
  while (True):
    userInput = input("Sign in: 1\nCreate an Account : 2\n")
    if(userInput == '1' or userInput == '2'):
      break
  if(userInput == '1'):
      signIn(db)
  else:
      createAccount(db)
welcome()
