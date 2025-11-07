CREATE DATABASE vendicosetest;
USE vendicosetest;
                            /*popolato e creato le tabelle tramite navicat17*/
 CREATE TABLE categoria  (
  id_categoria int NOT NULL AUTO_INCREMENT,
  nome_categoria varchar(100) NOT NULL,
  soglia_restock int NOT NULL,
  PRIMARY KEY (id_categoria)
);

INSERT INTO categoria
VALUES 	(1, 'alimentari', 50),
		(2, 'casalinghi', 20),
		(3, 'detersivi', 25),
		(4, 'igiene_personale', 35),
		(5, 'pet', 10),
		(6, 'ittici', 5),
		(7, 'giardinaggio', 10),
		(8, 'bibite', 40),
		(9, 'alcool', 35),
		(10, 'surgelati', 60);
        
CREATE TABLE magazzino  (
  id_magazzino int NOT NULL AUTO_INCREMENT,
  luogo varchar(100) NOT NULL,
  PRIMARY KEY (id_magazzino)
  );

INSERT INTO magazzino
VALUES 	(1, 'NORD'),
		(2, 'CENTRO'),
		(3, 'SUD'),
		(4, 'SARDEGNA'),
		(5, 'SICILIA');
        
SELECT * FROM magazzino;

CREATE TABLE prodotto  (
  id_prodotto int NOT NULL AUTO_INCREMENT,
  nome_prodotto varchar(100) NOT NULL,
  id_categoria int NOT NULL,
  prezzo decimal(10, 2) NOT NULL,
  PRIMARY KEY (id_prodotto),
  INDEX fk_prodotto_categoria(id_categoria ASC),
  CONSTRAINT fk_prodotto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

INSERT INTO prodotto
VALUES 	 (1, 'Pasta Integrale', 1, 1.99),
		 (2, 'Riso Arborio 1kg', 1, 2.39),
		 (3, 'Olio Extravergine d\'Oliva 1L', 1, 6.49),
		 (4, 'Pane Integrale 500g', 1, 1.59),
		 (5, 'Biscotti Frollini 400g', 1, 2.19),
		 (6, 'Farina 00 1kg', 1, 1.09),
		 (7, 'Zucchero Semolato 1kg', 1, 1.25),
		 (8, 'Latte Intero 1L', 1, 1.49),
		 (9, 'Passata di Pomodoro 700ml', 1, 1.89),
		 (10, 'Tonno in Scatola 3x80g', 1, 3.45),
		 (11, 'Spugne Abrasive 3pz', 2, 1.99),
		 (12, 'Carta da Cucina 2 rotoli', 2, 2.49),
		 (13, 'Sacchetti Raccolta Differenziata 20pz', 2, 3.10),
		 (14, 'Lampadina LED 10W', 2, 4.29),
		 (15, 'Piatti di Plastica 25pz', 2, 1.89),
		 (16, 'Tovaglioli 100pz', 2, 1.79),
		 (17, 'Stoviglie Monouso Eco 10pz', 2, 2.69),
		 (18, 'Guanti Multiuso Lattice', 2, 3.59),
		 (19, 'Scopa con Manico', 2, 7.89),
		 (20, 'Secchio Mop', 2, 9.49),
		 (21, 'Detersivo Piatti 1L', 3, 2.99),
		 (22, 'Ammorbidente Lavatrice 2L', 3, 3.79),
		 (23, 'Detersivo Bucato 25 lavaggi', 3, 6.49),
		 (24, 'Sgrassatore Universale 750ml', 3, 2.89),
		 (25, 'Smacchiatore Tessuti 500ml', 3, 3.95),
		 (26, 'Detergente Bagno 700ml', 3, 2.75),
		 (27, 'Detergente Pavimenti 1L', 3, 2.59),
		 (28, 'Candeggina Classica 1L', 3, 1.45),
		 (29, 'Rimuovi Calcare 500ml', 3, 2.99),
		 (30, 'Lucidante Mobili 400ml', 3, 3.29),
		 (31, 'Shampoo Nutriente 300ml', 4, 3.79),
		 (32, 'Bagnoschiuma Neutro 500ml', 4, 2.99),
		 (33, 'Docciaschiuma Aloe Vera 400ml', 4, 3.29),
		 (34, 'Deodorante Uomo 150ml', 4, 3.49),
		 (35, 'Crema Idratante Viso 50ml', 4, 6.90),
		 (36, 'Sapone Liquido Mani 500ml', 4, 1.99),
		 (37, 'Spazzolino Medio', 4, 1.89),
		 (38, 'Dentifricio Sbiancante 75ml', 4, 2.49),
		 (39, 'Salviettine Struccanti 20pz', 4, 2.79),
		 (40, 'Lacca per Capelli 250ml', 4, 4.59),
		 (41, 'Crocchette per Cani Manzo 3kg', 5, 8.99),
		 (42, 'Crocchette per Gatti Pesce 2kg', 5, 7.79),
		 (43, 'Snack per Cani Bastoncini 10pz', 5, 3.19),
		 (44, 'Sabbia per Gatti 10L', 5, 6.49),
		 (45, 'Scatoletta Gatto Pollo 85g', 5, 0.89),
		 (46, 'Shampoo per Cani 250ml', 5, 4.29),
		 (47, 'Gioco Morbido per Cani', 5, 5.99),
		 (48, 'Guinzaglio Nylon Medio', 5, 6.90),
		 (49, 'Spazzola Toelettatura', 5, 7.49),
		 (50, 'Snack Dentali per Gatti 60g', 5, 2.09),
		 (51, 'Salmone Fresco 300g', 6, 7.29),
		 (52, 'Filetto di Merluzzo 400g', 6, 8.45),
		 (53, 'Polpo Pulito 1kg', 6, 14.90),
		 (54, 'Gamberi Argentina 500g', 6, 9.99),
		 (55, 'Acciughe Sott\'Olio 200g', 6, 4.79),
		 (56, 'Salmone Affumicato 200g', 6, 6.99),
		 (57, 'Cozze Pulite 1kg', 6, 4.29),
		 (58, 'Vongole Veraci 500g', 6, 7.10),
		 (59, 'Tonno Fresco Trancio 250g', 6, 6.59),
		 (60, 'Sardine in Olio 120g', 6, 2.89),
		 (61, 'Terra Universale 10L', 7, 4.39),
		 (62, 'Rastrello da Giardino', 7, 6.99),
		 (63, 'Guanti da Giardinaggio', 7, 3.79),
		 (64, 'Concime Universale 1kg', 7, 5.49),
		 (65, 'Semi Erba Prato 500g', 7, 6.29),
		 (66, 'Secchio Innaffiatoio 5L', 7, 7.99),
		 (67, 'Tagliabordi Manuale', 7, 12.90),
		 (68, 'Annaffiatoio Piccolo', 7, 4.10),
		 (69, 'Vaso Terracotta 20cm', 7, 3.95),
		 (70, 'Semi Basilico', 7, 2.15),
		 (71, 'Acqua Naturale 6x1.5L', 8, 3.19),
		 (72, 'Cola 1.5L', 8, 1.89),
		 (73, 'Aranciata 1.5L', 8, 1.69),
		 (74, 'Succo Mela 1L', 8, 2.29),
		 (75, 'Tè Freddo Pesca 1.5L', 8, 1.79),
		 (76, 'Bevanda Isotonica 500ml', 8, 2.49),
		 (77, 'Acqua Frizzante 6x1.5L', 8, 3.29),
		 (78, 'Succhi Mix Frutta 3x200ml', 8, 2.10),
		 (79, 'Limonata 1.5L', 8, 1.69),
		 (80, 'Bevanda Energetica 250ml', 8, 1.99),
		 (81, 'Vino Rosso Chianti 750ml', 9, 7.90),
		 (82, 'Vino Bianco Pinot 750ml', 9, 6.49),
		 (83, 'Birra Lager 33cl', 9, 1.59),
		 (84, 'Birra Artigianale IPA 50cl', 9, 3.79),
		 (85, 'Whisky Scozzese 70cl', 9, 24.90),
		 (86, 'Vodka Premium 1L', 9, 18.50),
		 (87, 'Rum Scuro 70cl', 9, 14.90),
		 (88, 'Spumante Brut 750ml', 9, 8.49),
		 (89, 'Amaro Digestivo 1L', 9, 12.90),
		 (90, 'Liquore al Caffè 70cl', 9, 10.99),
		 (91, 'Spinaci Surgelati 1kg', 10, 2.99),
		 (92, 'Patatine Fritte Surgelate 1kg', 10, 3.29),
		 (93, 'Minestrone Surgelato 1kg', 10, 2.79),
		 (94, 'Piselli Surgelati 750g', 10, 2.49),
		 (95, 'Filetti di Platessa Surgelati 400g', 10, 6.99),
		 (96, 'Pizza Margherita Surgelata 350g', 10, 3.49),
		 (97, 'Cornetti Surgelati 6pz', 10, 3.59),
		 (98, 'Gelato Vaniglia 500ml', 10, 4.19),
		 (99, 'Lasagne al Ragù Surgelate 400g', 10, 5.49),
		 (100, 'Torta Gelato 1L', 10, 6.59);

CREATE TABLE giacenza  (
  id_prodotto int NOT NULL,
  id_categoria int NOT NULL,
  id_magazzino int NOT NULL,
  giacenza int NOT NULL,
  CONSTRAINT fk_giacenza_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria),
  CONSTRAINT fk_giacenza_magazzino FOREIGN KEY (id_magazzino) REFERENCES magazzino (id_magazzino),
  CONSTRAINT fk_giacenza_prodotto FOREIGN KEY (id_prodotto) REFERENCES prodotto (id_prodotto)
) ;

