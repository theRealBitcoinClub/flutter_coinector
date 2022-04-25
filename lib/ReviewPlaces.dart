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
          "Bandung Web Agency, Padasuka, Bandung City, West Java, Indonesia ",
    },
    {
      'value': 2,
      'label':
          "RS Gunung Jati, Jalan Kesambi, Kesambi, Kota Cirebon, Jawa Barat, Indonesia ",
    },
    {
      'value': 3,
      'label':
          "KRAVEFORMORE, Pradahkalikendal, Surabaya City, East Java, Indonesia ",
    },
    {
      'value': 4,
      'label':
          "iTech Ubud - Apple Repair and Service, Jalan Arjuna, Ubud, Gianyar, Gianyar Regency, Bali, Indonesia ",
    },
    {
      'value': 5,
      'label':
          "iTech Seminyak - Apple Repair and Service - Android Repair, Jalan Kunti I, Seminyak, Badung Regency, Bali, Indonesia ",
    },
    {
      'value': 6,
      'label':
          "M2M Catfish, Jalan Tanah Mas, Baamang Hulu, East Kotawaringin Regency, Central Kalimantan, Indonesia ",
    },
    {
      'value': 7,
      'label':
          "Rose Bakeshop, Roxas St, Barangay 4, San Francisco, Agusan del Sur, Philippines",
    },
    {
      'value': 8,
      'label': "Arc's Pizza Hub Poblacion 3, Hamtic, Antique ",
    },
    {
      'value': 9,
      'label':
          "Jollibee Cadiz, Villena Street, Cadiz City, Negros Occidental, Philippines ",
    },
    {
      'value': 10,
      'label':
          "9 Starts Sari-Sari Store And Snack House, Naga, Camarines Sur, Philippines",
    },
    {
      'value': 11,
      'label':
          "Elly Jean Store, National Highway, Anilao, Iloilo, Philippines ",
    },
    {
      'value': 12,
      'label': "Gemma Store and Internet Cafe, Zarraga, Iloilo, Philippines ",
    },
    {
      'value': 13,
      'label':
          "ARC's Pizza Hub, R Javier Street, Hamtic, Antique, Philippines ",
    },
    {
      'value': 14,
      'label':
          "ERRAVILLE CCTV, Blumentritt Street, Naga, Camarines Sur, Philippines ",
    },
    {
      'value': 15,
      'label':
          "Bestra Aircon & Refrigeration Trading, Blumentritt Street, Naga, Camarines Sur, Philippines ",
    },
    {
      'value': 16,
      'label': "Parmar COOP, Pateros, Metro Manila, Philippines ",
    },
    {
      'value': 17,
      'label':
          "Odfjell Ship Management Phils. Inc., Malate, Manila, Metro Manila, Philippines ",
    },
    {
      'value': 18,
      'label':
          "Bitcoin.com, Benita Street, Gagalangin tondo, Manila, Metro Manila, Philippines ",
    },
    {
      'value': 19,
      'label': "Lone rider club, Marilao, Bulacan, Philippines ",
    },
    {
      'value': 20,
      'label': "台灣高雄市左營區重立路502巷8vermore Yoga & English ",
    },
    {
      'value': 21,
      'label':
          "Taiwan, Tainan City, Guiren District, Section 1st, Zhongshan Road, Wow waffles 美味鬆餅の專門店-歸仁店 ",
    },
    {
      'value': 22,
      'label':
          "Taiwan, Tainan City, South District, Lane 21, Section 2, Jinhua Road, Wow waffles 美味鬆餅の專門店 ",
    },
    {
      'value': 23,
      'label': "台灣台南市中西區金華路四段雙品香酥豬排 ",
    },
    {
      'value': 24,
      'label':
          "Crispy Barbers 男仕理髪廳 No.237, Sec 2, Ximen Rd, West Central Dist, Tainan, Taiwan ",
    },
    {
      'value': 25,
      'label':
          "Taiwan, Taichung City, South District, Lane 146th, Xuefu Road, 恆日1989 ",
    },
    {
      'value': 26,
      'label': "台灣台中市西區精誠路UPH氫呼吸體驗館 臺中店 ",
    },
    {
      'value': 27,
      'label':
          "魂猴設計工作室 SoMonkey Design Studio, 金湖街 Su'ao Township, Yilan County, Taiwan ",
    },
    {
      'value': 28,
      'label': "台灣台北市大安區忠孝東路三段于賓诊所 ",
    },
    {
      'value': 29,
      'label': "台灣台北市萬華區中華路理工法律事務所 ",
    },
    {
      'value': 30,
      'label': "台灣新北市板橋區陽明街十三人 Home 13 Café ",
    },
    {
      'value': 31,
      'label':
          "Taiwan, Taoyuan City, Taoyuan District, Fuguo Road, 嫲嫲Mama（炸烤） ",
    },
    {
      'value': 32,
      'label':
          "Duciduci, Supsongmaeul 1-ro, Ilsandong-gu, Goyang-si, Gyeonggi-do, South Korea ",
    },
    {
      'value': 33,
      'label': "Ray & Dors, Kolonia, Pohnpei, Federated States of Micronesia",
    },
    {
      'value': 34,
      'label': "Kaireva Beach House - Rarotonga, Rarotonga, Cook Islands ",
    },
    {
      'value': 35,
      'label': "Mystic Closet Boutiques, Pahoa Village Road, Pāhoa, HI, USA ",
    },
    {
      'value': 36,
      'label':
          "Perfect Harmony Boutique & Tea Room, Keawe Street, Hilo, HI, USA ",
    },
    {
      'value': 37,
      'label': "The Mystic Closet, Kamehameha Avenue, Hilo, HI, USA ",
    },
    {
      'value': 38,
      'label': "Hands Down Massage Hawaii, Opelo Road, Waimea, HI, USA ",
    },
    {
      'value': 39,
      'label': "The Mystic Closet, Kamehameha Avenue, Hilo, HI, USA ",
    },
    {
      'value': 40,
      'label':
          "GasmanQt McMillan Road, Arthurs Point, Queenstown, New Zealand ",
    },
    {
      'value': 41,
      'label':
          "Nutrient Depot 31 Birmingham Dr, Middleton, Christchurch 8024, New Zealand ",
    },
    {
      'value': 42,
      'label': "Kuske - Individual Eyewear Hardy Street, Nelson, New Zealand ",
    },
    {
      'value': 43,
      'label':
          "3Design NZ Aerodrome Road, Hanger 1, Mount Maunganui, New Zealand ",
    },
    {
      'value': 44,
      'label': "Z Energy Dublin Street, Whanganui, New Zealand ",
    },
    {
      'value': 45,
      'label':
          "Ray White Papamoa Domain Road, Papamoa Beach, Papamoa, New Zealand ",
    },
    {
      'value': 46,
      'label':
          "Gull Henderson Henderson Valley Road, Henderson, Auckland, New Zealand ",
    }
  ];
}
