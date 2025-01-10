-- Query for Bananas: See Banana Smoothie
-- Query for Cupcake
-- Query for Dessert

-- CAUTION: REMOVES OLD VERSION OF TABLES
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS created_by; -- Subsumed authors
DROP TABLE IF EXISTS uses_ingredients; -- Subsumed ingredients
DROP TABLE IF EXISTS reviews;

CREATE TABLE users(
    username text primary key not null,
    password text not null
);

INSERT INTO users VALUES('indecisive','abc');
INSERT INTO users VALUES('panda','abc');
INSERT INTO users VALUES('cupcake','abc');
INSERT INTO users VALUES('mango','abc');

CREATE TABLE recipes(
    recipe_id integer primary key AUTOINCREMENT not null,
    contributor text not null,
    recipe_name text not null,
    instructions text not null,
    prep_time text not null,
    category text not null,
    complexity integer not null
);

INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('panda','Banana Pancakes', 'To make banana pancakes, mash ripe bananas in a bowl, then mix them with eggs, flour, milk, and a pinch of baking powder until smooth. Heat a lightly greased skillet over medium heat, pour small amounts of batter, and cook until bubbles form on the surface, then flip and cook until golden. Serve warm with your favorite toppings like syrup, butter, or fresh fruit.', '20 minutes', 'Breakfast', 2);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('cupcake','Banana Smoothie', 'To make a banana smoothie, blend a ripe banana with milk or a non-dairy alternative, yogurt, and a sweetener like honey or sugar. Add ice cubes for a chilled texture and optional extras like vanilla, peanut butter, or a handful of oats for added flavor and nutrition. Blend until smooth, then pour into a glass and enjoy immediately.', '10 minutes', 'Drink', 4);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('cupcake','Banana Muffins', 'To make banana muffins, mash ripe bananas in a bowl and mix with wet ingredients like eggs, oil, and vanilla extract. In a separate bowl, combine dry ingredients such as flour, sugar, baking powder, and a pinch of salt, then gently fold them into the wet mixture. Scoop the batter into a muffin tin, bake at 350°F (175°C) for about 20 minutes, and let them cool before serving.', '45-60 minutes', 'Dessert', 5);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('cupcake','Banana Cream Pie', 'To make a banana cream pie, start by baking a pie crust or using a pre-made one, then layer it with sliced bananas. Cook a creamy custard by mixing milk, sugar, eggs, cornstarch, and vanilla on the stovetop until thickened, and pour it over the bananas. Chill the pie in the refrigerator, top with whipped cream, and garnish with more banana slices before serving.', '70-90 minutes', 'Dessert', 7);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('cupcake','Banana Pudding', 'To make banana pudding, layer sliced bananas and vanilla wafers in a dish. Prepare a creamy custard by heating milk, sugar, egg yolks, cornstarch, and vanilla, stirring until thickened, then pour it over the layers. Chill the pudding in the refrigerator, and top it with whipped cream or meringue before serving.', '1 hour', 'Dessert', 4);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('indecisive','Fruit Salad', 'To make a fruit salad with bananas, start by slicing bananas, strawberries, and grapes, and adding them to a large bowl. Peel and segment oranges or mandarins and mix them in, along with diced apples or kiwis for extra variety. Toss the fruits gently with a squeeze of lemon juice or honey for flavor, and serve chilled.', '5 minutes', 'Salad', 1);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('mango','Deep Fried Bananas', 'To make deep-fried bananas, slice ripe bananas into halves or thirds and coat them in a batter made from flour, sugar, milk, and a pinch of salt. Heat oil in a deep fryer or pan to around 350°F (175°C), then carefully fry the battered bananas until they are golden brown. Remove them from the oil, drain on paper towels, and serve warm, optionally with powdered sugar or a drizzle of honey.', '10 minutes', 'Dessert', 3);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('mango','Banana Smoothie', 'Blend ripe bananas, milk (or a dairy-free alternative), yogurt, and a touch of honey or sugar until smooth and creamy. Pour into a glass and enjoy your refreshing banana smoothie!', '5 minutes', 'Drink', 1);
INSERT INTO recipes (contributor, recipe_name, instructions, prep_time, category, complexity) VALUES('mango','Banana Bread', 'Preheat your oven and mix mashed ripe bananas, sugar, eggs, melted butter, and vanilla in a bowl. Combine flour, baking soda, and a pinch of salt, then fold the dry ingredients into the wet mixture until just combined. Pour the batter into a greased loaf pan and bake until golden brown and a toothpick comes out clean.', '70 minutes', 'Dessert', 8);