INSERT INTO giacenza
VALUES 	(53, 9, 2, 112),
		(9, 4, 3, 434),
		(23, 9, 2, 818),
		(19, 8, 4, 61),
		(99, 7, 4, 74),
		(32, 2, 1, 570),
		(7, 2, 5, 381),
		(14, 4, 4, 855),
		(47, 6, 3, 326),
		(5, 1, 2, 513),
		(56, 3, 5, 789),
		(19, 2, 2, 70),
		(8, 4, 5, 504),
		(28, 6, 1, 487),
		(74, 10, 4, 2),
		(61, 4, 3, 933),
		(6, 4, 1, 500),
		(93, 3, 4, 299),
		(15, 1, 5, 350),
		(45, 2, 5, 654),
		(59, 8, 2, 630),
		(40, 3, 1, 902),
		(7, 5, 2, 816),
		(3, 7, 1, 483),
		(27, 1, 5, 610),
		(4, 1, 1, 226),
		(12, 9, 5, 293),
		(37, 4, 3, 81),
		(22, 5, 4, 19),
		(23, 10, 4, 93),
		(61, 3, 3, 666),
		(85, 9, 5, 474),
		(53, 1, 1, 947),
		(78, 5, 5, 878),
		(62, 3, 2, 210),
		(12, 7, 1, 717),
		(8, 3, 4, 206),
		(93, 5, 2, 181),
		(93, 2, 1, 888),
		(60, 9, 1, 4),
		(28, 9, 4, 300),
		(50, 6, 2, 676),
		(84, 3, 3, 75),
		(97, 8, 2, 239),
		(89, 10, 5, 496),
		(14, 6, 2, 486),
		(77, 3, 5, 215),
		(11, 5, 4, 927),
		(8, 6, 3, 333),
		(78, 10, 2, 208),
		(16, 2, 3, 618),
		(93, 3, 5, 821),
		(17, 9, 3, 555),
		(63, 6, 1, 646),
		(92, 6, 4, 753),
		(24, 5, 5, 718),
		(92, 6, 5, 793),
		(10, 7, 4, 272),
		(11, 1, 3, 916),
		(72, 1, 5, 857),
		(35, 1, 1, 871),
		(8, 2, 5, 628),
		(72, 3, 5, 174),
		(27, 7, 3, 168),
		(92, 5, 5, 635),
		(40, 5, 5, 117),
		(22, 9, 1, 936),
		(51, 1, 5, 476),
		(70, 2, 2, 596),
		(33, 9, 5, 69),
		(12, 4, 2, 493),
		(3, 3, 5, 621),
		(45, 1, 4, 985),
		(24, 10, 5, 795),
		(45, 3, 3, 412),
		(45, 5, 4, 873),
		(44, 9, 4, 879),
		(58, 6, 2, 750),
		(32, 10, 5, 650),
		(53, 8, 3, 164),
		(93, 8, 1, 885),
		(32, 9, 1, 3),
		(95, 3, 1, 949),
		(98, 2, 5, 867),
		(58, 6, 1, 527),
		(67, 5, 5, 773),
		(95, 5, 2, 405),
		(43, 9, 2, 30),
		(23, 9, 2, 168),
		(95, 8, 5, 843),
		(23, 7, 3, 207),
		(81, 6, 1, 713),
		(81, 10, 2, 289),
		(32, 9, 1, 888),
		(59, 8, 2, 548),
		(54, 10, 2, 824),
		(30, 3, 5, 95),
		(72, 1, 3, 578),
		(93, 4, 2, 53),
		(93, 1, 3, 602),
		(71, 8, 3, 643),
		(99, 4, 2, 91),
		(43, 2, 3, 499),
		(15, 4, 1, 612),
		(69, 10, 4, 836),
		(53, 3, 3, 204),
		(48, 2, 4, 582),
		(64, 8, 2, 801),
		(71, 4, 3, 422),
		(48, 5, 1, 848),
		(35, 3, 4, 265),
		(25, 9, 3, 942),
		(87, 6, 3, 795),
		(10, 6, 4, 546),
		(43, 10, 2, 426),
		(32, 4, 2, 822),
		(81, 7, 1, 434),
		(40, 6, 5, 615),
		(8, 10, 3, 59),
		(18, 2, 3, 409),
		(81, 2, 1, 558),
		(22, 9, 2, 566),
		(48, 7, 4, 357),
		(55, 3, 5, 652),
		(47, 3, 4, 250),
		(78, 6, 2, 38),
		(82, 7, 4, 704),
		(78, 2, 2, 289),
		(36, 7, 3, 25),
		(67, 6, 1, 826),
		(11, 7, 5, 252),
		(16, 5, 5, 163),
		(15, 2, 2, 336),
		(45, 1, 5, 345),
		(47, 3, 1, 522),
		(47, 4, 2, 726),
		(25, 10, 3, 81),
		(74, 5, 1, 93),
		(85, 10, 4, 280),
		(51, 9, 2, 846),
		(100, 4, 2, 16),
		(22, 3, 4, 200),
		(75, 2, 3, 204),
		(10, 6, 5, 885),
		(84, 1, 2, 839),
		(38, 2, 2, 234),
		(79, 4, 4, 443),
		(92, 1, 1, 731),
		(35, 9, 3, 550),
		(78, 2, 2, 484),
		(36, 2, 5, 870),
		(82, 6, 2, 850),
		(16, 9, 3, 482),
		(22, 6, 2, 932),
		(64, 6, 4, 929),
		(11, 1, 2, 568),
		(38, 4, 5, 912),
		(10, 3, 1, 395),
		(80, 3, 1, 154),
		(99, 10, 4, 12),
		(54, 4, 4, 979),
		(5, 9, 5, 417),
		(94, 4, 5, 576),
		(98, 4, 4, 49),
		(40, 3, 5, 803),
		(9, 9, 2, 517),
		(24, 9, 5, 983),
		(55, 8, 3, 830),
		(37, 4, 3, 744),
		(33, 6, 4, 323),
		(89, 3, 2, 549),
		(18, 9, 1, 736),
		(7, 1, 3, 450),
		(2, 2, 3, 701),
		(41, 10, 2, 199),
		(88, 1, 4, 825),
		(91, 2, 1, 830),
		(62, 10, 2, 500),
		(51, 8, 1, 398),
		(66, 9, 2, 453),
		(58, 4, 1, 855),
		(59, 3, 1, 779),
		(23, 8, 3, 735),
		(70, 10, 3, 365),
		(42, 8, 1, 810),
		(94, 7, 1, 938),
		(29, 1, 3, 660),
		(97, 1, 1, 22),
		(34, 9, 1, 972),
		(45, 1, 3, 647),
		(81, 8, 5, 575),
		(48, 7, 2, 500),
		(56, 5, 4, 366),
		(26, 7, 3, 43),
		(5, 9, 3, 78),
		(97, 1, 5, 725),
		(36, 5, 5, 700),
		(16, 10, 2, 894),
		(15, 10, 3, 700),
		(50, 8, 5, 485);

