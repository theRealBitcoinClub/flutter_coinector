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
    }
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
    }
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
    } /*,
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
    }*/
  ];
}
