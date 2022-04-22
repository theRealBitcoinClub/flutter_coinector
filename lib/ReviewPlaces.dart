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
    },
    {
      'value': 1,
      'label':
          "Janta Printing Press, Mill Road, near Agrasen Park, Shamli, Uttar Pradesh, India ",
    },
    {
      'value': 2,
      'label': "",
    },
    {
      'value': 3,
      'label': "",
    },
    {
      'value': 4,
      'label': "",
    },
    {
      'value': 5,
      'label': "",
    },
    {
      'value': 6,
      'label': "",
    },
    {
      'value': 7,
      'label': "",
    },
    {
      'value': 8,
      'label': "",
    },
    {
      'value': 9,
      'label': "",
    },
    {
      'value': 10,
      'label': "",
    },
    {
      'value': 11,
      'label': "",
    },
    {
      'value': 12,
      'label': "",
    },
    {
      'value': 13,
      'label': "",
    },
    {
      'value': 14,
      'label': "",
    },
    {
      'value': 15,
      'label': "",
    },
    {
      'value': 16,
      'label': "",
    },
    {
      'value': 17,
      'label': "",
    },
    {
      'value': 18,
      'label': "",
    },
    {
      'value': 19,
      'label': "",
    },
    {
      'value': 20,
      'label': "",
    },
    {
      'value': 21,
      'label': "",
    },
    {
      'value': 22,
      'label': "",
    },
    {
      'value': 23,
      'label': "",
    },
    {
      'value': 24,
      'label': "",
    },
    {
      'value': 25,
      'label': "",
    },
    {
      'value': 26,
      'label': "",
    },
    {
      'value': 27,
      'label': "",
    },
    {
      'value': 28,
      'label': "",
    },
    {
      'value': 29,
      'label': "",
    },
    {
      'value': 30,
      'label': "",
    },
    {
      'value': 31,
      'label': "",
    },
    {
      'value': 32,
      'label': "",
    },
    {
      'value': 33,
      'label': "",
    },
    {
      'value': 34,
      'label': "",
    },
    {
      'value': 35,
      'label': "",
    },
    {
      'value': 36,
      'label': "",
    },
    {
      'value': 37,
      'label': "",
    },
    {
      'value': 38,
      'label': "",
    },
    {
      'value': 39,
      'label': "",
    },
    {
      'value': 40,
      'label': "",
    },
    {
      'value': 41,
      'label': "",
    },
    {
      'value': 42,
      'label': "",
    },
    {
      'value': 43,
      'label': "",
    },
    {
      'value': 44,
      'label': "",
    },
    {
      'value': 45,
      'label': "",
    },
    {
      'value': 46,
      'label': "",
    },
    {
      'value': 47,
      'label': "",
    },
    {
      'value': 48,
      'label': "",
    },
    {
      'value': 49,
      'label': "",
    },
    {
      'value': 50,
      'label': "",
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
    },
    {
      'value': 1,
      'label': "",
    },
    {
      'value': 2,
      'label': "",
    },
    {
      'value': 3,
      'label': "",
    },
    {
      'value': 4,
      'label': "",
    },
    {
      'value': 5,
      'label': "",
    },
    {
      'value': 6,
      'label': "",
    },
    {
      'value': 7,
      'label': "",
    },
    {
      'value': 8,
      'label': "",
    },
    {
      'value': 9,
      'label': "",
    },
    {
      'value': 10,
      'label': "",
    },
    {
      'value': 11,
      'label': "",
    },
    {
      'value': 12,
      'label': "",
    },
    {
      'value': 13,
      'label': "",
    },
    {
      'value': 14,
      'label': "",
    },
    {
      'value': 15,
      'label': "",
    },
    {
      'value': 16,
      'label': "",
    },
    {
      'value': 17,
      'label': "",
    },
    {
      'value': 18,
      'label': "",
    },
    {
      'value': 19,
      'label': "",
    },
    {
      'value': 20,
      'label': "",
    },
    {
      'value': 21,
      'label': "",
    },
    {
      'value': 22,
      'label': "",
    },
    {
      'value': 23,
      'label': "",
    },
    {
      'value': 24,
      'label': "",
    },
    {
      'value': 25,
      'label': "",
    },
    {
      'value': 26,
      'label': "",
    },
    {
      'value': 27,
      'label': "",
    },
    {
      'value': 28,
      'label': "",
    },
    {
      'value': 29,
      'label': "",
    },
    {
      'value': 30,
      'label': "",
    },
    {
      'value': 31,
      'label': "",
    },
    {
      'value': 32,
      'label': "",
    },
    {
      'value': 33,
      'label': "",
    },
    {
      'value': 34,
      'label': "",
    },
    {
      'value': 35,
      'label': "",
    },
    {
      'value': 36,
      'label': "",
    },
    {
      'value': 37,
      'label': "",
    },
    {
      'value': 38,
      'label': "",
    },
    {
      'value': 39,
      'label': "",
    },
    {
      'value': 40,
      'label': "",
    },
    {
      'value': 41,
      'label': "",
    },
    {
      'value': 42,
      'label': "",
    },
    {
      'value': 43,
      'label': "",
    },
    {
      'value': 44,
      'label': "",
    },
    {
      'value': 45,
      'label': "",
    },
    {
      'value': 46,
      'label': "",
    },
    {
      'value': 47,
      'label': "",
    },
    {
      'value': 48,
      'label': "",
    },
    {
      'value': 49,
      'label': "",
    },
    {
      'value': 50,
      'label': "",
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
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAsia = const [
    {
      'value': 0,
      'label': 'Select Place in Asia',
    },
    {
      'value': 1,
      'label': "Business Village - Dubai - United Arab Emirates",
    },
    {
      'value': 2,
      'label': "Crypto Currency Exchange - Dubai - United Arab Emirates ",
    },
    {
      'value': 3,
      'label':
          "Franck Muller Middle East and India - Dubai - United Arab Emirates ",
    },
    {
      'value': 4,
      'label': "Coinsfera - 5th floor - Dubai - United Arab Emirates ",
    },
    {
      'value': 5,
      'label':
          "Bermuda Diving Center - Al Wasl Road - Dubai - United Arab Emirates ",
    },
    {
      'value': 6,
      'label': "X Factor Restaurant - Dubai - United Arab Emirates ",
    },
    {
      'value': 7,
      'label': "Perfetto Pizzeria - Al Majara - Dubai - United Arab Emirates ",
    },
    {
      'value': 8,
      'label': "Tandoori Junction - Cluster F - Dubai - United Arab Emirates ",
    },
    {
      'value': 9,
      'label': "Masala Mantra - Jvc - Dubai - United Arab Emirates ",
    },
    {
      'value': 10,
      'label': "Sumworks W.L.L, Manama, Bahrain ",
    },
    {
      'value': 11,
      'label': "הום זול - אופקים, ז'בוטינסקי, אופקים, ישראל",
    },
    {
      'value': 12,
      'label': "GURme and Gurman.com, Habaron Hirsh, Petah Tikva, Israel ",
    },
    {
      'value': 13,
      'label': "BeEng.co.il",
    },
    {
      'value': 14,
      'label': "Fly Guy, Yehud-Monosson, Israel",
    },
    {
      'value': 15,
      'label': "Wix Master, יהוד, ישראל ",
    },
    {
      'value': 16,
      'label': "Soft, Aluf Kalman Magen Street, Tel Aviv-Yafo, Israel",
    },
    {
      'value': 17,
      'label': "Bitcoin change, King George Street, Tel Aviv-Yafo, Israel ",
    },
    {
      'value': 18,
      'label': "L'Olivier, Yona HaNavi St 48, Tel Aviv-Yafo, Israel ",
    },
    {
      'value': 19,
      'label': "נונו אנג׳לו פיצה, Ben Yehuda Street 147, Tel Aviv, Israel ",
    },
    {
      'value': 20,
      'label': "בורקס העגלה, Derech HaAtsma'ut, Haifa, Israel ",
    },
    {
      'value': 21,
      'label': "Buy Bitcoin in Lebanon (BuyBitcoinLeb), Beirut, Lebanon ",
    },
    {
      'value': 22,
      'label': "CLEVERFIXING SOLUTIONS, Stylianou Apostolidi, Larnaca, Cyprus ",
    },
    {
      'value': 23,
      'label': "Cyprus Hobbit ",
    },
    {
      'value': 24,
      'label': "Cyprus Flower Boutique, Kato Polemidia, Cyprus ",
    },
    {
      'value': 25,
      'label': "Etosstar, Lemesou Avenue 122D, Nicosia, Cyprus ",
    },
    {
      'value': 26,
      'label': "Olives & Burgers, Prodromou, Nicosia, Cyprus ",
    },
    {
      'value': 27,
      'label': "Dynamex Solutions & Exchange",
    },
    {
      'value': 28,
      'label': "Charlie Lisi Organic Cafe, Tbilisi, Georgia ",
    },
    {
      'value': 29,
      'label':
          "Tbilisi Gate gallery, Nikoloz Baratashvili St, Tbilisi, Georgia ",
    },
    {
      'value': 30,
      'label': "GoogleStore.ge, Ivane Franguliani Street, Tbilisi, Georgia ",
    },
    {
      'value': 31,
      'label':
          "کلینیک کسب و کار کولاک, Naqadeh, West Azerbaijan Province, Iran ",
    },
    {
      'value': 32,
      'label': "Arman tattoo studio, Downtown, Erbil, Iraq ",
    },
    {
      'value': 33,
      'label': "Kurdistan Province, Sanandaj, پاسداران،, دیجی استوک, Iran",
    },
    {
      'value': 34,
      'label':
          "Hamadan Province, Hamedan, District 1, Mirzadeh Eshqi Street, آتلیه کاغذی، Iran ",
    },
    {
      'value': 35,
      'label': "Asre Jadid Pizza, Shahrak-e-Qods, Arak, Markazi Province, Iran",
    },
    {
      'value': 36,
      'label': "فروشگاه پوشاک aronstudios, Tehran, Iran ",
    },
    {
      'value': 37,
      'label': "monazon, District 2, Tehran, Tehran Province, Iran ",
    },
    {
      'value': 38,
      'label':
          "Hillarys Lingerie and Clothing, District 22, Tehran, Tehran Province, Iran ",
    },
    {
      'value': 39,
      'label':
          "Tehran Province, Tehran, Saadi Street, تعمیرات چمدان وکیف حسام, Iran ",
    },
    {
      'value': 40,
      'label':
          "Tehran Province, Qods, District 21, Fath Highway, dastvarz trading بازرگانی دست ورز, Iran",
    },
    {
      'value': 41,
      'label':
          "Tehran Province, Tehran, District 1, Oruzi, Luisa Spagnoli Palladium, Iran ",
    },
    {
      'value': 42,
      'label': "CJ Original, District 1, Tehran, Tehran Province, Iran ",
    },
    {
      'value': 43,
      'label': "Roomita | رومیتا, Pardis, Tehran Province, Iran ",
    },
    {
      'value': 44,
      'label': "Mashhad, مشهد،صیاد شیرازی ۶۵, عسل رزاقی, Iran",
    },
    {
      'value': 45,
      'label': "Mashhad, Rahnamaei Street, عسل برسلان, Iran ",
    },
    {
      'value': 46,
      'label':
          "Sistan and Baluchestan Province, Zahedan, Molavi Hossein Bor Street, پاساژ منصور تاناکورا سامیار, Iran",
    },
    {
      'value': 47,
      'label':
          "Shopon, Major Shabbir Sharif Shaheed, Officers Colony, Multan, Pakistan",
    },
    {
      'value': 48,
      'label': "Handwoven Cashmere, near brands showroom, Hawal, Srinagar ",
    },
    {
      'value': 49,
      'label': "Darshan Kumar Naresh Kumar, Bhucho Mandi, Punjab, India ",
    },
    {
      'value': 50,
      'label':
          "Dm electronic, Ujha Road, near HP GAS godown, Ekta Vihar, Panipat, Haryana, India ",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosSouthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in South America',
    },
    {
      'value': 1,
      'label': "",
    },
    {
      'value': 2,
      'label': "",
    },
    {
      'value': 3,
      'label': "",
    },
    {
      'value': 4,
      'label': "",
    },
    {
      'value': 5,
      'label': "",
    },
    {
      'value': 6,
      'label': "",
    },
    {
      'value': 7,
      'label': "",
    },
    {
      'value': 8,
      'label': "",
    },
    {
      'value': 9,
      'label': "",
    },
    {
      'value': 10,
      'label': "",
    },
    {
      'value': 11,
      'label': "",
    },
    {
      'value': 12,
      'label': "",
    },
    {
      'value': 13,
      'label': "",
    },
    {
      'value': 14,
      'label': "",
    },
    {
      'value': 15,
      'label': "",
    },
    {
      'value': 16,
      'label': "",
    },
    {
      'value': 17,
      'label': "",
    },
    {
      'value': 18,
      'label': "",
    },
    {
      'value': 19,
      'label': "",
    },
    {
      'value': 20,
      'label': "",
    },
    {
      'value': 21,
      'label': "",
    },
    {
      'value': 22,
      'label': "",
    },
    {
      'value': 23,
      'label': "",
    },
    {
      'value': 24,
      'label': "",
    },
    {
      'value': 25,
      'label': "",
    },
    {
      'value': 26,
      'label': "",
    },
    {
      'value': 27,
      'label': "",
    },
    {
      'value': 28,
      'label': "",
    },
    {
      'value': 29,
      'label': "",
    },
    {
      'value': 30,
      'label': "",
    },
    {
      'value': 31,
      'label': "",
    },
    {
      'value': 32,
      'label': "",
    },
    {
      'value': 33,
      'label': "",
    },
    {
      'value': 34,
      'label': "",
    },
    {
      'value': 35,
      'label': "",
    },
    {
      'value': 36,
      'label': "",
    },
    {
      'value': 37,
      'label': "",
    },
    {
      'value': 38,
      'label': "",
    },
    {
      'value': 39,
      'label': "",
    },
    {
      'value': 40,
      'label': "",
    },
    {
      'value': 41,
      'label': "",
    },
    {
      'value': 42,
      'label': "",
    },
    {
      'value': 43,
      'label': "",
    },
    {
      'value': 44,
      'label': "",
    },
    {
      'value': 45,
      'label': "",
    },
    {
      'value': 46,
      'label': "",
    },
    {
      'value': 47,
      'label': "",
    },
    {
      'value': 48,
      'label': "",
    },
    {
      'value': 49,
      'label': "",
    },
    {
      'value': 50,
      'label': "",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosNorthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in North America',
    },
    {
      'value': 1,
      'label': "",
    },
    {
      'value': 2,
      'label': "",
    },
    {
      'value': 3,
      'label': "",
    },
    {
      'value': 4,
      'label': "",
    },
    {
      'value': 5,
      'label': "",
    },
    {
      'value': 6,
      'label': "",
    },
    {
      'value': 7,
      'label': "",
    },
    {
      'value': 8,
      'label': "",
    },
    {
      'value': 9,
      'label': "",
    },
    {
      'value': 10,
      'label': "",
    },
    {
      'value': 11,
      'label': "",
    },
    {
      'value': 12,
      'label': "",
    },
    {
      'value': 13,
      'label': "",
    },
    {
      'value': 14,
      'label': "",
    },
    {
      'value': 15,
      'label': "",
    },
    {
      'value': 16,
      'label': "",
    },
    {
      'value': 17,
      'label': "",
    },
    {
      'value': 18,
      'label': "",
    },
    {
      'value': 19,
      'label': "",
    },
    {
      'value': 20,
      'label': "",
    },
    {
      'value': 21,
      'label': "",
    },
    {
      'value': 22,
      'label': "",
    },
    {
      'value': 23,
      'label': "",
    },
    {
      'value': 24,
      'label': "",
    },
    {
      'value': 25,
      'label': "",
    },
    {
      'value': 26,
      'label': "",
    },
    {
      'value': 27,
      'label': "",
    },
    {
      'value': 28,
      'label': "",
    },
    {
      'value': 29,
      'label': "",
    },
    {
      'value': 30,
      'label': "",
    },
    {
      'value': 31,
      'label': "",
    },
    {
      'value': 32,
      'label': "",
    },
    {
      'value': 33,
      'label': "",
    },
    {
      'value': 34,
      'label': "",
    },
    {
      'value': 35,
      'label': "",
    },
    {
      'value': 36,
      'label': "",
    },
    {
      'value': 37,
      'label': "",
    },
    {
      'value': 38,
      'label': "",
    },
    {
      'value': 39,
      'label': "",
    },
    {
      'value': 40,
      'label': "",
    },
    {
      'value': 41,
      'label': "",
    },
    {
      'value': 42,
      'label': "",
    },
    {
      'value': 43,
      'label': "",
    },
    {
      'value': 44,
      'label': "",
    },
    {
      'value': 45,
      'label': "",
    },
    {
      'value': 46,
      'label': "",
    },
    {
      'value': 47,
      'label': "",
    },
    {
      'value': 48,
      'label': "",
    },
    {
      'value': 49,
      'label': "",
    },
    {
      'value': 50,
      'label': "",
    }
  ];
}
