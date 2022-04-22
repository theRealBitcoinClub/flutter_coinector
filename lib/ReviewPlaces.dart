class ReviewPlaces {
  //DONE
  // carribean, japon, jason, australia

  static final List<Map<String, dynamic>> continents = const [
    {
      'value': 0,
      'label': 'Select Continent',
    },
    {
      'value': 1,
      'label': 'Africa',
    },
    {
      'value': 2,
      'label': 'Asia',
    },
    {
      'value': 3,
      'label': 'Australia',
    },
    {
      'value': 4,
      'label': 'Europe',
    },
    {
      'value': 5,
      'label': 'North America',
    },
    {
      'value': 6,
      'label': 'South America',
    }
  ];

  static final List searchCombos = [
    searchCombosFake,
    searchCombosAfrica,
    searchCombosAsia,
    searchCombosAustralia,
    searchCombosEurope,
    searchCombosNorthAmerica,
    searchCombosSouthAmerica
  ];
  static final List<Map<String, dynamic>> searchCombosFake = const [
    {
      'value': 0,
      'label': "",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAustralia = const [
    {
      'value': 0,
      'label': 'Select Place in Australia',
    }
  ];

  static final List<Map<String, dynamic>> searchCombosEuropeRestaurants =
      const [];

  static final List<Map<String, dynamic>> searchCombosEuropeTakeaway = const [];

  static final List<Map<String, dynamic>> searchCombosEuropeBars = const [];

  static final List<Map<String, dynamic>> searchCombosEurope = const [
    {
      'value': 0,
      'label': 'Select Place in Europe',
    } /*,
    {
      'value': 1,
      'label':
          "Nails By Night, 3720 W Tropicana Ave #8, Las Vegas, NV 89103, USA ",
    },
    {
      'value': 2,
      'label': "Global Citizen Solutions, Greek Street, London, UK ",
    },
    {
      'value': 3,
      'label': "Coinsamba",
    },
    {
      'value': 4,
      'label': "Geovanny Quiroga, Bogota, Colombia",
    },
    {
      'value': 5,
      'label': "Temporada __Cowork_Café, Rua da Torrinha, Porto, Portugal ",
    },
    {
      'value': 6,
      'label':
          "Verduleria Los Nietos, San Luis 3318, Rosario, Santa Fe Province, Argentina ",
    },
    {
      'value': 7,
      'label':
          "Cyber San Antonio.net, Carrera 16, San Antonio del Táchira, Táchira",
    },
    {
      'value': 8,
      'label': "The Break Club, Moldes, Buenos Aires, Argentina",
    },
    {
      'value': 9,
      'label':
          "Level 5 Plaster & Paint, Melody Street, Mermaid Waters Queensland, Australia ",
    },
    {
      'value': 10,
      'label':
          "Melitam Tecno, Avenida Aguila, Las Aguilillas, Tepatitlán de Morelos, Jalisco, Mexico ",
    },
    {
      'value': 11,
      'label':
          "Floristería mallorca, Carrer del Cardenal Rossell, Palma, Spain ",
    },
    {
      'value': 12,
      'label': "ABC - Győr, József Attila u. 43, 9028 Hungary",
    },
    {
      'value': 13,
      'label':
          "Massage Deluxe by Luk, Carrer del Golf de Biscaia, Palma, Spain ",
    },
    {
      'value': 14,
      'label': "Informatique 123, 6581 Rue Beaubien Est, Montréal, QC, Canada ",
    },
    {
      'value': 15,
      'label': "Tecnoboutique, Calle Alcalá, 383, 28027 Madrid, Spain",
    },
    {
      'value': 16,
      'label':
          "Lins Asia Küche, Dr. Anton-Schneider-Straße, Dornbirn, Austria ",
    },
    {
      'value': 17,
      'label':
          "Wizard - Avenida João Pereira de Vargas - Centro, Sapucaia do Sul - RS, Brazil",
    },
    {
      'value': 18,
      'label':
          "TKA-IT Solutions Taner Kaya, Mitterweg 24b, 4600 Wels, Austria Alta, Austria ",
    },
    {
      'value': 19,
      'label':
          "Trachtenhans - Maßgeschneiderte Hirsch Lederhosen Maßanfertigung, Schloßhaide, Scharnstein, Austria",
    },
    {
      'value': 20,
      'label': "HP Nautic OG, Webergrub, Oberndorf, Austria ",
    },
    {
      'value': 21,
      'label':
          "Pankrazhof Bio Pionier, Familie Zimmer, Eichham, Vorchdorf, Austria ",
    },
    {
      'value': 22,
      'label':
          "Pavilly Lavage Hydrowash, Rue Narcisse Guilbert, Pavilly, Francia",
    },
    {
      'value': 23,
      'label': "HispaCBD, Calle Pinos Puente, Peligros, Spain",
    },
    {
      'value': 24,
      'label': "Hispacbd, Ronda del General Mitre, Barcelona, Spain",
    },
    {
      'value': 25,
      'label':
          "Rotulación a Mano / Monkey Business /, Calle Athos, Madrid, España ",
    },
    {
      'value': 26,
      'label':
          "Ugolini Motors srl, Via Pietro Caiani, Borgo San Lorenzo, Metropolitan City of Florence, Italy ",
    },
    {
      'value': 27,
      'label':
          "InterXion ZUR1 (Schweiz) GmbH, Sägereistrasse, Opfikon, Switzerland ",
    },
    {
      'value': 28,
      'label': "B&B Lugano, Via Giuseppe Parini, Lugano, Suiza",
    },
    {
      'value': 29,
      'label': "Salzkammergut Biker, Bahnhofstraße, Gmunden, Austria ",
    },
    {
      'value': 30,
      'label': "Škoda Windischbauer GmbH, Münzfeld, Moosham, Austria",
    },
    {
      'value': 31,
      'label':
          "Zwei-Fach Fenster Vertriebs Gmbh, St. Thomas, Sankt Thomas, Austria ",
    },
    {
      'value': 32,
      'label': "GOLDUNION, Wiener Straße, Linz, Austria ",
    },
    {
      'value': 33,
      'label': "M.A.N.D.U. Steyr, Pachergasse, Steyr, Austria ",
    },
    {
      'value': 34,
      'label':
          "Hubert Staudinger, Florianiweg, Wartberg an der Krems, Austria ",
    },
    {
      'value': 35,
      'label': "XU Wok and More, Salzburger Straße, Wels, Austria ",
    },
    {
      'value': 36,
      'label': "TEXTILREINIGUNG PILZ OG, Langgasse, Linz, Austria ",
    },
    {
      'value': 37,
      'label':
          "Torald Egger | Fassadenbeschriftungen, Beschilderungen, Autobeschriftungen | Der Beschriftungsprofi, Jägertal, Neuhofen an der Krems, Austria ",
    },
    {
      'value': 38,
      'label':
          "Maxx Products Mehringer Walter, Albert-Schweitzer-Straße, Marchtrenk, Austria ",
    },
    {
      'value': 39,
      'label': "Hotel Ploberger, Kaiser-Josef-Platz, Wels, Austria ",
    },
    {
      'value': 40,
      'label':
          "ReiseCenter Mader-Kuoni Reise GmbH Marchtrenk, Linzer Straße, Marchtrenk, Austria ",
    },
    {
      'value': 41,
      'label':
          "ReiseCenter Mader-Kuoni Reise GmbH Leonding, Rathausgasse, Leonding, Austria ",
    },
    {
      'value': 42,
      'label': "Mader Golfreisen, Hofgasse, Linz, Austria ",
    },
    {
      'value': 43,
      'label': "MADER REISEN VertriebsGmbH, Hauptplatz, Linz, Austria ",
    },
    {
      'value': 44,
      'label': "MADER REISEN VertriebsGmbH, Hauptplatz, Linz, Austria ",
    },
    {
      'value': 45,
      'label': "Reisecenter Mader-Kuoni, Pfarrgasse, Steyr, Austria",
    },
    {
      'value': 46,
      'label':
          "Reisecenter Mader-Kuoni St. Valentin, Westbahnstraße, St. Valentin, Austria ",
    },
    {
      'value': 47,
      'label':
          "Mader Reisen VertriebsGmbH Wien, Alser Straße, Vienna, Austria ",
    },
    {
      'value': 48,
      'label':
          "Mader Reisen VertriebsGmbH Katsdorf, Linzer Straße, Katsdorf, Austria ",
    },
    {
      'value': 49,
      'label':
          "Kraftwerk Living Technologies GmbH, Maria-Theresia-Straße, Wels, Austria ",
    },
    {
      'value': 50,
      'label': "Moser Solar, Pesendorf, Austria ",
    }*/
  ];

  static final List<Map<String, dynamic>> searchCombosAfrica = const [
    {
      'value': 0,
      'label': 'Select Place in Africa',
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAsia = const [
    {
      'value': 0,
      'label': 'Select Place in Asia',
    } /*,
    {
      'value': 1,
      'label':
          "Abracadabra Juguetes, Manzanares 2060, C1429 Buenos Aires, Argentina",
    },
    {
      'value': 2,
      'label':
          "Fun Over Fifty Holidays - Immersive tours & adventures, Murrajong Road, Springwood QLD, Australia",
    },
    {
      'value': 3,
      'label':
          "Tecnoaguas Tratamiento de Efluentes, General Juan Lavalle, Villa Martelli, Buenos Aires Province, Argentina ",
    },
    {
      'value': 4,
      'label': "vouka, Afitos, Halkidiki, Greece",
    },
    {
      'value': 5,
      'label': "Ying Bin, Hendrik Consciencestraat, Mechelen, Belgium",
    },
    {
      'value': 6,
      'label':
          "Nixcome, La Retama, Naucalpan de Juárez, State of Mexico, Mexico",
    },
    {
      'value': 7,
      'label': "Studio Cerámica, Calle Bermúdez, Estepona, Spain",
    },
    {
      'value': 8,
      'label':
          "AltePay - Buy and Sell cryptocurrencies for cash (crypto exchange), Cēsu iela, Vidzeme Suburb, Riga, Riga, Latvia",
    },
    {
      'value': 9,
      'label':
          "Palma Central, Av. Kukulkan 6, Palma Central, 77760 Tulum, Q.R., México",
    },
    {
      'value': 10,
      'label': "Masia Villalonga, L'Alcora, Spain",
    },
    {
      'value': 11,
      'label': "Subway, Gleisstraße, Hockenheim, Germany",
    },
    {
      'value': 12,
      'label': "PIANO RESIDENCE, Jána Milca, Žilina, Slovakia ",
    },
    {
      'value': 13,
      'label': "LOW COST WI-FI® Huelva S.L.U., Cartaya, Spain",
    },
    {
      'value': 14,
      'label': "bla",
    },
    {
      'value': 15,
      'label':
          "SPAZIO ENEL PARTNER ROMA, Via della Lega Lombarda, Rome, Metropolitan City of Rome, Italy",
    },
    {
      'value': 16,
      'label':
          "Spazio Enel Partner Roma Via Cipriano Facchinetti 60, Via Cipriano Facchinetti, Rome, Metropolitan City of Rome, Italy ",
    },
    {
      'value': 17,
      'label': "Motorova koloběžka.eu, Lonkova, Pardubice II, Czechia",
    },
    {
      'value': 18,
      'label':
          "Juicefly Wine & Spirits | Alcohol & Vape Delivery, Jefferson Boulevard, Culver City, CA, USA",
    },
    {
      'value': 19,
      'label':
          "Sea Breeze ซีฟู้ด, ถนน พระรามที่ 6 Samsen Nai, Phaya Thai, Bangkok, Thailand",
    },
    {
      'value': 20,
      'label': "The Gibraltar, Perú, Buenos Aires, Argentina",
    },
    {
      'value': 21,
      'label': "Paralelní Polis, Dělnická, Prague 7-Holešovice, Czechia",
    },
    {
      'value': 22,
      'label':
          "Achrainer-Moosen | Urlaub am Bio-Bauernhof / Ferienwohnung / Appartment, Grafenweg 36, 6361 Grafenweg, Tirol, Austria",
    },
    {
      'value': 23,
      'label': "Roma Restaurant & Hotel, Libreville, Gabon",
    },
    {
      'value': 24,
      'label':
          "InstaCrypto.In, 9th Main Rd, Vyalikaval, Kodandarampura, Malleswaram, Bengaluru, Karnataka, India ",
    },
    {
      'value': 25,
      'label':
          "जिप्सीबुद, Gypsybud Street, Gandhi Nagar, Jaipur, Rajasthan, India",
    },
    {
      'value': 26,
      'label': "BTC Wine, Rue Notre Dame, Bordeaux, France",
    },
    {
      'value': 27,
      'label':
          "Munchies Smokehouse and Bar, Paseo Marítimo Rey de España, 43, 29640 Fuengirola, Málaga, Spain ",
    },
    {
      'value': 28,
      'label': "Walmart Supercenter, South Robert Street, Saint Paul, MN, USA",
    },
    {
      'value': 29,
      'label': "Masseria Le Lamie, Villa Castelli, BR, Italy",
    },
    {
      'value': 30,
      'label':
          "Su Bici - La Palma Active, 38712 Los Cancajos, Canary Islands, Spain",
    },
    {
      'value': 31,
      'label':
          "Alfa Vidrios y Aberturas, Coronel Pringles 2042, BHY, Ituzaingó, Buenos Aires, Argentina",
    },
    {
      'value': 32,
      'label': "La Dulce parada, Ramon y Cajal, Valencia, Spain",
    },
    {
      'value': 33,
      'label': "Wallaroo Media, 78 W Center St, Provo, UT 84601, USA ",
    },
    {
      'value': 34,
      'label': "ERP-Solutions GmbH, Waasen, Austria",
    },
    {
      'value': 35,
      'label':
          "Múscari Empresario Distribuidor, Carrera 44, Cali, Valle del Cauca, Colombia",
    },
    {
      'value': 36,
      'label': "PROMOCIONES Y GESTION INMOBILIARIA ALBOLUNCA S.L, Vera, Spain",
    },
    {
      'value': 37,
      'label':
          "Kingofood.com, Via Cassia, 52047 Marciano della Chiana, Province of Arezzo, Italy",
    },
    {
      'value': 38,
      'label':
          "Lañin Amoblamientos, Libertad 1034, AAV, Buenos Aires, Argentina",
    },
    {
      'value': 39,
      'label':
          "791 Hotel, Ingeniero Jacobacci, Las Grutas, Río Negro, Argentina",
    },
    {
      'value': 40,
      'label':
          "MG Mesón Galea Torrevieja - Aceptamos Bitcoin, Calle Cerezo, 515, 03184 Torrevieja, Alicante, España ",
    },
    {
      'value': 41,
      'label': "EM1191 13-6, Loulé, Portugal ",
    },
    {
      'value': 42,
      'label':
          "Casa Monte Isabel, Calle 8, Provincia de Puntarenas, Monteverde, Costa Rica ",
    },
    {
      'value': 43,
      'label': "Ecotros, L'Ametlla de Mar, Tarragona, España",
    },
    {
      'value': 44,
      'label':
          "Olé Idiomas, Torre D - Avenida Chedid Jafet - Vila Olímpia, São Paulo - State of São Paulo, Brazil",
    },
    {
      'value': 45,
      'label': "Nasau Resort & Villas, Nadi, Fiji",
    },
    {
      'value': 46,
      'label': "WorldWideAuto, Avinguda de Ramón y Cajal, Tarragona, España",
    },
    {
      'value': 47,
      'label':
          "Complejo Doña Olga, Santa Cruz, La Rioja, La Rioja Province, Argentina",
    },
    {
      'value': 48,
      'label':
          "Max Home Alava Sl, Alto de Armentia Kalea, 10, Vitoria-Gasteiz, Álava, España ",
    },
    {
      'value': 49,
      'label':
          "Australian Rock Walls, 37 Township Drive, Burleigh Heads QLD, Australia ",
    },
    {
      'value': 50,
      'label':
          "Filippo Esmaily Photography, Boulevard de la Fraternité, Luxembourg",
    }*/
  ];

  static final List<Map<String, dynamic>> searchCombosSouthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in South America',
    }
  ];

  static final List<Map<String, dynamic>> searchCombosNorthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in North America',
    },
    {
      'value': 1,
      'label':
          'Conta-gotas musical - Rua Artur García - Bela Vista, Alvorada - RS, Brasil',
    },
    {
      'value': 2,
      'label': 'malagataxis.net',
    },
    {
      'value': 3,
      'label': "Denny's, Gulf Freeway, Houston, TX, EUA",
    },
    {
      'value': 4,
      'label': "Flores PAROLA",
    },
    {
      'value': 5,
      'label': "Mind Games, 145 Swanston St, Melbourne VIC 3000, Australia",
    },
    {
      'value': 6,
      'label':
          "Kawá cocina vegetariana, Reina Victoria &, Quito 170143, Ecuador",
    },
    {
      'value': 7,
      'label':
          "Angels Rest, Limón 783, Lázaro Cárdenas, 48330 Puerto Vallarta, Jal., Mexico",
    },
    {
      'value': 8,
      'label':
          "Mamá Caguama´s Takos & Beer, Venezuela esq, 5 de Diciembre, 48350 Puerto Vallarta, Jal., México",
    },
    {
      'value': 9,
      'label':
          "Avocado Bistro Nusle, Spytihněvova, 128 00 Prague 2-Nusle, Prague, Czech Republic",
    },
    {
      'value': 10,
      'label': "MACC S.A.S, Bogota, Colombia",
    },
    {
      'value': 11,
      'label': "CaravanMart, Ingham Rd, Garbutt QLD 4814, Australia",
    },
    {
      'value': 12,
      'label':
          "The Peoples Remedy - Patterson, California 33, Patterson, CA, USA",
    },
    {
      'value': 13,
      'label': "People's Remedy, Lone Palm Avenue, Modesto, CA, USA",
    },
    {
      'value': 14,
      'label': "herrlich media GmbH, Labesstraße 7, 27404 Zeven, Deutschland",
    },
    {
      'value': 15,
      'label': "Lieferando, Schlesische Str. 34, 10997 Berlin, Deutschland",
    },
    {
      'value': 16,
      'label':
          "Café Castellanos, Cl. 7 ##5-55, Mesitas del Colegio, Cundinamarca, Colombia",
    },
    {
      'value': 17,
      'label':
          "PILARES DESARROLLOS INMOBILIARIOS, Avenida Acosta Villafañez 1447, San Fernando del Valle de Catamarca, Provinz Catamarca, Argentinien",
    },
    {
      'value': 18,
      'label':
          "Casas Paraty - Rua Imperatriz Teresa Cristina - Jabaquara, Paraty - State of Rio de Janeiro, Brazil",
    },
    {
      'value': 19,
      'label':
          "Restaurante Catetelândia - Rua do Catete - Catete, Rio de Janeiro - State of Rio de Janeiro, Brazil",
    },
    {
      'value': 20,
      'label': "Molepolole, Botswana",
    },
    {
      'value': 21,
      'label': "Apartmany RUDOLF Booking, Zimná 35, Spišská Nová Ves, Slovakia",
    },
    {
      'value': 22,
      'label':
          "Prodental Depósito Dental, Cadereyta, zona dos extendida, Estrella, Santiago de Querétaro, Qro., Mexico",
    },
    {
      'value': 23,
      'label':
          "Heladería Venezia Delivery, Castelli, Monte Quemado, Santiago del Estero, Argentina",
    },
    {
      'value': 24,
      'label':
          "SpiritsCharm, Rua Gago Coutinho 107, 4900-510 Viana do Castelo, Portugal",
    },
    {
      'value': 25,
      'label':
          "English school and accommodation. VillaEnglish., El Colegio - Tibacuy, Mesitas del Colegio, Cundinamarca, Colombia",
    },
    {
      'value': 26,
      'label':
          "Kandang Turipno Serang Petarukan, Jl Pringgondani, Dusun Talkondo, Serang, Pemalang Regency, Central Java, Indonesia",
    },
    {
      'value': 27,
      'label':
          "Coorporacion Oimira 118, Calle Rosio, Santa Elena de Uairen, Bolívar ",
    },
    {
      'value': 28,
      'label': "Lövgärdet pizzaria, Fänkålsgatan, Angered, Sweden",
    },
    {
      'value': 29,
      'label':
          "Aula Particular de Física e Matemática - Vila Kosmos, Rio de Janeiro - State of Rio de Janeiro, Brazil",
    },
    {
      'value': 30,
      'label': "Le Jules Verne, Avenue Gustave Eiffel, París, Francia",
    },
    {
      'value': 31,
      'label':
          "Escuela de Bellas Artes y Comunicaciones BYU, East Campus Drive, Provo, UT 84602, EE. UU.",
    },
    {
      'value': 32,
      'label': "Chede Enterprise, Yola, Nigeria",
    },
    {
      'value': 33,
      'label':
          "www.psicologasaopaulo.com - R. Oscar Freire, 1919 - Pinheiros, São Paulo - SP, 05409-011",
    },
    {
      'value': 34,
      'label':
          "Tres Nagual, The Scone Shack, Plateau Road, Cape Point, Cape Town, South Africa",
    },
    {
      'value': 35,
      'label': "CoinPrime - Bitcoin Shop, Skopje, North Macedonia ",
    },
    {
      'value': 36,
      'label':
          "Transfers & Tours Privados en Colombia Todo incluido, Calle 40, Cundinamarca, Colombia",
    },
    {
      'value': 37,
      'label': "Securicon, Dieze 5, Gemert, Nederland ",
    },
    {
      'value': 38,
      'label': "Vanessa Joyas, Zona Centro, Aguascalientes, Mexico",
    },
    {
      'value': 39,
      'label':
          "Gelateria Miraval Ehingen, Hauptstraße 45, 89584 Ehingen, Germany",
    },
    {
      'value': 40,
      'label': "Majid Khan General Store, Bilal Abad, Peshawar, Pakistan",
    },
    {
      'value': 41,
      'label': "Majid Khan General Store, Jatta Ismail Khel, Pakistan",
    },
    {
      'value': 42,
      'label':
          "Nni Giuvanninu B&B, Via Nazionale, 81, 90044 Villagrazia di Carini, PA, Italy",
    },
    {
      'value': 43,
      'label':
          "Flor de Maia Produtos Naturais - Rua dos Lavradores - Parque Novo Horizonte, Sao Jose dos Campos - State of São Paulo, Brazil",
    },
    {
      'value': 44,
      'label': "Trademark Hardware Inc, New York 59, Suffern, New York, USA",
    },
    {
      'value': 45,
      'label':
          "Uvita Bali Bosque, Calle Bejuco, Puntarenas Province, Uvita, Costa Rica",
    },
    {
      'value': 46,
      'label': "LEGACIS Advogados Portugal, Coimbra, Portugal",
    },
    {
      'value': 47,
      'label':
          "MOVISALUD Médicos a domicilio - Avenida Central Cardenal Raul Silva Henriquez, Santiago, Lo Espejo, Chile",
    },
    {
      'value': 48,
      'label':
          "Percus Assessoria de Marketing Digital - Centro, Dourados - State of Mato Grosso do Sul, Brazil",
    },
    {
      'value': 49,
      'label': "Novin Tools, Shurabad, Tehran Province, Iran",
    },
    {
      'value': 50,
      'label':
          "Black Diamond Custom Tattoos, 4444 W Craig Rd, North Las Vegas, Nevada 89032, USA",
    }
  ];
}
