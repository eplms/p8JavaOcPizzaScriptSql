
CREATE SEQUENCE public.pizza_id_seq;

CREATE TABLE public.pizza (
                id INTEGER NOT NULL DEFAULT nextval('public.pizza_id_seq'),
                nom VARCHAR(100) NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizza_id_seq OWNED BY public.pizza.id;

CREATE SEQUENCE public.ingredient_id_seq;

CREATE TABLE public.ingredient (
                id INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_seq'),
                nom VARCHAR(100) NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;

CREATE TABLE public.recette (
                id_ingredient INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                quantite INTEGER,
                CONSTRAINT recette_pk PRIMARY KEY (id_ingredient, id_pizza)
);


CREATE SEQUENCE public.adresse_id_seq;

CREATE TABLE public.adresse (
                id INTEGER NOT NULL DEFAULT nextval('public.adresse_id_seq'),
                numero_rue INTEGER NOT NULL,
                nom_rue VARCHAR(100) NOT NULL,
                code_postal INTEGER NOT NULL,
                commune VARCHAR(100) NOT NULL,
                mail VARCHAR(100) NOT NULL,
                numero_telephone INTEGER NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adresse_id_seq OWNED BY public.adresse.id;

CREATE SEQUENCE public.point_de_vente_id_seq;

CREATE TABLE public.point_de_vente (
                id INTEGER NOT NULL DEFAULT nextval('public.point_de_vente_id_seq'),
                nom VARCHAR(100) NOT NULL,
                id_adresse INTEGER NOT NULL,
                CONSTRAINT point_de_vente_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.point_de_vente_id_seq OWNED BY public.point_de_vente.id;

CREATE TABLE public.carte (
                id_point_de_vente INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                presence_carte BOOLEAN NOT NULL,
                CONSTRAINT carte_pk PRIMARY KEY (id_point_de_vente, id_pizza)
);


CREATE SEQUENCE public.employe_id_seq;

CREATE TABLE public.employe (
                id INTEGER NOT NULL DEFAULT nextval('public.employe_id_seq'),
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                identifiant VARCHAR(20) NOT NULL,
                password VARCHAR(15) NOT NULL,
                type_employe INTEGER NOT NULL,
                id_point_de_vente INTEGER NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.employe_id_seq OWNED BY public.employe.id;

CREATE TABLE public.ligne_stock (
                id_ingredient INTEGER NOT NULL,
                id_point_de_vente INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ligne_stock_pk PRIMARY KEY (id_ingredient, id_point_de_vente)
);


CREATE SEQUENCE public.client_id_seq;

CREATE TABLE public.client (
                id INTEGER NOT NULL DEFAULT nextval('public.client_id_seq'),
                identifiant VARCHAR(100) NOT NULL,
                password VARCHAR(15) NOT NULL,
                point_vente_reference INTEGER NOT NULL,
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                id_adresse INTEGER NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;

CREATE TABLE public.ligne_panier (
                id_pizza INTEGER NOT NULL,
                id_client INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ligne_panier_pk PRIMARY KEY (id_pizza, id_client)
);


CREATE SEQUENCE public.commande_numero_commande_seq;

CREATE TABLE public.commande (
                numero_commande INTEGER NOT NULL DEFAULT nextval('public.commande_numero_commande_seq'),
                statut_livraison INTEGER NOT NULL,
                statut_paiement BOOLEAN NOT NULL,
                mode_livraison INTEGER NOT NULL,
                mode_paiement INTEGER NOT NULL,
                date DATE NOT NULL,
                heure TIME NOT NULL,
                id_point_de_vente INTEGER NOT NULL,
                id_client INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (numero_commande)
);


ALTER SEQUENCE public.commande_numero_commande_seq OWNED BY public.commande.numero_commande;

CREATE TABLE public.ligne_commande (
                numero_commande INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                quantite INTEGER,
                CONSTRAINT ligne_commande_pk PRIMARY KEY (numero_commande, id_pizza)
);


CREATE TABLE public.affectation (
                numero_commande INTEGER NOT NULL,
                id_employe INTEGER NOT NULL,
                CONSTRAINT affectation_pk PRIMARY KEY (numero_commande, id_employe)
);


ALTER TABLE public.carte ADD CONSTRAINT pizza_carte_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_commande ADD CONSTRAINT pizza_ligne_commande_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_panier ADD CONSTRAINT pizza_ligne_panier_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_stock ADD CONSTRAINT ingredient_ligne_stock_fk
FOREIGN KEY (id_ingredient)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT ingredient_recette_fk
FOREIGN KEY (id_ingredient)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT adresse_client_fk
FOREIGN KEY (id_adresse)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.point_de_vente ADD CONSTRAINT adresse_point_de_vente_fk
FOREIGN KEY (id_adresse)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_stock ADD CONSTRAINT point_de_vente_ligne_stock_fk
FOREIGN KEY (id_point_de_vente)
REFERENCES public.point_de_vente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT point_de_vente_commande_fk
FOREIGN KEY (id_point_de_vente)
REFERENCES public.point_de_vente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT point_de_vente_employe_fk
FOREIGN KEY (id_point_de_vente)
REFERENCES public.point_de_vente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.carte ADD CONSTRAINT point_de_vente_carte_fk
FOREIGN KEY (id_point_de_vente)
REFERENCES public.point_de_vente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.affectation ADD CONSTRAINT employe_affectation_fk
FOREIGN KEY (id_employe)
REFERENCES public.employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_panier ADD CONSTRAINT client_ligne_panier_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.affectation ADD CONSTRAINT commande_affectation_fk
FOREIGN KEY (numero_commande)
REFERENCES public.commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_commande ADD CONSTRAINT commande_ligne_commande_fk
FOREIGN KEY (numero_commande)
REFERENCES public.commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