CREATE TABLE negozio  (
  id_negozio int NOT NULL AUTO_INCREMENT,
  id_magazzino int NOT NULL,
  luogo varchar(100) NOT NULL,
  PRIMARY KEY (id_negozio),
  CONSTRAINT fk_negozio_magazzino FOREIGN KEY (id_magazzino) REFERENCES magazzino (id_magazzino)
  );

INSERT INTO negozio
VALUES 	(1, 4, 'Sassari'),
		(2, 1, 'Torino'),
		(3, 1, 'Milano'),
		(4, 1, 'Pordenone'),
		(5, 5, 'Catania'),
		(6, 2, 'Firenze'),
		(7, 2, 'Cesena'),
		(8, 5, 'Palermo'),
		(9, 1, 'Udine'),
		(10, 2, 'Perugia'),
		(11, 4, 'Cagliari'),
		(12, 1, 'Genova'),
		(13, 5, 'Siracusa'),
		(14, 1, 'Bergamo'),
		(15, 1, 'Brescia'),
		(16, 5, 'Agrigento'),
		(17, 3, 'Napoli'),
		(18, 1, 'Venezia'),
		(19, 3, 'Potenza'),
		(21, 5, 'Messina');

CREATE TABLE vendita  (
  id_vendita int NOT NULL AUTO_INCREMENT,
  id_dettaglio int NOT NULL,
  id_negozio int NOT NULL,
  id_prodotto int NOT NULL,
  qta int NOT NULL,
  totale_vendita decimal(10, 2) NOT NULL,
  PRIMARY KEY (id_vendita),
  CONSTRAINT fk_vendita_negozio FOREIGN KEY (id_negozio) REFERENCES negozio (id_negozio),
  CONSTRAINT fk_vendita_prodotto FOREIGN KEY (id_prodotto) REFERENCES prodotto (id_prodotto)
);

