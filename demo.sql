use pizzeria;

DROP PROCEDURE produit_par_categorie_depuis_pizzeria;
DELIMITER |
CREATE PROCEDURE produit_par_categorie_depuis_pizzeria(in p_pizzeria_id smallint unsigned, in p_categorie_texte  varchar(45))
BEGIN
	select Pizzeria.nom,
    Produit.nom as Produit,
	group_concat(Ingredient.texte separator ', ') as ingredients,
    INSTR(group_concat(Pizzeria_Ingredient.stock separator ''), 0) as not_stock,
	Produit.prix_unitaire
    from Produit
    
    inner join Categorie on Produit.Categorie_id = Categorie.idCategorie
    
    inner join Ingredient_Produit on  Produit.idProduit = Ingredient_Produit.Produit_id
    inner join Ingredient on Ingredient_Produit.Ingredient_id = Ingredient.idIngredient
    
    inner join Pizzeria_Ingredient on Ingredient.idIngredient = Pizzeria_Ingredient.Ingredient_id
    inner join Pizzeria on Pizzeria_Ingredient.Pizzeria_id = Pizzeria.idPizzeria 
    
    where Pizzeria.idPizzeria = p_pizzeria_id
              and Categorie.texte = p_categorie_texte
	group by Produit.idProduit
    having not_stock = 0;
END|
DELIMITER ;

DROP PROCEDURE inverse_stock_ingredient_depuis_pizzeria;
DELIMITER |
CREATE PROCEDURE inverse_stock_ingredient_depuis_pizzeria(in p_pizzeria_id smallint unsigned, in p_ingredient_texte varchar(200))
BEGIN
	DECLARE stock_boolean tinyint(1);
	
	SELECT stock INTO stock_boolean
	FROM Pizzeria_Ingredient
	INNER JOIN Ingredient ON Pizzeria_Ingredient.Ingredient_id = Ingredient.idIngredient
	WHERE Ingredient.texte = p_ingredient_texte AND Pizzeria_Ingredient.Pizzeria_id = p_pizzeria_id;
	
	IF stock_boolean = 0 THEN
		UPDATE Pizzeria_Ingredient
		INNER JOIN Ingredient ON Pizzeria_Ingredient.Ingredient_id = Ingredient.idIngredient
		SET stock = 1
		WHERE Ingredient.texte = p_ingredient_texte AND Pizzeria_Ingredient.Pizzeria_id = p_pizzeria_id;
		SELECT 'Ajouté dans le stock.';
	ELSEIF stock_boolean = 1 THEN
		UPDATE Pizzeria_Ingredient
		INNER JOIN Ingredient ON Pizzeria_Ingredient.Ingredient_id = Ingredient.idIngredient
		SET stock = 0
		WHERE Ingredient.texte = p_ingredient_texte AND Pizzeria_Ingredient.Pizzeria_id = p_pizzeria_id;
		SELECT 'Retiré du stock.';
	END IF;
END|
DELIMITER ;

DROP PROCEDURE create_TMPtable_commandes_par_pizzerias;
DELIMITER |
CREATE PROCEDURE create_TMPtable_commandes_par_pizzerias()
BEGIN
DROP TEMPORARY TABLE IF EXISTS TMP_commandes_par_pizzerias;

