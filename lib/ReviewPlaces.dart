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
      'label': 'America',
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
    }
  ];

  static String getContinentAsText(int currentContinent) {
    switch (currentContinent) {
      case 1:
        return "am";
      case 2:
        return "as";
      case 3:
        return "au";
      case 4:
        return "e";
    }
    return "";
  }
}