INSERT INTO vendita
VALUES 	(1, 101, 1, 3, 5, 32.45),
		(2, 102, 2, 8, 3, 4.47),
		(3, 103, 3, 10, 4, 13.80),
		(4, 104, 4, 12, 6, 14.94),
		(5, 105, 5, 17, 2, 5.38),
		(6, 106, 6, 21, 3, 8.97),
		(7, 107, 7, 25, 2, 7.90),
		(8, 108, 8, 32, 5, 14.95),
		(9, 109, 9, 37, 4, 7.56),
		(10, 110, 10, 41, 3, 26.97),
		(11, 111, 11, 45, 6, 5.34),
		(12, 112, 12, 46, 3, 12.87),
		(13, 113, 13, 50, 4, 8.36),
		(14, 114, 14, 54, 2, 19.98),
		(15, 115, 15, 57, 6, 25.74),
		(16, 116, 16, 60, 5, 14.45),
		(17, 117, 17, 63, 4, 15.16),
		(18, 118, 18, 67, 2, 25.80),
		(19, 119, 19, 71, 8, 25.52),
		(20, 120, 21, 75, 4, 7.16),
		(21, 121, 1, 77, 3, 9.87),
		(22, 122, 2, 80, 5, 9.95),
		(23, 123, 3, 83, 6, 9.54),
		(24, 124, 4, 84, 2, 7.58),
		(25, 125, 5, 85, 1, 24.90),
		(26, 126, 6, 86, 2, 37.00),
		(27, 127, 7, 88, 4, 33.96),
		(28, 128, 8, 89, 3, 38.70),
		(29, 129, 9, 90, 5, 54.95),
		(30, 130, 10, 91, 3, 8.97),
		(31, 131, 11, 92, 2, 6.58),
		(32, 132, 12, 93, 5, 13.95),
		(33, 133, 13, 94, 4, 9.96),
		(34, 134, 14, 95, 1, 6.99),
		(35, 135, 15, 96, 2, 6.98),
		(36, 136, 16, 97, 4, 14.36),
		(37, 137, 17, 98, 3, 12.57),
		(38, 138, 18, 99, 6, 32.94),
		(39, 139, 19, 100, 3, 19.77),
		(40, 140, 21, 2, 10, 23.90),
		(41, 141, 1, 5, 5, 10.95),
		(42, 142, 2, 6, 8, 8.72),
		(43, 143, 3, 7, 6, 7.50),
		(44, 144, 4, 8, 3, 4.47),
		(45, 145, 5, 9, 7, 13.23),
		(46, 146, 6, 10, 3, 10.35),
		(47, 147, 7, 11, 4, 7.96),
		(48, 148, 8, 13, 5, 15.50),
		(49, 149, 9, 14, 2, 8.58),
		(50, 150, 10, 15, 6, 11.34),
		(51, 151, 11, 16, 7, 12.53),
		(52, 152, 12, 17, 3, 8.07),
		(53, 153, 13, 18, 2, 7.18),
		(54, 154, 14, 19, 5, 39.45),
		(55, 155, 15, 20, 4, 37.96),
		(56, 156, 16, 22, 3, 11.37),
		(57, 157, 17, 23, 2, 12.98),
		(58, 158, 18, 24, 4, 11.56),
		(59, 159, 19, 25, 5, 19.75),
		(60, 160, 21, 26, 6, 16.50),
		(61, 161, 1, 27, 5, 12.95),
		(62, 162, 2, 28, 8, 11.60),
		(63, 163, 3, 29, 2, 5.98),
		(64, 164, 4, 30, 4, 13.16),
		(65, 165, 5, 31, 6, 22.74),
		(66, 166, 6, 32, 3, 8.97),
		(67, 167, 7, 33, 5, 16.45),
		(68, 168, 8, 34, 2, 6.98),
		(69, 169, 9, 35, 1, 6.90),
		(70, 170, 10, 36, 5, 9.95),
		(71, 171, 11, 37, 4, 7.56),
		(72, 172, 12, 38, 6, 14.94),
		(73, 173, 13, 39, 3, 8.37),
		(74, 174, 14, 40, 2, 9.18),
		(75, 175, 15, 42, 4, 31.16),
		(76, 176, 16, 43, 3, 9.57),
		(77, 177, 17, 44, 2, 12.98),
		(78, 178, 18, 45, 10, 8.90),
		(79, 179, 19, 47, 4, 23.96),
		(80, 180, 21, 48, 3, 20.70),
		(81, 181, 1, 49, 2, 14.98),
		(82, 182, 2, 50, 7, 14.63),
		(83, 183, 3, 51, 5, 36.45),
		(84, 184, 4, 52, 4, 33.80),
		(85, 185, 5, 53, 2, 29.80),
		(86, 186, 6, 54, 3, 29.97),
		(87, 187, 7, 55, 6, 28.74),
		(88, 188, 8, 56, 3, 20.97),
		(89, 189, 9, 57, 5, 21.45),
		(90, 190, 10, 59, 4, 26.36),
		(91, 191, 11, 61, 6, 26.34),
		(92, 192, 12, 62, 3, 20.97),
		(93, 193, 13, 63, 4, 15.16),
		(94, 194, 14, 64, 2, 10.98),
		(95, 195, 15, 65, 3, 18.87),
		(96, 196, 16, 66, 2, 15.98),
		(97, 197, 17, 67, 4, 51.60),
		(98, 198, 18, 68, 3, 12.30),
		(99, 199, 19, 69, 5, 19.75),
		(100, 200, 21, 70, 10, 21.50);
        
        #visualizzo la quantità di prodotti venduti per negozio