CREATE TABLE created_by(
    associated_recipe_id integer not null,
    author text not null,
    PRIMARY KEY(associated_recipe_id, author)
);

INSERT INTO created_by VALUES(1, 'Gordon Ramsay');
INSERT INTO created_by VALUES(2, 'Gordon Ramsay');
INSERT INTO created_by VALUES(2, 'Jamie Oliver');
INSERT INTO created_by VALUES(2, 'Julia Child');
INSERT INTO created_by VALUES(3, 'Julia Child');
INSERT INTO created_by VALUES(4, 'Jamie Oliver');
INSERT INTO created_by VALUES(5, 'Jamie Oliver');
INSERT INTO created_by VALUES(5, 'Julia Child');
INSERT INTO created_by VALUES(6, 'Jamie Oliver');
INSERT INTO created_by VALUES(7, 'Julia Child');
INSERT INTO created_by VALUES(8, 'Jamie Oliver');
INSERT INTO created_by VALUES(8, 'Gordon Ramsay');
INSERT INTO created_by VALUES(9, 'Gordon Ramsay');
INSERT INTO created_by VALUES(9, 'Julia Child');

CREATE TABLE uses_ingredients(
    associated_recipe_id integer not null,
    ingredient text not null,
    PRIMARY KEY(associated_recipe_id, ingredient)
);