CREATE TEMPORARY TABLE TMP_commandes_par_pizzerias
SELECT GROUP_CONCAT(distinct union_.idPizzeria) as idPizzeria,
			   GROUP_CONCAT(distinct union_.nom) as pizzeria,
               GROUP_CONCAT(distinct union_.idCommande) as idCommande,
			   GROUP_CONCAT(distinct union_.date) as date,
               GROUP_CONCAT(distinct union_.statut) as statut,
			   GROUP_CONCAT(union_.produits SEPARATOR ', ') as produits, 
			   SUM(union_.prix) as prix FROM
	(SELECT Pizzeria.idPizzeria, Pizzeria.nom, Commande.idCommande as idCommande, Commande.statut, Commande.date,
				   GROUP_CONCAT(CONCAT(Produit_Commande.quantité, '-', Produit_Direct.nom) SEPARATOR ';') as produits,
                   SUM(Produit_Commande.quantité * Produit_Direct.prix_unitaire) as prix
    FROM Commande
    
    INNER JOIN Pizzeria on Pizzeria.idPizzeria = Commande.Pizzeria_id
    
    LEFT JOIN Produit_Commande on Produit_Commande.Commande_id = Commande.idCommande
    LEFT JOIN Produit as Produit_Direct on Produit_Commande.Produit_id = Produit_Direct.idProduit
	
    GROUP BY Commande.idCommande
    UNION
	SELECT Pizzeria.idPizzeria, Pizzeria.nom, Commande.idCommande as idCommande, Commande.statut, Commande.date,
				   CONCAT(Menu.nom, '(', GROUP_CONCAT(CONCAT(Commande_Menu_Produit.quantité, '-', Produit_Indirect.nom) SEPARATOR ';'), ')')as produits,
                   Menu.prix_unitaire as prix
    FROM Commande
	
    INNER JOIN Pizzeria on Pizzeria.idPizzeria = Commande.Pizzeria_id
    
	LEFT JOIN Commande_Menu on Commande.idCommande = Commande_Menu.Commande_id
    
	LEFT JOIN Commande_Menu_Produit on Commande_Menu.idCommandeMenu = Commande_Menu_Produit.Commande_Menu_id
    LEFT JOIN Produit as Produit_Indirect on Commande_Menu_Produit.Produit_id = Produit_Indirect.idProduit
    
	LEFT JOIN Menu on Commande_Menu.Menu_id = Menu.idMenu

    GROUP BY Commande.idCommande, Commande_Menu.idCommandeMenu) as union_
    GROUP BY union_.idCommande;
END|
DELIMITER ;

DROP PROCEDURE commandes_par_pizzeria;
DELIMITER |
CREATE PROCEDURE commandes_par_pizzeria(in p_pizzeria_id smallint unsigned)
BEGIN
	SELECT *
    FROM TMP_commandes_par_pizzerias
    WHERE idPizzeria = p_pizzeria_id;
END|
DELIMITER ;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

DROP PROCEDURE chiffre_affaire;
DELIMITER |
CREATE PROCEDURE chiffre_affaire()
BEGIN
SELECT COALESCE(sous_select.pizzeria, 'Total') as pizzeria,
			   COALESCE(sous_select.date, 'Total') as date,
               sous_select.chiffre_affaire as chiffre_affaire
 FROM (
	SELECT pizzeria, DATE(date) as date, SUM(prix) as chiffre_affaire
    FROM TMP_commandes_par_pizzerias
    WHERE MONTH(date) = 11 AND YEAR(date) = 2018
    GROUP BY pizzeria, DATE(date) with rollup) 
as sous_select;
END|
DELIMITER ;

DROP PROCEDURE menus_detail;
DELIMITER |
CREATE PROCEDURE menus_detail()
BEGIN
SELECT Menu.idMenu, Menu.nom, Menu.prix_unitaire, GROUP_CONCAT(CONCAT(Categorie_Menu.quantité, '-', Categorie.texte) SEPARATOR ';') as Composition
FROM Menu
INNER JOIN Categorie_Menu on Categorie_Menu.Menu_id = Menu.idMenu
INNER JOIN Categorie on Categorie_Menu.Categorie_id = Categorie.idCategorie
GROUP BY Menu.idMenu;
END|
DELIMITER ;

call menus_detail();
call produit_par_categorie_depuis_pizzeria(1, 'entree');
call produit_par_categorie_depuis_pizzeria(1, 'pizza');
call inverse_stock_ingredient_depuis_pizzeria(1, 'merguez');
call produit_par_categorie_depuis_pizzeria(1, 'pizza');

call create_TMPtable_commandes_par_pizzerias();
call commandes_par_pizzeria(1);
call commandes_par_pizzeria(2);
call chiffre_affaire();