SELECT p.nome_prodotto, SUM(v.qta) AS quantità, n.id_negozio, n.luogo
FROM vendita v
JOIN giacenza g
ON v.id_prodotto = g.id_prodotto
JOIN negozio n
ON v.id_negozio = n.id_negozio
JOIN prodotto p
ON v.id_prodotto = p.id_prodotto
GROUP BY n.id_negozio, v.id_prodotto;

#creo una view per visualizzare i prodotti venduti per negozio come 'totale_vendite'
CREATE OR REPLACE VIEW totale_vendite
AS (
	SELECT p.id_prodotto, p.nome_prodotto, SUM(v.qta) AS quantità, n.id_negozio, n.luogo
	FROM vendita v
	JOIN giacenza g
	ON v.id_prodotto = g.id_prodotto
	JOIN negozio n
	ON v.id_negozio = n.id_negozio
	JOIN prodotto p
	ON v.id_prodotto = p.id_prodotto
	GROUP BY n.id_negozio, v.id_prodotto
    );

SELECT * FROM totale_vendite;

#visualizzo le quantità vendute per negozio con giacenza precedente e nuova giacenza
SELECT tv.id_prodotto, tv.id_negozio, tv.luogo, tv.nome_prodotto, g.giacenza AS giacenza_precedente, g.giacenza - quantità AS giacenza_aggiornata, quantità AS qta_venduta
FROM giacenza g
JOIN totale_vendite tv
ON g.id_prodotto = tv.id_prodotto;