INSERT INTO uses_ingredients VALUES(1, 'Banana');
INSERT INTO uses_ingredients VALUES(1, 'Egg');
INSERT INTO uses_ingredients VALUES(1, 'Flour');
INSERT INTO uses_ingredients VALUES(1, 'Milk');
INSERT INTO uses_ingredients VALUES(1, 'Baking Soda');
INSERT INTO uses_ingredients VALUES(1, 'Butter');
INSERT INTO uses_ingredients VALUES(1, 'Maple Syrup');
INSERT INTO uses_ingredients VALUES(2, 'Banana');
INSERT INTO uses_ingredients VALUES(2, 'Milk');
INSERT INTO uses_ingredients VALUES(2, 'Yogurt');
INSERT INTO uses_ingredients VALUES(2, 'Honey');
INSERT INTO uses_ingredients VALUES(2, 'Sugar');
INSERT INTO uses_ingredients VALUES(2, 'Ice Cubes');
INSERT INTO uses_ingredients VALUES(2, 'Vanilla');
INSERT INTO uses_ingredients VALUES(2, 'Oat');
INSERT INTO uses_ingredients VALUES(2, 'Peanut Butter');
INSERT INTO uses_ingredients VALUES(3, 'Banana');
INSERT INTO uses_ingredients VALUES(3, 'Egg');
INSERT INTO uses_ingredients VALUES(3, 'Oil');
INSERT INTO uses_ingredients VALUES(3, 'Vanilla');
INSERT INTO uses_ingredients VALUES(3, 'Flour');
INSERT INTO uses_ingredients VALUES(3, 'Sugar');
INSERT INTO uses_ingredients VALUES(3, 'Baking Powder');
INSERT INTO uses_ingredients VALUES(3, 'Salt');
INSERT INTO uses_ingredients VALUES(4, 'Banana');
INSERT INTO uses_ingredients VALUES(4, 'Milk');
INSERT INTO uses_ingredients VALUES(4, 'Sugar');
INSERT INTO uses_ingredients VALUES(4, 'Egg');
INSERT INTO uses_ingredients VALUES(4, 'Cornstarch');
INSERT INTO uses_ingredients VALUES(4, 'Vanilla');
INSERT INTO uses_ingredients VALUES(4, 'Whipped Cream');
INSERT INTO uses_ingredients VALUES(5, 'Banana');
INSERT INTO uses_ingredients VALUES(5, 'Vanilla Wafers');
INSERT INTO uses_ingredients VALUES(5, 'Milk');
INSERT INTO uses_ingredients VALUES(5, 'Sugar');
INSERT INTO uses_ingredients VALUES(5, 'Egg');
INSERT INTO uses_ingredients VALUES(5, 'Conrstarch');
INSERT INTO uses_ingredients VALUES(5, 'Vanilla');
INSERT INTO uses_ingredients VALUES(5, 'Whipped Cream');
INSERT INTO uses_ingredients VALUES(6, 'Banana');
INSERT INTO uses_ingredients VALUES(6, 'Strawberry');
INSERT INTO uses_ingredients VALUES(6, 'Grape');
INSERT INTO uses_ingredients VALUES(6, 'Orange');
INSERT INTO uses_ingredients VALUES(6, 'Mandarin');
INSERT INTO uses_ingredients VALUES(6, 'Apple');
INSERT INTO uses_ingredients VALUES(6, 'Kiwi');
INSERT INTO uses_ingredients VALUES(6, 'Lemon Juice');
INSERT INTO uses_ingredients VALUES(6, 'Honey');
INSERT INTO uses_ingredients VALUES(7, 'Banana');
INSERT INTO uses_ingredients VALUES(7, 'Flour');
INSERT INTO uses_ingredients VALUES(7, 'Sugar');
INSERT INTO uses_ingredients VALUES(7, 'Milk');
INSERT INTO uses_ingredients VALUES(7, 'Salt');
INSERT INTO uses_ingredients VALUES(7, 'Oil');
INSERT INTO uses_ingredients VALUES(8, 'Banana');
INSERT INTO uses_ingredients VALUES(8, 'Milk');
INSERT INTO uses_ingredients VALUES(8, 'Yogurt');
INSERT INTO uses_ingredients VALUES(8, 'Honey');
INSERT INTO uses_ingredients VALUES(8, 'Sugar');
INSERT INTO uses_ingredients VALUES(9, 'Banana');
INSERT INTO uses_ingredients VALUES(9, 'Sugar');
INSERT INTO uses_ingredients VALUES(9, 'Egg');
INSERT INTO uses_ingredients VALUES(9, 'Salt');
INSERT INTO uses_ingredients VALUES(9, 'Butter');
INSERT INTO uses_ingredients VALUES(9, 'Vanilla');
INSERT INTO uses_ingredients VALUES(9, 'Flour');
INSERT INTO uses_ingredients VALUES(9, 'Baking Soda');

CREATE TABLE reviews(
    associated_recipe_id integer not null,
    reviewer text not null,
    score int not null,
    comments text not null,
    PRIMARY KEY(associated_recipe_id, reviewer)
);

INSERT INTO reviews VALUES(2, 'mango', 10, 'This banana smoothie is smooth, creamy, and perfectly sweet with the natural flavor of ripe bananas. It is a refreshing and healthy treat that is easy to make and packed with nutrients.');
INSERT INTO reviews VALUES(2, 'panda', 4, 'The banana smoothie lacked flavor and was too thin, making it feel more like a watered-down drink than a satisfying treat. Despite the banana base, the taste was underwhelming and not as refreshing as expected.');
INSERT INTO reviews VALUES(9, 'panda', 9, 'The banana bread was moist and packed with rich, sweet banana flavor, making each bite incredibly satisfying. The texture was perfect, with a light, fluffy crumb that was not too dense or heavy. However, it could have used a bit more spice or nuts to elevate the taste and add some extra crunch.');
INSERT INTO reviews VALUES(9, 'cupcake', 7, 'The banana bread had a pleasant banana flavor and a soft, moist texture. It was easy to make and enjoyed by most, though it could have been a bit sweeter or more flavorful. Overall, it is a decent recipe, but could benefit from a few tweaks to make it stand out more.');
