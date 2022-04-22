class ReviewPlaces {
  //DONE
  // carribean, japon, jason, australia, venezuela without caracas nor maracaibo, all emails, argentinia started

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
      'label': 'Asia.',
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
    },
    {
      'value': 1,
      'label':
          'Froggs & Habit Intergalactic Trading Corporation, Lakeside Road, Farms, Gqeberha, South Africa',
    },
    {
      'value': 2,
      'label':
          'Linen and Bath Vaal Mall, Barrage Road, Vanderbijlpark S. W. 2, Vanderbijlpark, South Africa',
    },
    {
      'value': 3,
      'label':
          'Regent Hill International School (Metsimotlhabe), Metsimotlhaba, Botswana ',
    },
    {
      'value': 4,
      'label':
          'Monoge Supermarket , Liqour Restaurant n Filling Station, Magneetshoogte, South Africa ',
    },
    {
      'value': 5,
      'label': 'Brits Mall, Brits, South Africa ',
    },
    {
      'value': 6,
      'label': 'African Swiss, Hartbeespoort, South Africa ',
    },
    {
      'value': 7,
      'label':
          'Ace Jumping Castles Gauteng, Pommery Avenue, Nietgedacht 535-Jq, Fourways, South Africa ',
    },
    {
      'value': 8,
      'label':
          'Ace Jumping Castles Kwazulu_Natal, Lee Barns Blvd, Dolphin Coast, South Africa ',
    },
    {
      'value': 9,
      'label':
          'DigitalFlyer SA, 864 Wapadrand Rd, Wapadrand Security Village, Pretoria, 0050, South Africa ',
    },
    {
      'value': 10,
      'label':
          'Media101 (PTY) LTD, Plover Place, Broadacres Park, Johannesburg, South Africa',
    },
    {
      'value': 11,
      'label':
          'SUPERSPAR Northwold, Drysdale Road, Northwold, Johannesburg, South Africa ',
    },
    {
      'value': 12,
      'label':
          'Malmoza Logistics (Pty) Ltd, Maple Road, Pomona, Kempton Park, South Africa ',
    },
    {
      'value': 13,
      'label':
          'G&S Trading Solutions (PTY) LTD., Chestnut Street, Three Rivers, Vereeniging, South Africa',
    },
    {
      'value': 14,
      'label':
          'G-Nome Computers, Webber Avenue, Horison, Roodepoort, South Africa ',
    },
    {
      'value': 15,
      'label': 'Roodepoort Licensing Department, Roodepoort, South Africa ',
    },
    {
      'value': 16,
      'label': 'River Birch PVT LTD, Coventry St, Bulawayo, Zimbabwe ',
    },
    {
      'value': 17,
      'label': 'Build it Zambezi, Katima Mulilo, Namibia ',
    },
    {
      'value': 18,
      'label':
          'Casa Mater Vitae - Hotel, Kisantu, Democratic Republic of the Congo ',
    },
    {
      'value': 19,
      'label': "Tina's Royal Nights, Daisha Road, Mtwapa, Kenya ",
    },
    {
      'value': 20,
      'label': 'Betty’s Place, Kimathi Way, Nyeri, Kenya ',
    },
    {
      'value': 21,
      'label': 'The Royal Pets, 1st North Avenue, Nairobi, Kenya ',
    },
    {
      'value': 22,
      'label': 'Café Deli Restaurant, Koinange Street, Nairobi, Kenya ',
    },
    {
      'value': 23,
      'label': 'Jumia Kenya HQ, Maua Close, Nairobi, Kenya ',
    },
    {
      'value': 24,
      'label': 'Awash bank, Dire Dawa, Ethiopia',
    },
    {
      'value': 25,
      'label': 'TELESOM GROUP HR, Qatar Road, Hargeisa, Somalia ',
    },
    {
      'value': 26,
      'label': 'Groupe Service Rapide، Nabeul‎, Tunisia ',
    },
    {
      'value': 27,
      'label': 'Meknès Shop Hamria, Meknes, Morocco ',
    },
    {
      'value': 28,
      'label':
          'Othman Benchekroun - Hypnothérapie & Coaching, Rue Abou Taour, Casablanca, Morocco ',
    },
    {
      'value': 29,
      'label': 'Petit Jardin Tafedna, Morocco ',
    },
    {
      'value': 30,
      'label': 'Ruben Sousa - Psicólogo, Rua das Mercês, Funchal, Portugal ',
    },
    {
      'value': 31,
      'label':
          'La Maresia apartaments Holiday Rent Taganana - Beach Front Anaga, Caserío Roque de las Bodegas, Santa Cruz de Tenerife, Spain ',
    },
    {
      'value': 32,
      'label':
          'Spanish School in Spain - Spanish Courses Gran Canaria, Avenida Rafael Cabrera, Las Palmas de Gran Canaria, Spain ',
    },
    {
      'value': 33,
      'label': 'ORANGE ENERGIE MATAM, Ouro Sogui, Sénégal',
    },
    {
      'value': 34,
      'label': 'Innovation Team, 10th Street, Monrovia, Liberia ',
    },
    {
      'value': 35,
      'label': 'West Hills Mall, West hills mall, Accra, Ghana ',
    },
    {
      'value': 36,
      'label': 'Federal Government College Lagos, Ijanikin, Lagos, Nigeria ',
    },
    {
      'value': 37,
      'label': 'AGE -MATE LIMITED, 1st Avenue, Lagos, Nigeria ',
    },
    {
      'value': 38,
      'label': 'Tecky Planet, Kokumo Road, Lagos, Nigeria ',
    },
    {
      'value': 39,
      'label': 'SabiNovates, Lagos, Nigeria',
    },
    {
      'value': 40,
      'label':
          'Slink Digital Technologies, Market, Omida Road, opposite Omida, Abeokuta, Nigeria ',
    },
    {
      'value': 41,
      'label': 'Watermark Media Photography, Boluwaji Street, Ibadan, Nigeria ',
    },
    {
      'value': 42,
      'label': 'Real Estate Agency, Ibadan, Nigeria ',
    },
    {
      'value': 43,
      'label':
          'Fola safeway Chemist and Supermarket, Imo Road, Ilesa, Nigeria ',
    },
    {
      'value': 44,
      'label': 'BBS Chop Beta, Ilorin, Nigeria ',
    },
    {
      'value': 45,
      'label': 'Jumia Osun Pickup Station, Ajegunle Street, Osogbo, Nigeria ',
    },
    {
      'value': 46,
      'label': 'Emerald Beauty World, Road, Lagos, Nigeria ',
    },
    {
      'value': 47,
      'label': 'Shop9unizik, Awka, Nigeria ',
    },
    {
      'value': 48,
      'label': 'Dj SlimDon, Ogui Road, Enugu, Nigeria ',
    },
    {
      'value': 49,
      'label': 'Gift fast food spot, Enugu, Nigeria ',
    },
    {
      'value': 50,
      'label': 'Nigeria, Port Harcourt, Woji Road, Opay ',
    },
    {
      'value': 51,
      'label': 'DJ mixers, Ibe Street, Port Harcourt, Nigeria ',
    },
    {
      'value': 52,
      'label': 'Oilserv Limited, Trans Woji Road, Port Harcourt, Nigeria ',
    },
    {
      'value': 53,
      'label': 'MEGHEE, East - West Road, Port Harcourt, Nigeria',
    },
    {
      'value': 54,
      'label': 'Abia State Polytechnic, Aba-Owerri Road, Aba, Nigeria ',
    },
    {
      'value': 55,
      'label': "Gifty's Fast Food, Gomoa Fetteh, Ghana ",
    },
    {
      'value': 56,
      'label':
          'BITCOINS ACCESS INVESTMENTS, Mohammadu Buhari Way, Abuja, Nigeria ',
    },
    {
      'value': 57,
      'label': 'CHI-BOY EXPRESS SERVICES, Zaria Bypass, Jos, Nigeria ',
    },
    {
      'value': 58,
      'label':
          "SUPER SERVICE ELECTRICAL AND ELECTRONICS WORK'S, Zaria, Nigeria ",
    },
    {
      'value': 59,
      'label': 'Barra libre VIP, Caracas, Capital District ',
    },
    {
      'value': 60,
      'label': 'San Hussein Shopping Mall, Jekadafari Road, Gombe, Nigeria ',
    },
    {
      'value': 61,
      'label': 'Provision Store, Gombe, Nigeria ',
    },
    {
      'value': 62,
      'label': 'Kefas Shopping Plaza, Galadima Aminu Road, Jimeta, Nigeria ',
    },
    {
      'value': 63,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
    },
    {
      'value': 60,
      'label': '',
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
    }
  ];
}