#creo la view con le quantità vendute per negozio con giacenza precedente e nuova giacenza
CREATE VIEW aggiornamento_giacenze
AS (
	SELECT tv.id_prodotto, tv.id_negozio, tv.luogo, tv.nome_prodotto, g.giacenza AS giacenza_precedente, g.giacenza - quantità AS giacenza_aggiornata, quantità AS qta_venduta
	FROM giacenza g
	JOIN totale_vendite tv
	ON g.id_prodotto = tv.id_prodotto
);

SELECT * FROM aggiornamento_giacenze;

#visualizzo la giacenza per prodotto nei vari negozi
#create or replace view aggiornamento_giacenze_final as  (
SELECT id_prodotto, nome_prodotto, id_negozio, luogo, SUM(giacenza_aggiornata) AS giacenza FROM aggiornamento_giacenze
GROUP BY id_prodotto, id_negozio
#con id_negozio =id_negozio prendo tutti i negozi con giacenza inferiore a 100 invece con id_negozio = 3 prendo solo il negozio che corrisponde all'id numero 3 oppure con
#BETWEEN per prendere un range di negozi.
HAVING id_negozio between 11 and 25 and giacenza between 0 and 100
order by giacenza asc;
#update negozio set luogo ='Napoli_Provincie' where id_negozio = 17;


#Per ogni negozio, visualizza il luogo e il totale complessivo delle vendite (totale_vendita).Ordina i risultati in ordine decrescente di fatturato.

select n.id_negozio,n.luogo,sum(v.totale_vendita) tot_vendita
from negozio n 
join vendita v
on n.id_negozio =v.id_negozio
group by id_negozio,n.luogo
order by  sum(v.totale_vendita)  desc;

#Mostra tutti i prodotti la cui giacenza è inferiore alla soglia di restock della categoria a cui appartengono.

select p.nome_prodotto,c.id_categoria,c.soglia_restock,sum(giacenza) giacenza
from prodotto p
inner join giacenza g
on p.id_prodotto=g.id_prodotto
join categoria c
on p.id_categoria=c.id_categoria
where g.giacenza<c.soglia_restock
group by c.id_categoria,p.nome_prodotto
order by soglia_restock desc;
