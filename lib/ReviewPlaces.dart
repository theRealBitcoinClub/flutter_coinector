class ReviewPlaces {
  //DONE
  // south japon, south africa, jason

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
      //'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 3,
      'label': 'Australia',
      //'icon': Icon(Icons.stop),
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
      'label': 'Acacia Limousines, Currajong QLD, Australia',
    },
    {
      'value': 2,
      'label': 'Alt Brew, Townsville City QLD, Australia',
    },
    {
      'value': 3,
      'label': 'Aptissio Australia Pty Ltd, Townsville QLD, Australia',
    },
    {
      'value': 4,
      'label': 'Archer Mobile Coffee, Garbutt QLD, Australia',
    },
    {
      'value': 5,
      'label': 'Aroi Bangkok Thai Restaurant, Hermit Park QLD, Australia',
    },
    {
      'value': 6,
      'label': 'Aussie Thai Fusion, North Ward QLD, Australia',
    },
    {
      'value': 7,
      'label':
          'Australian Hotel, 11 Palmer St, South Townsville QLD 4810, Australia',
    },
    {
      'value': 8,
      'label': 'Liquor Legends South Townsville, Australia',
    },
    {
      'value': 9,
      'label':
          'BFQ Accountants, Mitchell Street, North Ward Queensland, Australia',
    },
    {
      'value': 10,
      'label':
          'Bitcoin Cash, Flinders Street, Townsville Queensland, Australia',
    },
    {
      'value': 11,
      'label':
          'BNG Sports Bicycle Central Hyde Park, Kings Road, Hyde Park QLD, Australia',
    },
    {
      'value': 12,
      'label':
          'Bounce Coffee Company, 87 Ingham Rd, Townsville QLD 4810, Australia',
    },
    {
      'value': 13,
      'label':
          'Restaurant Le Paradis Brasserie & Take Away @ Nelly, Sooning Street, Nelly Bay Queensland, Australia',
    },
    {
      'value': 14,
      'label':
          'Cafe Society - Kmart Centre, 145 Nathan St, Aitkenvale QLD 4814, Australia',
    },
    {
      'value': 15,
      'label': 'Cafe Spuntino, 143 Walker St, Townsville QLD 4810, Australia',
    },
    {
      'value': 16,
      'label':
          "Cate's Chemist Garbutt, 223 Ingham Rd, Garbutt QLD 4814, Australia",
    },
    {
      'value': 17,
      'label':
          "Cate's Chemist Hyde Park, 87 Charters Towers Rd, Hyde Park QLD 4812, Australia",
    },
    {
      'value': 18,
      'label':
          "Cate's Chemist TAIHS, 57-59 Gorden St, Garbutt QLD 4814, Australia",
    },
    {
      'value': 19,
      'label': "Checker Cabs, 31-33 Keane St, Currajong QLD 4812, Australia",
    },
    {
      'value': 20,
      'label': "City Oasis Inn, 143 Wills St, Townsville QLD 4810, Australia",
    },
    {
      'value': 21,
      'label':
          "Code Valley Corp Pty Ltd, 435 Woolcock St, Garbutt QLD 4814, Australia",
    },
    {
      'value': 22,
      'label':
          "Colour It/Man It, 124A Woolcock St, Pimlico QLD 4812, Australia",
    },
    {
      'value': 23,
      'label':
          "Dawson Moving & Storage NQ, 5 Everett St, Bohle QLD 4818, Australia",
    },
    {
      'value': 24,
      'label':
          'Dr Kosh Hazratwala (Townsville Lower Limb Clinic)	Pimlico QLD, Australia',
    },
    {
      'value': 25,
      'label':
          'Eraza Laser Tattoo Removal Clinic Townsville, QLD 4810, Australia',
    },
    {
      'value': 26,
      'label':
          'Family Life Organics, 238/262 Woolcock St, Currajong QLD 4812, Australia',
    },
    {
      'value': 27,
      'label':
          'MI Rentals Car Hire & Jeeps On Maggie, Mandalay Avenue, Nelly Bay Queensland, Australia',
    },
    {
      'value': 28,
      'label': 'Fruits N Scoops, 4 Arcadia Rd, Nelly Bay QLD 4819, Australia ',
    },
    {
      'value': 29,
      'label':
          'Gentleman Jones, 108 Charters Towers Rd, Townsville, QLD 4812, Australia ',
    },
    {
      'value': 30,
      'label': "Grandma's, Shop 14/45 Eyre St, North Ward QLD 4810, Australia",
    },
    {
      'value': 31,
      'label':
          'Health First Development, 2/62 Keane St, Currajong QLD 4812, Australia',
    },
    {
      'value': 32,
      'label':
          'Jim Chaillons Auto Service, 25 Casey St, Aitkenvale Townsville, QLD 4814, Australia',
    },
    {
      'value': 33,
      'label':
          'John Gray Constructions, 265 Ingham Rd, Garbutt QLD 4814, Australia',
    },
    {
      'value': 34,
      'label': 'Key Motors, 241 Dalrymple Road, Garbutt QLD 4814, Australia',
    },
    {
      'value': 35,
      'label':
          'King Konz School of Music, Hamilton Street, Townsville Queensland, Australia',
    },
    {
      'value': 36,
      'label':
          'Kumusha African Shop Townsville, 310-330 Ross River Rd, Aitkenvale QLD 4814, Australia',
    },
    {
      'value': 37,
      'label':
          'Little Pegs Cafe, 210 Charters Towers Rd, Hermit Park QLD 4812, Australia',
    },
    {
      'value': 38,
      'label': "Mad Maggie's Promotions, Townsville, Queensland, Australia",
    },
    {
      'value': 39,
      'label':
          'Mission 2 Repair, 440 Flinders St, Townsville QLD 4810, Australia',
    },
    {
      'value': 40,
      'label':
          'Moksha Room Hair & Beauty, 2 Dibbs St, South Townsville QLD 4810, Australia',
    },
    {
      'value': 41,
      'label':
          'oceans jewels on magnetic, SHOP 3/98-100 Sooning St, Nelly Bay QLD 4819, Australia',
    },
    {
      'value': 42,
      'label': 'Ola Barbers, 278 Bayswater Rd, Currajong QLD 4812, Australia',
    },
    {
      'value': 43,
      'label':
          'OracleStudio, 107 Kings Road, Pimlico Townsville, QLD 4812, Australia',
    },
    {
      'value': 44,
      'label': "Otto's Market Warrina, Illuka Street, Currajong QLD, Australia",
    },
    {
      'value': 45,
      'label': 'Otto’s Market Precinct, Village Drive, Idalia QLD, Australia',
    },
    {
      'value': 46,
      'label':
          'Premise - Townsville Office, 84 Denham St, Townsville QLD 4810, Australia',
    },
    {
      'value': 47,
      'label': 'ROCK APE RECORDS, Sturt Street, Townsville QLD, Australia',
    },
    {
      'value': 48,
      'label':
          'Roofguard (Roof Painting), Ramsay Street, Garbutt QLD, Australia',
    },
    {
      'value': 49,
      'label': 'RowanAir Pty Ltd, Leyland Street, Garbutt QLD, Australia',
    },
    {
      'value': 50,
      'label': "Rowan's Body Works, Reardon Street, Currajong QLD, Australia",
    },
    {
      'value': 51,
      'label': 'Rydweld, Crocodile Crescent, Mount Saint John QLD, Australia',
    },
    {
      'value': 52,
      'label':
          "Sandi's on Magnetic Island, Magnetic Island, Pacific Drive, Magnetic Island QLD, Australia",
    },
    {
      'value': 53,
      'label':
          "Serenity Massage with Sarah Speerstra - Remedial Massage Therapist, Halifax Street, Garbutt QLD, Australia",
    },
    {
      'value': 54,
      'label': "Skin Ski + Surf, Flinders Street, Townsville QLD, Australia",
    },
    {
      'value': 55,
      'label': "Skinnys Supa Deli, Banfield Drive, Mount Louisa QLD, Australia",
    },
    {
      'value': 56,
      'label': "Solex, Somer Street, Hyde Park QLD, Australia",
    },
    {
      'value': 57,
      'label':
          "SOS - Stuffed on Seafood, Arcadia Road, Nelly Bay QLD, Australia",
    },
    {
      'value': 58,
      'label':
          "Spark Movement Studio, Denham Street, Townsville QLD, Australia",
    },
    {
      'value': 59,
      'label': "Speerstra Interiors, Halifax Street, Garbutt QLD, Australia",
    },
    {
      'value': 60,
      'label': "Squeaky Clean Townsville, Cranbrook QLD, Australia",
    },
    {
      'value': 61,
      'label': "Strand Fitness, Flinders Street, Townsville QLD, Australia",
    },
    {
      'value': 62,
      'label': "Stripes Coffee, Echlin Street, West End QLD, Australia",
    },
    {
      'value': 63,
      'label':
          "Supreme Automotive - Car Mechanic Currajong, Keane Street, Currajong QLD, Australia",
    },
    {
      'value': 64,
      'label':
          "The Mac Doctors, Charters Towers Road, Mysterton QLD, Australia",
    },
    {
      'value': 65,
      'label':
          "The Old Railway Cafe, Flinders Street, Townsville QLD, Australia",
    },
    {
      'value': 66,
      'label': "Tidy Towing Townsville",
    },
    {
      'value': 67,
      'label':
          "Townsville Helicopters - Training, Scenic, Charter & Aerial Work, Old Common Road, Rowes Bay QLD, Australia",
    },
    {
      'value': 68,
      'label':
          "Townsville Massage and Soul Bar, Denham Street, Townsville QLD, Australia ",
    },
    {
      'value': 69,
      'label':
          "Townsville Titan Security and Electrical, Charters Towers Road, Hyde Park QLD, Australia",
    },
    {
      'value': 70,
      'label': "Townsville WaterSports, The Strand, Townsville QLD, Australia",
    },
    {
      'value': 71,
      'label':
          "Voltec Services Pty. Ltd., Deschamp Street, Heatley QLD, Australia",
    },
    {
      'value': 72,
      'label':
          "WaterLeaf Skin Health And Beauty, Charters Towers Road, Hyde Park QLD, Australia",
    },
    {
      'value': 73,
      'label':
          "Yongala Lodge by The Strand, Fryer Street, North Ward QLD, Australia",
    },
    {
      'value': 74,
      'label':
          "Inner Light Meditation Centre, Flinders Street, Townsville QLD, Australia ",
    },
    {
      'value': 75,
      'label': "Rising Sun FPV, Civil Road, Garbutt QLD, Australia",
    },
    {
      'value': 76,
      'label': "Beach Hire, Horseshoe Bay Road, Horseshoe Bay QLD, Australia",
    },
    {
      'value': 77,
      'label': "TerreCom Pty Ltd, Flinders Street, Townsville QLD, Australia ",
    },
    {
      'value': 78,
      'label': "fix my home townsville",
    },
    {
      'value': 79,
      'label': "Skin Ski + Surf, Flinders Street, Townsville QLD, Australia",
    },
    {
      'value': 80,
      'label': "JMF Kebabs Townsville",
    },
    {
      'value': 81,
      'label': "The Door Shop, Somer Street, Hyde Park QLD, Australia",
    },
    {
      'value': 82,
      'label': "Little Bee Marketing, Leyland Street, Garbutt QLD, Australia",
    },
    {
      'value': 83,
      'label':
          "Opposite Lock Townsville, Woolcock Street, Garbutt QLD, Australia",
    },
    {
      'value': 84,
      'label': "Just My Barberz, Eyre Street, North Ward QLD, Australia",
    },
    {
      'value': 85,
      'label': "Cafe Bambini Verde, Flinders Street, Townsville QLD, Australia",
    },
    {
      'value': 86,
      'label':
          "Lucy Holland Naturopath - Remedial Massage, Digestive Health & Naturopath Townsville, Kent Street, Gulliver QLD, Australia ",
    },
    {
      'value': 87,
      'label':
          "JPS CAR SERVICE ( Mobile Mechanic), Bombala Close, Merriwa WA, Australia ",
    },
    {
      'value': 88,
      'label': "Munro's, Fitzgerald Street, Perth WA, Australia ",
    },
    {
      'value': 89,
      'label':
          "Storm Computers, 1252 Albany Hwy, Cannington WA 6107, Australia ",
    },
    {
      'value': 90,
      'label':
          "DANASKI DRUGS AND MEDICAL SUPPLY, Damboa Road, Maiduguri, Nigeria ",
    },
    {
      'value': 91,
      'label': "Elk Fish Robotics, Marine Terrace, Fremantle WA, Australia ",
    },
    {
      'value': 92,
      'label':
          "Frank Torre Quality Butcher, 322 Bulwer St, Perth WA 6000, Australia ",
    },
    {
      'value': 93,
      'label':
          "Complete Vaping, 249 Brighton Rd, Somerton Park SA 5044, Australia ",
    },
    {
      'value': 94,
      'label': "Victory Vape, Albert Street, Daylesford VIC, Australia",
    },
    {
      'value': 95,
      'label':
          "Cinta Cottage, 15 Victoria Road, Loch Victoria 3945, Australia ",
    },
    {
      'value': 96,
      'label':
          "Smart Energy Lab, Moora Road, Mount Toolebewong VIC, Australia ",
    },
    {
      'value': 97,
      'label':
          "Brontobyte IT Services 6 Lindsay St, Frankston North VIC 3200, Australia ",
    },
    {
      'value': 98,
      'label':
          "Auslift Crane & Access Hire, 2/2/4 Souffi Pl, Dandenong South VIC 3175, Australia ",
    },
    {
      'value': 99,
      'label':
          "Doctors of Osteo, 1 Porter Street, Hawthorn East VIC, Australia ",
    },
    {
      'value': 100,
      'label': "Biztactix, Western Avenue, Sunshine VIC, Australia ",
    },
    {
      'value': 101,
      'label':
          "WestUrban Group, Ferntree Gully Road, Mount Waverley VIC, Australia ",
    },
    {
      'value': 102,
      'label':
          "Remedial Massage Therapy by Billy, 10 St Duthus St, Preston VIC, Australia ",
    },
    {
      'value': 103,
      'label':
          "Comans Services, Southbank Boulevard, Southbank VIC, Australia ",
    },
    {
      'value': 104,
      'label': "Sensu Spa, 570 Bourke St, Melbourne VIC 3000, Australia ",
    },
    {
      'value': 105,
      'label':
          "Smart Energy Lab, Moora Road, Mount Toolebewong VIC, Australia ",
    },
    {
      'value': 106,
      'label':
          "Bezoni Clothing Factory, Westfield Belconnen, Benjamin Way, Belconnen ACT, Australia ",
    },
    {
      'value': 107,
      'label': "Aurora Bridal, North Wickham Road, Melbourne, FL, USA ",
    },
    {
      'value': 108,
      'label': "Wood Bricklaying, Bath Road, Kirrawee NSW, Australia ",
    },
    {
      'value': 109,
      'label': "AVA Migration Agency, Ada Street, Harris Park NSW, Australia ",
    },
    {
      'value': 110,
      'label':
          "Top Ryde City Shopping Centre, Blaxland Road, Ryde NSW, Australia ",
    },
    {
      'value': 111,
      'label': "Archiprofiles Pty Ltd, Alexandria NSW, Australia ",
    },
    {
      'value': 112,
      'label': "CREATE by ReNCOUNTER, Waters Road, Neutral Bay NSW, Australia ",
    },
    {
      'value': 113,
      'label':
          "Collard Maxwell Architects, Pacific Highway, North Sydney NSW, Australia ",
    },
    {
      'value': 114,
      'label':
          "Eurolife Kitchens and Wardrobes Sydney, Victoria Road, Drummoyne NSW, Australia ",
    },
    {
      'value': 115,
      'label':
          "Cargo Bar, King Street Wharf Darling Harbour, The Promenade, Sydney NSW, Australia ",
    },
    {
      'value': 116,
      'label':
          "Australian Company Liquidations, 379 Kent St, Sydney NSW 2000, Australia ",
    },
    {
      'value': 117,
      'label':
          "Terrigal Pacific Coastal Retreat, Terrigal Drive, Terrigal NSW, Australia ",
    },
    {
      'value': 118,
      'label': "Bellingen IT, 78 Hyde St, Bellingen NSW 2454, Australia ",
    },
    {
      'value': 119,
      'label': "Byron Farmers Market, Butler Street, Byron Bay NSW, Australia ",
    },
    {
      'value': 120,
      'label':
          "Pottsville Hardware, Coronation Avenue, Pottsville NSW, Australia ",
    },
    {
      'value': 121,
      'label':
          "Australian Rock Walls, Township Drive, Burleigh Heads QLD, Australia ",
    },
    {
      'value': 122,
      'label':
          "Black Market Tattoo Co | Robina Gold Coast Tattoo Studio, Robina Town Centre Drive, Robina QLD, Australia ",
    },
    {
      'value': 123,
      'label':
          "i like ramen, Gold Coast Highway, Mermaid Beach QLD, Australia ",
    },
    {
      'value': 124,
      'label': "Mean Beans, Lawson Street, Southport QLD, Australia ",
    },
    {
      'value': 125,
      'label':
          "GRYFFIN OPAL (Mariora Designs Boutique), 74 Seaworld Dr, Main Beach QLD 4217, Australia ",
    },
    {
      'value': 126,
      'label':
          "ArtSmiles General & Cosmetic Dentistry, Nind Street, Southport QLD, Australia ",
    },
    {
      'value': 127,
      'label':
          "Tall Trees Motel Mountain Retreat, Eagle Heights Road, Tamborine Mountain QLD, Australia ",
    },
    {
      'value': 128,
      'label':
          "Australian Outback Opals, Eagle Heights Road, Tamborine Mountain QLD, Australia ",
    },
    {
      'value': 129,
      'label':
          "Australian Business Printers, 58 George St, Beenleigh QLD 4207, Australia ",
    },
    {
      'value': 130,
      'label': "5 Dogs Loganlea, Station Road, Loganlea QLD, Australia ",
    },
    {
      'value': 131,
      'label':
          "THE CARWASH COMPANY, 3525 Pacific Motorway, Slacks Creek QLD 4127, Australia ",
    },
    {
      'value': 132,
      'label': "ozdingo, Forge Close, Sumner QLD, Australia ",
    },
    {
      'value': 133,
      'label':
          "5 Dogs Mt Gravatt, Shop C/1303 Logan Rd, Mount Gravatt QLD 4122, Australia ",
    },
    {
      'value': 134,
      'label':
          "Boroughs of New York Woodfired Pizza, 757 Ann St, Fortitude Valley QLD 4006, Australia",
    },
    {
      'value': 135,
      'label':
          "THE CARWASH COMPANY, 650 Wickham St, Fortitude Valley QLD 4006, Australia ",
    },
    {
      'value': 136,
      'label':
          "Penguin Podiatry, 9 Elizabeth Ave, Clontarf QLD 4019, Australia ",
    },
    {
      'value': 137,
      'label':
          "North Coast Forktrucks Pty Ltd, Allen Street, Moffat Beach Queensland, Australia ",
    },
    {
      'value': 138,
      'label': "BioStim, 8 Tamarindus St, Marcoola QLD 4564, Australia ",
    },
    {
      'value': 139,
      'label':
          "Cleanwater Group, 5 Junction Drive, Coolum Beach QLD 4573, Australia ",
    },
    {
      'value': 140,
      'label':
          "Bundaberg Concrete Casters, Enterprise Street, Svensson Heights QLD, Australia ",
    },
    {
      'value': 141,
      'label':
          "Discover 1770 Holiday Shop & Tour Bookings, Captain Cook Drive, Agnes Water Queensland, Australia ",
    },
    {
      'value': 142,
      'label':
          "PRDnationwide Agnes Water, Endeavour Plaza, Captain Cook Dr, Agnes Water QLD 4677, Australia ",
    },
    {
      'value': 143,
      'label':
          "Drift & Wood, 40 Captain Cook Dr, Agnes Water QLD 4677, Australia ",
    },
    {
      'value': 144,
      'label':
          "Allied Business Group Pty Ltd, Bolsover Street, Rockhampton Queensland, Australia",
    },
    {
      'value': 145,
      'label':
          "Allied Business Group Pty Ltd, Archer Street, Depot Hill Queensland, Australia ",
    },
    {
      'value': 146,
      'label': "Honey & Spice, Main Street, Proserpine Queensland, Australia ",
    },
    {
      'value': 147,
      'label':
          "Railway Hotel Ravenswood, Barton Street, Ravenswood QLD, Australia ",
    },
    {
      'value': 148,
      'label': "Marine hotel, 59 Victoria St, Cardwell QLD 4849, Australia ",
    },
    {
      'value': 149,
      'label':
          "Cardwell True Value Hardware, Victoria Street, Cardwell Queensland, Australia ",
    },
    {
      'value': 150,
      'label':
          "Brearleys Bakery, 79 Victoria St, Cardwell QLD 4849, Australia ",
    },
    {
      'value': 151,
      'label':
          "Pure Shores Hair Studio, Victoria Street, Cardwell QLD 4849, Australia ",
    },
    {
      'value': 152,
      'label':
          "Kookaburra Holiday Park, 175 Bruce Hwy, Cardwell QLD 4849, Australia ",
    },
    {
      'value': 153,
      'label':
          "Cardwell Tyre Service, Bruce Highway, Ellerbeck Queensland, Australia ",
    },
    {
      'value': 154,
      'label': "FNQ Computers, 36 Mabel St, Atherton QLD 4883, Australia ",
    },
    {
      'value': 155,
      'label': "Tinaroo Lake Resort, Palm St, Tinaroo QLD 4872, Australia ",
    },
    {
      'value': 156,
      'label': "Ice Ice Baby Air conditioning & Refrigeration ",
    },
    {
      'value': 157,
      'label': "The Crazy Ox Carvery, Reservoir Road, Manoora QLD, Australia ",
    },
    {
      'value': 158,
      'label':
          "Jeffrey Rufino, McLeod Street, Cairns City Queensland, Australia ",
    },
    {
      'value': 159,
      'label':
          "Bitcoin Tutor Bot, McLeod Street, Cairns City Queensland, Australia ",
    },
    {
      'value': 160,
      'label':
          "Tropi-Cool Air Conditioning Refrigeration, McCormack Street, Manunda QLD, Australia ",
    },
    {
      'value': 161,
      'label':
          "Brother Jenkins Cafe, 177 Martyn St, Manunda QLD 4870, Australia ",
    },
    {
      'value': 162,
      'label':
          "Blvk Temple Tattoo, Lake Street, Cairns City Queensland, Australia ",
    },
    {
      'value': 163,
      'label':
          "Slap and Pickle Low and Slow Smokehouse, Shields Street, Cairns City Queensland, Australia ",
    },
    {
      'value': 164,
      'label': "Injecta Tile ",
    },
    {
      'value': 165,
      'label':
          "Country Solar NT, Verrinder Road, Berrimah Territorio del Norte, Australia ",
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
      'label': "Győr, ABC, József Attila u. 43, 9028 Hungary",
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
    },
    {
      'value': 51,
      'label': "All4Life Group, Feldbach, Lochen am See, Austria",
    },
    {
      'value': 52,
      'label':
          "Extrutherm Kunststofftechnik GmbH, Welser Straße, Gunskirchen, Austria ",
    },
    {
      'value': 53,
      'label': "Harmonie im Garten GmbH, Schloßau, Seeboden, Austria ",
    },
    {
      'value': 54,
      'label': "drugstores.at CBD-Store, Ardaggerstraße, Amstetten, Austria",
    },
    {
      'value': 55,
      'label': "drugstores.at CBD-Store, Pfarrgasse, Steyr, Austria",
    },
    {
      'value': 56,
      'label': "Drugstores.at CBD-Store, Dr.-Salzmann-Straße, Wels, Austria ",
    },
    {
      'value': 57,
      'label':
          "Michael Gärner Brillen Kontaktlinsen Hörgeräte GmbH, Hauptplatz, Ried im Innkreis, Austria ",
    },
    {
      'value': 58,
      'label': "A1 Shop, Europastraße, Salzburg, Austria",
    },
    {
      'value': 59,
      'label': "A1 Shop, Maria-Theresien-Straße, Innsbruck, Austria ",
    },
    {
      'value': 60,
      'label': "A1 Shop, Landstraße, Linz, Austria ",
    },
    {
      'value': 61,
      'label': "A1 Shop, Kärntner Straße, Vienna, Austria ",
    },
    {
      'value': 62,
      'label': "A1 Shop, Wiener Straße, Krems an der Donau, Austria ",
    },
    {
      'value': 63,
      'label': "A1 Telekom Austria AG, Herrengasse, Graz, Austria ",
    },
    {
      'value': 64,
      'label': "A1 Shop Wien Mitte, Landstraßer Hauptstraße, Vienna, Austria ",
    },
    {
      'value': 65,
      'label': "Exotique, Triq Sqaq Lourdes, Saint Julian's, Malta",
    },
    {
      'value': 66,
      'label':
          "Hyundai-Partner KFZ - Schweiger Martin, Vorchdorfer Straße, Pettenbach, Austria ",
    },
    {
      'value': 67,
      'label': "Zweirad-Center Steyr, Ennser Straße, Steyr, Austria ",
    },
    {
      'value': 68,
      'label': "Gemeinschaft beflügelt, Waidhofner Straße, Amstetten, Austria ",
    },
    {
      'value': 69,
      'label': "E-Projekt, Liesingbachstraße, Vienna, Austria ",
    },
    {
      'value': 70,
      'label': "Hübner Uhrmachermeister, Graben, Vienna, Austria ",
    },
    {
      'value': 71,
      'label':
          "denkapparat - Photovoltaik Stromspeicher Ökoenergie, Diepersdorf, Austria ",
    },
    {
      'value': 72,
      'label':
          "Bamminger Kraftfahrzeuge GesmbH, Sportplatzstraße, Sattledt, Austria ",
    },
    {
      'value': 73,
      'label':
          "LEHNER'S Bar & Dine, Obertshausener Straße, Laakirchen, Austria ",
    },
    {
      'value': 74,
      'label': "Timberland Store Linz, Hauptplatz, Linz, Austria ",
    },
    {
      'value': 75,
      'label': "Tierra-Tonöfen, 2770, Austria ",
    },
    {
      'value': 76,
      'label':
          "Calma Luxury Villas, Ulica doktor Franje Tuđmana, Starigrad, Croatia ",
    },
    {
      'value': 77,
      'label': "McExpert, Ingenieur-Pesendorfer-Straße, Bad Hall, Austria ",
    },
    {
      'value': 78,
      'label': "Hotel Vienna, Große Stadtgutgasse, Vienna, Austria ",
    },
    {
      'value': 79,
      'label':
          "1a Installateur - Hauer Hubmer GmbH, Hauptstraße, Wartberg an der Krems, Austria ",
    },
    {
      'value': 80,
      'label': "E & S Group, Saint Julian's, Malta ",
    },
    {
      'value': 81,
      'label':
          "Watches & Jewelery Böheim, Linz, Schmidtorstraße, Linz, Austria ",
    },
    {
      'value': 82,
      'label':
          "Honda Magnum, Thomas Datscher KG, Kremstalstraße, Traun, Austria ",
    },
    {
      'value': 83,
      'label': "AH Metallbau, Mozartgasse, Zwentendorf, Austria ",
    },
    {
      'value': 84,
      'label': "Autohaus Seidl, Hafnerstraße, Molln, Austria ",
    },
    {
      'value': 85,
      'label':
          "Autohaus Seidl Gleisdorf - Gebrauchtwagen auf autoseidl.at, Schubertgasse, Gleisdorf, Austria",
    },
    {
      'value': 86,
      'label': "kaufdahoam.at, Linzer Straße, Gmunden, Austria ",
    },
    {
      'value': 87,
      'label': "RENAULT Weiermeier, Jageredtstraße, Nußbach, Austria ",
    },
    {
      'value': 88,
      'label': "BIKE-MASTER, Hauptstraße, Wartberg an der Krems, Austria ",
    },
    {
      'value': 89,
      'label': "Reisinger KFZ, Eisenstraße, Großraming, Austria ",
    },
    {
      'value': 90,
      'label': "APOTHEKE U1 TROSTSTRASSE, Favoritenstraße, Vienna, Austria ",
    },
    {
      'value': 91,
      'label': "Teichbau GmbH, Oberschlierbach, Austria",
    },
    {
      'value': 92,
      'label':
          "AAinFo - Soluções em Informática e tecnologia - Rua Uva Niágara, 50 - Morada das Vinhas, Jundiaí - State of São Paulo, Brazil ",
    },
    {
      'value': 93,
      'label': "Tandy Consulting Inc, North Pomona Avenue, Fullerton, CA, USA ",
    },
    {
      'value': 94,
      'label': "Ours private chef, st. maarten",
    },
    {
      'value': 95,
      'label': "sxm loc, 97150, Saint Martin",
    },
    {
      'value': 96,
      'label': "Nature Animal Hope Hill, 97150, Saint Martin",
    },
    {
      'value': 97,
      'label': "O temps des marques, 97150, Saint Martin ",
    },
    {
      'value': 98,
      'label': "Rainbow Café, Grand-Case, Saint Martin ",
    },
    {
      'value': 99,
      'label':
          "Cabinet kiné Grand Case - Physio Cab BRACH Pierre-Jean, rue franklin laurence, Grand Case, Saint Martin ",
    },
    {
      'value': 100,
      'label':
          "Nature Animal, 209 Rue de Hollande, Marigot 97150, Saint Martin ",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAfrica = const [
    {
      'value': 0,
      'label': 'Select Place in Africa',
    },
    {
      'value': 1,
      'label': "Licoreria Maurapas, El Cují, Lara, Venezuela ",
    },
    {
      'value': 2,
      'label': "Ferretería Armoris, C.A., El Cují, Lara ",
    },
    {
      'value': 3,
      'label': "Multiservicios Barreto, Barquisimeto, Lara ",
    },
    {
      'value': 4,
      'label':
          "Paletas del Norte y algo Más, Avenida Intercomunal Barquisimeto - El Cují, Barquisimeto, Lara ",
    },
    {
      'value': 5,
      'label': "Centro Comercial Sinai, Barquisimeto, Lara ",
    },
    {
      'value': 6,
      'label':
          "A la parrilla Grill Express, Avenida Intercomunal Barquisimeto - Duaca, Tamaca, Lara ",
    },
    {
      'value': 7,
      'label': "Royal Society BarberShop, Calle Queja, Tamaca, Lara ",
    },
    {
      'value': 8,
      'label': "Dulce tentación, Avenida Principal, Tamaca, Lara ",
    },
    {
      'value': 9,
      'label': "Mojito House, Guanare, Portuguesa, Venezuela",
    },
    {
      'value': 10,
      'label': "Pizzas Rafucho, Los Próceres, Guanare, Portuguesa ",
    },
    {
      'value': 11,
      'label': "Inversiones Don Miguelacho, Guanare, Portuguesa ",
    },
    {
      'value': 12,
      'label': "Pidiendo y Comiendo Pizzeria, Calle 9, Guanare, Portuguesa ",
    },
    {
      'value': 13,
      'label': "Makeup Vino, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 14,
      'label': "Inversiones Tecnológicas Lemus C.A., Guanare, Portuguesa ",
    },
    {
      'value': 15,
      'label':
          "Ferretería Don Andrés C.A, Calle Josefa Camejo, Punto Fijo, Falcón ",
    },
    {
      'value': 16,
      'label': "Tu Cuevita Repostera, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 17,
      'label': "Ferreteria Arturo G, Guanare, Portuguesa ",
    },
    {
      'value': 18,
      'label': "Plásticos y Algo Mas CA, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 19,
      'label': "Mucho Más Que Pizza, Guanare, Portuguesa ",
    },
    {
      'value': 20,
      'label':
          "Vespa Shoes Store, entre carrera, Avenida Unda, Guanare, Portuguesa ",
    },
    {
      'value': 21,
      'label':
          "Bodegón RMR, edificio Aura, Carrera 12, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 22,
      'label': "Panda Verde, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 23,
      'label': "Mango de Oro C.A., Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 24,
      'label': "FRUTAS y Mas, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 25,
      'label':
          "Globoland Store, Edificio Colegio Cuatricentenario, Avenida Unda, Guanare, Portuguesa ",
    },
    {
      'value': 26,
      'label': "Inversiones Fermil centro, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 27,
      'label':
          "Inversiones Foncho Peña, Local 08, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 28,
      'label': "Pizzería Unda, Local 12, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 29,
      'label':
          "Mundo de Azúcar, f.p., Avenida Unda, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 30,
      'label': "BODEGON DE LA OCHO, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 31,
      'label':
          "Diseños & creaciones Snarpy, Avenida Unda, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 32,
      'label':
          "Kau Modass Boutique, Avenida Unda, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 33,
      'label': "Kau Kids, Avenida Unda, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 34,
      'label': "El Tinajero Hogar C.A., Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 35,
      'label': "Flamingru, Carrera 6, Guanare, Portuguesa ",
    },
    {
      'value': 36,
      'label':
          "Inversiones Marcelo, C.C. Eustoquio, Calle 12, Guanare, Portuguesa ",
    },
    {
      'value': 37,
      'label':
          "Iluminaciones Alvarez, Carrera 7, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 38,
      'label': "Dulce Panela Cafe, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 39,
      'label': "El Punto Andino, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 40,
      'label': "Café Plaza, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 41,
      'label': "todoimpress C.A., Carrera 5, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 42,
      'label':
          "Zapatería Jkamy Boutique segundo piso local 1, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 43,
      'label': "JKAMY Boutique, Calle 18, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 44,
      'label':
          "Tiendas Artes y Cueros, Calle 18, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 45,
      'label': "Intenxys Boutique, Calle 18, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 46,
      'label': "Koala tecnología, Calle 18, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 47,
      'label': "Evoualji, Guanare, Portuguesa, Venezuela ",
    },
    {
      'value': 48,
      'label':
          "Tu market y algo más C.A, Centro Comercial Cap Conte, Bolívar Avenue, Naguanagua, Carabobo ",
    },
    {
      'value': 49,
      'label': "Krispy Donuts Avenida Bolívar, Valencia, Carabobo, Venezuela ",
    },
    {
      'value': 50,
      'label': "O&J Suministros C.A, San Diego, Carabobo, Venezuela ",
    },
    {
      'value': 51,
      'label':
          "Oxígenos cabriales C.A, Avenida Don Julio Centeno, San Diego, Carabobo, Venezuela ",
    },
    {
      'value': 52,
      'label':
          "Antojitos de Ysabell, C.A, Calle Ricaurte, Valencia, Carabobo, Venezuela ",
    },
    {
      'value': 53,
      'label':
          "Víveres Guacara F.P, Calle Laurencio Silva, Guacara, Carabobo, Venezuela ",
    },
    {
      'value': 54,
      'label':
          "MULTISERVICIOS EL PUENTE II, C.A., Guacara, Carabobo, Venezuela ",
    },
    {
      'value': 55,
      'label': "Comercial LEC C.A, Guacara, Carabobo, Venezuela ",
    },
    {
      'value': 56,
      'label': "La Coromotana C.A, Avenida 110, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 57,
      'label': "Delicateses la Gloria de Dios, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 58,
      'label':
          "Inversiones Georgis JRS CA, Principal, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 59,
      'label': "Herica Nails, 1, Tocuyito, Carabobo ",
    },
    {
      'value': 60,
      'label': "Variedades Mauped C.A, Principal, Tocuyito, Carabobo ",
    },
    {
      'value': 61,
      'label': "Variedades Mis Tesoros, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 62,
      'label':
          "Abasto A Dios JL, Los Chorritos, Calle Las Bateas, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 63,
      'label': "AHOPE Style, Calle Rondon, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 64,
      'label':
          "Inversiones Peña Nuñez 2015 C.A, Tocuyito, Carabobo, Venezuela ",
    },
    {
      'value': 65,
      'label': "Darwinos, Calle 2 Norte, Cucuta, North Santander, Colombia ",
    },
    {
      'value': 66,
      'label': "Inmelozano ca, Calle 17, Ureña, Táchira, Táchira ",
    },
    {
      'value': 67,
      'label': "El Universo Del Churro, San Cristobal, Táchira, Venezuela ",
    },
    {
      'value': 68,
      'label': "Barber Tatto 911, Táriba, Táchira, Venezuela ",
    },
    {
      'value': 69,
      'label':
          "Haru Nails Studio, Troncal 1, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 70,
      'label':
          'Respuestos Pirineos, 5ta. Avenida "Francisco García de Hevia", San Cristóbal, Táchira, Venezuela ',
    },
    {
      'value': 71,
      'label':
          "Centro de Rehabilitación Física Quirón, San Cristobal, Táchira ",
    },
    {
      'value': 72,
      'label': "Kaska-Nueces, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 73,
      'label': "Gigi Playa, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 74,
      'label': "Gürt Cocina Vegetariana, San Cristobal, Táchira ",
    },
    {
      'value': 75,
      'label':
          'Respuestos Pirineos, 5ta. Avenida "Francisco García de Hevia", San Cristóbal, Táchira, Venezuela ',
    },
    {
      'value': 76,
      'label':
          "Papelería Moderna, Séptima Avenida, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 77,
      'label':
          "Inversiones aleksey, Calle 3, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 78,
      'label':
          "Panaderia Y Pasteleria Monquita, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 79,
      'label': "Korea Partes Táchira, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 80,
      'label': "Moto los andes, 4, San Cristóbal 5001, Táchira, Venezuela",
    },
    {
      'value': 81,
      'label': "Mangueras los Molinos, San Cristobal, Táchira ",
    },
    {
      'value': 82,
      'label': "Repuestos Cordillera, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 83,
      'label': "Recol Repuestos, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 84,
      'label':
          "REPUESTOS CANCHICA, Calle 4, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 85,
      'label':
          "Jhony Car's Repuestos, Calle 4 Bis, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 86,
      'label':
          "AUTO REPUESTOS CHERYFORD, Calle 4 Bis, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 87,
      'label':
          "SH GENERICOS Y MAS, Calle 4 Bis, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 88,
      'label': "Auto repuestos Canmar, Calle5, San Cristobal, Táchira ",
    },
    {
      'value': 89,
      'label':
          "ToyoMotors Malpica, Calle 5, La Concordia, San Cristóbal, Táchira ",
    },
    {
      'value': 90,
      'label': "ToyoFord, Calle5, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 91,
      'label':
          "La Principal Renault F-1 C.A, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 92,
      'label':
          "Andina Venezolana del Repuesto, Carrera 6 Bis, San Cristóbal 5001, Táchira, Venezuela ",
    },
    {
      'value': 93,
      'label':
          "Repuestos y Rodamientos REBERCA, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 94,
      'label': "Repuestos Orlando Motos, Calle 5, San Cristobal, Táchira ",
    },
    {
      'value': 95,
      'label': "Cafetin con sabor chacaro, Calle 5 Bis, San Cristóbal, Táchira",
    },
    {
      'value': 96,
      'label':
          "Auto repuestos 2000, Calle 5 Bis, San Cristóbal, Táchira, Venezuela ",
    },
    {
      'value': 97,
      'label': "Repuestos Guayas Car's, Carrera 6 Bis, San Cristobal, Táchira ",
    },
    {
      'value': 98,
      'label':
          "Autopartes Hidalgo Todo Corsa, Avenida Francisco García de Hevia, San Cristobal, Táchira ",
    },
    {
      'value': 99,
      'label': "Repuestos Orlando Motos, Calle 5, San Cristobal, Táchira ",
    },
    {
      'value': 100,
      'label': "AdriCar's, carrera 5, San Cristóbal 5001, Táchira, Venezuela ",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAsia = const [
    {
      'value': 0,
      'label': 'Select Place in Asia',
    },
    {
      'value': 1,
      'label':
          'MOTORCYCLES LOS ANDES C.A, al M. Publico, 5ta. Avenida "Francisco García de Hevia", San Cristobal, Táchira ',
    },
    {
      'value': 2,
      'label':
          "Cerámicas y Materiales Carmire, C.A., 6, Guanarito, Portuguesa ",
    },
    {
      'value': 3,
      'label':
          "Inversiones Densor, Carrera 8, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 4,
      'label': "D Vivas Shop, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 5,
      'label': "La Tiendita GA Saavedra, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 6,
      'label': "Districar, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 7,
      'label':
          "Baby chic Boutique, Carrera 8, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 8,
      'label': "Mundo Repuestos Panda, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 9,
      'label': "Lio's Store, Guanarito, Portuguesa, Venezuela ",
    },
    {
      'value': 10,
      'label': "Cachorra Palma CA, Acarigua, Portuguesa ",
    },
    {
      'value': 11,
      'label': "L'Italia Restaurant, Acarigua, Portuguesa ",
    },
    {
      'value': 12,
      'label': "Fanatic Sport Bar, Calle 31, Acarigua, Portuguesa, Venezuela ",
    },
    {
      'value': 13,
      'label': "Xtremo Julkar 27, C.A.",
    },
    {
      'value': 14,
      'label': "Video Club, Piso 1, Maturín, Monagas, Venezuela ",
    },
    {
      'value': 15,
      'label': "FRUTTY MANIA, Via Viboral, Maturín, Monagas, Venezuela ",
    },
    {
      'value': 16,
      'label':
          "BB Store SERVICE, C.A, Via Viboral, Maturín, Monagas, Venezuela ",
    },
    {
      'value': 17,
      'label':
          "Strong Physical Center, C.A, Via Viboral, Maturín, Monagas, Venezuela ",
    },
    {
      'value': 18,
      'label':
          "La Plata Seguros, C. 9 835, B1900 La Plata, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 19,
      'label':
          "akataka, Guillermo Hudson, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 20,
      'label':
          "Royal Fitness 24hs, Berazategui Centro, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 21,
      'label':
          "Selectos - Café de Especialidad, Reconquista, Buenos Aires, Argentina ",
    },
    {
      'value': 22,
      'label': "Envios Bakanos, Florida, AAI, Buenos Aires, Argentina ",
    },
    {
      'value': 23,
      'label': "Kiosco el Solar, Adolfo Alsina, AAE, Buenos Aires, Argentina ",
    },
    {
      'value': 24,
      'label': "Buenos Aires Footgolf, Campana, Buenos Aires, Argentina ",
    },
    {
      'value': 25,
      'label': "Servir Viajes, Uruguay, Buenos Aires, Argentina ",
    },
    {
      'value': 26,
      'label':
          "Kioscobelisco, Avenida Roque Sáenz Peña, Buenos Aires, Argentina ",
    },
    {
      'value': 27,
      'label':
          "Diego Hernan Farias, ALT, Avenida del Libertador, La Lucila, Buenos Aires Province, Argentina ",
    },
    {
      'value': 28,
      'label': "En El Kiosquito, Carlos Pellegrini, Buenos Aires, Argentina ",
    },
    {
      'value': 29,
      'label': "Capote Grosso Kiosco, Malabia, Buenos Aires, Argentina ",
    },
    {
      'value': 30,
      'label':
          "McCormack Asociados, Arquitectos, Fray Justo Santa María de Oro, FOQ, Buenos Aires, Argentina ",
    },
    {
      'value': 31,
      'label': "Nelly Nieto Malpartida, Sinclair, Buenos Aires, Argentina ",
    },
    {
      'value': 32,
      'label':
          "Kiosco TXV, Avenida General Indalecio Chenaut, Buenos Aires, Argentina",
    },
    {
      'value': 33,
      'label': "Costa Rica 4709 m24, C1414 BSK, Buenos Aires, Argentina",
    },
    {
      'value': 34,
      'label': "Alquilá tu Cancha, Avenida Cabildo, Buenos Aires, Argentina ",
    },
    {
      'value': 35,
      'label':
          "Benjipoint 2 Centro de Copiado, Acevedo, Buenos Aires, Argentina ",
    },
    {
      'value': 36,
      'label': "Benjipoint3, Avenida Corrientes, Buenos Aires, Argentina ",
    },
    {
      'value': 37,
      'label': "Che Bonche, Serrano, Buenos Aires, Argentina ",
    },
    {
      'value': 38,
      'label': "Envíos Bakanos, Serrano 725, Buenos Aires, Argentina ",
    },
    {
      'value': 39,
      'label': "Los Hermanos J C, Miñones, Buenos Aires, Argentina ",
    },
    {
      'value': 40,
      'label': "Shawarma Al-Amir, Montañeses, Buenos Aires, Argentina ",
    },
    {
      'value': 41,
      'label':
          "𝙁𝙧𝙚𝙣𝙘𝙝 𝙘𝙧𝙚̂𝙥𝙚𝙨 𝘽𝘼, Montañeses, Buenos Aires, Argentina ",
    },
    {
      'value': 42,
      'label': "Agencia Cantalupe, Avenida Cabildo, Buenos Aires, Argentina ",
    },
    {
      'value': 43,
      'label':
          "Buena Birra Social Club - Colegiales, Zapiola, Buenos Aires, Argentina ",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosSouthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in South America',
    },
    {
      'value': 1,
      'label': 'Newpoint, Cuyagua, Venezuela',
    },
    {
      'value': 2,
      'label': 'Burger Center, Caracas, Venezuela',
    },
    {
      'value': 3,
      'label': 'metromercados, Heredia, Costa Rica',
    },
    {
      'value': 4,
      'label': 'Kullawa Shop, Cuyagua, Venezuela',
    },
    {
      'value': 5,
      'label': 'Bodegón El Saman Cuyaguero, Cuyagua, Venezuela',
    },
    {
      'value': 6,
      'label': 'Posada Casa Grande, Cuyagua, Venezuela',
    },
    {
      'value': 7,
      'label': 'Pura Vida Cuyagua Surf y Moda Playera, Cuyagua, Venezuela',
    },
    {
      'value': 8,
      'label': "Cacao's Canela, El Castano, Maracay, Venezuela",
    },
    {
      'value': 9,
      'label': "Supermercado Walio, El Castano, Maracay, Venezuela",
    },
    {
      'value': 10,
      'label': "Campo verde minimarket, sector corozal 1, Maracay, Aragua",
    },
    {
      'value': 11,
      'label': "Bossa Café, Avenida Las Delicias, Maracay, Aragua",
    },
    {
      'value': 12,
      'label':
          "Krispy Donuts Coffee & Lunch, Avenida Las Delicias, Maracay, Aragua",
    },
    {
      'value': 13,
      'label': "Noa Noa Show & Cocteles, Avenida Las Delicias, Maracay, Aragua",
    },
    {
      'value': 14,
      'label': "Baraki Bodegon, Maracay, Aragua",
    },
    {
      'value': 15,
      'label': "Supermercado Luxor, Maracay, Aragua",
    },
    {
      'value': 16,
      'label':
          "Krispy Donuts, Zona Postal, Avenida Las Delicias, Maracay, Aragua",
    },
    {
      'value': 17,
      'label': "ORGANI´K, Maracay, Aragua",
    },
    {
      'value': 18,
      'label': "Mahalo poke, Maracay, Aragua",
    },
    {
      'value': 19,
      'label': "Ola Pop Bar, maracay, Aragua",
    },
    {
      'value': 20,
      'label': "La Kolacheria, Aragua",
    },
    {
      'value': 21,
      'label': "Wok Asían Food",
    },
    {
      'value': 22,
      'label': "El conde hotel, Avenida Miranda, Maracay, Aragua",
    },
    {
      'value': 23,
      'label': "Hotel Mar de Plata, Maracay, Aragua",
    },
    {
      'value': 24,
      'label': "Ferreled Center, C.A., Sector Farenachi, Maracay, Aragua",
    },
    {
      'value': 25,
      'label': "Hierro Maracay, Avenida Bolívar, Maracay, Aragua",
    },
    {
      'value': 26,
      'label': "Ferramenta R y S, C.A., Maracay, Aragua",
    },
    {
      'value': 27,
      'label': "Todo Cable Center, C.A., Maracay, Aragua",
    },
    {
      'value': 28,
      'label': "Digitel Estación Central, Maracay, Aragua",
    },
    {
      'value': 29,
      'label': "######################Gtech maracay, Maracay, Aragua",
    },
    {
      'value': 30,
      'label': "RALVIA Maracay, Avenida Los Cedros, Maracay, Aragua",
    },
    {
      'value': 31,
      'label': "Krispy Donuts El Bosque",
    },
    {
      'value': 32,
      'label': "Krispy Donuts Avenida Miranda, Maracay, Aragua",
    },
    {
      'value': 33,
      'label':
          "Krispy Donuts San Jacinto, Zona Postal, Avenida Bolívar, Maracay, Aragua",
    },
    {
      'value': 34,
      'label': "Krispy Donuts La Encrucijada, Turmero, Aragua",
    },
    {
      'value': 35,
      'label': "Ridery, Avenida Andrés Bello, Caracas, Capital District",
    },
    {
      'value': 36,
      'label': "Fruty centro La victoria, La Victoria, Aragua",
    },
    {
      'value': 37,
      'label': "La Lagunita, Aragua",
    },
    {
      'value': 38,
      'label':
          "Restaurante Moritz, Carretera La Victoria - Colonia Tovar, Colonia Tovar, Aragua",
    },
    {
      'value': 39,
      'label': "La Tasquita Mittenwald, Colonia Tovar, Aragua",
    },
    {
      'value': 41,
      'label':
          "La Casita del Chocolate, Carretera Colonia Tovar - La Victoria, Colonia Tovar, Aragua",
    },
    {
      'value': 42,
      'label':
          "Bodegón La Tovareña, Calle principal Codazzi, Colonia Tovar, Aragua",
    },
    {
      'value': 43,
      'label': "Restaurante La Cava, Colonia Tovar, Aragua",
    },
    {
      'value': 44,
      'label': "Chicken Blue, Santa Isabel, La Asuncion, Nueva Esparta ",
    },
    {
      'value': 45,
      'label':
          "Hotel Plaza Royal Margarita, Avenida 4 de Mayo, Porlamar, Nueva Esparta ",
    },
    {
      'value': 46,
      'label':
          "Dr. Beard Barbershop, Calle Jesus Maria Patino, Porlamar, Nueva Esparta ",
    },
    {
      'value': 47,
      'label': "PASTERIA MARGARITA, Porlamar, Nueva Esparta",
    },
    {
      'value': 48,
      'label': "Dolphin crepes, Pampatar, Nueva Esparta ",
    },
    {
      'value': 49,
      'label':
          "Diverland, Avenida Jóvito Villalba, Pampatar, Nueva Esparta, Venezuela ",
    },
    {
      'value': 50,
      'label':
          "Galatea Aesthetics Center, Area Comercial del Hotel MarBellaMar, Avenida Aldonza Manrique, Pampatar, Nueva Esparta ",
    },
    {
      'value': 51,
      'label':
          "Imagen Café, Avenida Jóvito Villalba, Pampatar, Nueva Esparta, Venezuela ",
    },
    {
      'value': 52,
      'label':
          "Margarita Laser Center, Calle El Calvario, Porlamar, Nueva Esparta, Venezuela ",
    },
    {
      'value': 53,
      'label': "Panadería La Gran Reina, Cumana, Sucre ",
    },
    {
      'value': 54,
      'label':
          "Genesis Import C.a, Avenida Bermúdez, Cumaná, Sucre, Venezuela ",
    },
    {
      'value': 55,
      'label': "Centro Comercial La Frontera, Cumana, Sucre ",
    },
    {
      'value': 56,
      'label': "Inversiones El Olivo RC, C.A., Quíbor, Lara",
    },
    {
      'value': 57,
      'label': "Pastello Express, Barquisimeto, Lara ",
    },
    {
      'value': 58,
      'label': "Bodegón Los Tesoros de Papá, Barquisimeto, Lara ",
    },
    {
      'value': 59,
      'label': "Centro Comencial Socialista Bequito, Barquisimeto, Lara ",
    },
    {
      'value': 60,
      'label': "MUNDO FRIO R C.A, C. 27, Barquisimeto 3001, Lara, Venezuela ",
    },
    {
      'value': 61,
      'label':
          "Inversiones Lara Partes C.A, Venta de Repuestos para Carros Jeep, Dodge y Chrysler. Repuestos Originales Mopar. Barquisimeto, Edo. Lara, Barquisimeto, Lara ",
    },
    {
      'value': 62,
      'label': "Nexus INC C.A, Barquisimeto, Lara ",
    },
    {
      'value': 63,
      'label': "Inversiones Invica, Barquisimeto, Lara ",
    },
    {
      'value': 64,
      'label': "Distribuidora Olivo C.A, Calle 33, Barquisimeto, Lara ",
    },
    {
      'value': 65,
      'label': "comercial monalisa 3000, Barquisimeto, Lara ",
    },
    {
      'value': 66,
      'label': "Cosasdulcesbqto, Calle 24, Barquisimeto, Lara ",
    },
    {
      'value': 67,
      'label': "Distribuidora El Gran Pollo, Barquisimeto, Lara ",
    },
    {
      'value': 68,
      'label': "Heladería ozuna, Barquisimeto, Lara, Venezuela ",
    },
    {
      'value': 69,
      'label':
          "Panificadora Los Chaguaramos C.A., Av Carabobo, Barquisimeto, Lara ",
    },
    {
      'value': 70,
      'label': "Ferremetale.l, C.A, Barquisimeto, Lara ",
    },
    {
      'value': 71,
      'label': "URBE PRODUCCIONES, C.A., Barquisimeto, Lara ",
    },
    {
      'value': 72,
      'label': "BRIZUELA 2000 COSMOS C.A, Barquisimeto, Lara ",
    },
    {
      'value': 73,
      'label': "Brooklyn 1990, Avenida 20, Barquisimeto, Lara ",
    },
    {
      'value': 74,
      'label': "Sandy's gourmet c.a, Barquisimeto, Lara ",
    },
    {
      'value': 75,
      'label': "Distribuidora El Gran Yo Soy 33, C.A, Barquisimeto, Lara ",
    },
    {
      'value': 76,
      'label': "Boss Store, Avenida 20, Barquisimeto, Lara",
    },
    {
      'value': 77,
      'label': "Inversiones Masshopping, Barquisimeto, Lara",
    },
    {
      'value': 78,
      'label': "Teque Brother's Kairos, Calle 28, Barquisimeto, Lara",
    },
    {
      'value': 79,
      'label':
          "Panadería y pastelería la bendición VP, Carrera 28, Barquisimeto, Lara ",
    },
    {
      'value': 80,
      'label': "Dulces y algo más, Calle 25, Barquisimeto, Lara ",
    },
    {
      'value': 81,
      'label': "Bodega la 30, Barquisimeto, Lara ",
    },
    {
      'value': 82,
      'label': "Gordo Burguer, Carrera 28, Barquisimeto, Lara ",
    },
    {
      'value': 83,
      'label': "Heladeria Mi Antojito, Carrera 31, Barquisimeto, Lara ",
    },
    {
      'value': 84,
      'label': "Valeth13maquillaje, Barquisimeto, Lara ",
    },
    {
      'value': 85,
      'label': "Arabissimoo restaurant, Troncal7, Barquisimeto, Lara ",
    },
    {
      'value': 86,
      'label': "La Barbería style, Avenida Concordia, Barquisimeto, Lara ",
    },
    {
      'value': 87,
      'label': "La Pizzería del Este, Carrera 1, Barquisimeto, Lara ",
    },
    {
      'value': 88,
      'label': "Eagle Store, 8, Barquisimeto, Lara ",
    },
    {
      'value': 89,
      'label': "Sambil Barquisimeto, Barquisimeto, Lara ",
    },
    {
      'value': 90,
      'label': "LR Barber Studio, Pizza de Verdad, Barquisimeto, Lara ",
    },
    {
      'value': 91,
      'label': "Floristería El Chalet de mis Flores, Barquisimeto, Lara ",
    },
    {
      'value': 92,
      'label':
          "EL PARAÍSO • Panadería & Market, Avenida Caroní, Barquisimeto, Lara ",
    },
    {
      'value': 93,
      'label': "11:11 Sport Bar Restaurant, Barquisimeto, Lara ",
    },
    {
      'value': 94,
      'label': "Kilauea, Avenida Caracas, Barquisimeto, Lara ",
    },
    {
      'value': 95,
      'label': "Marketmon, Calle Guatopo, Barquisimeto, Lara ",
    },
    {
      'value': 96,
      'label':
          "Mr mascotas, planta baja cc.trinitarias, local 25g, Barquisimeto, Lara ",
    },
    {
      'value': 97,
      'label': "Mavi lingerie, Barquisimeto, Lara ",
    },
    {
      'value': 98,
      'label': "Agüita Fresca, Barquisimeto, Lara ",
    },
    {
      'value': 99,
      'label': "ANACOCO FOOD, de, calle 1, Barquisimeto, Lara ",
    },
    {
      'value': 100,
      'label': "Ysifran Moto, El Cují, Lara",
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
    },
    {
      'value': 51,
      'label':
          "Abracadabra Juguetes, Manzanares 2060, C1429 Buenos Aires, Argentina",
    },
    {
      'value': 52,
      'label':
          "Fun Over Fifty Holidays - Immersive tours & adventures, Murrajong Road, Springwood QLD, Australia",
    },
    {
      'value': 53,
      'label':
          "Tecnoaguas Tratamiento de Efluentes, General Juan Lavalle, Villa Martelli, Buenos Aires Province, Argentina ",
    },
    {
      'value': 54,
      'label': "vouka, Afitos, Halkidiki, Greece",
    },
    {
      'value': 55,
      'label': "Ying Bin, Hendrik Consciencestraat, Mechelen, Belgium",
    },
    {
      'value': 56,
      'label':
          "Nixcome, La Retama, Naucalpan de Juárez, State of Mexico, Mexico",
    },
    {
      'value': 57,
      'label': "Studio Cerámica, Calle Bermúdez, Estepona, Spain",
    },
    {
      'value': 58,
      'label':
          "AltePay - Buy and Sell cryptocurrencies for cash (crypto exchange), Cēsu iela, Vidzeme Suburb, Riga, Riga, Latvia",
    },
    {
      'value': 59,
      'label':
          "Palma Central, Av. Kukulkan 6, Palma Central, 77760 Tulum, Q.R., México",
    },
    {
      'value': 60,
      'label': "Masia Villalonga, L'Alcora, Spain",
    },
    {
      'value': 61,
      'label': "Subway, Gleisstraße, Hockenheim, Germany",
    },
    {
      'value': 62,
      'label': "PIANO RESIDENCE, Jána Milca, Žilina, Slovakia ",
    },
    {
      'value': 63,
      'label': "LOW COST WI-FI® Huelva S.L.U., Cartaya, Spain",
    },
    {
      'value': 64,
      'label': "bla",
    },
    {
      'value': 65,
      'label':
          "SPAZIO ENEL PARTNER ROMA, Via della Lega Lombarda, Rome, Metropolitan City of Rome, Italy",
    },
    {
      'value': 66,
      'label':
          "Spazio Enel Partner Roma Via Cipriano Facchinetti 60, Via Cipriano Facchinetti, Rome, Metropolitan City of Rome, Italy ",
    },
    {
      'value': 67,
      'label': "Motorova koloběžka.eu, Lonkova, Pardubice II, Czechia",
    },
    {
      'value': 68,
      'label':
          "Juicefly Wine & Spirits | Alcohol & Vape Delivery, Jefferson Boulevard, Culver City, CA, USA",
    },
    {
      'value': 69,
      'label':
          "Sea Breeze ซีฟู้ด, ถนน พระรามที่ 6 Samsen Nai, Phaya Thai, Bangkok, Thailand",
    },
    {
      'value': 70,
      'label': "The Gibraltar, Perú, Buenos Aires, Argentina",
    },
    {
      'value': 71,
      'label': "Paralelní Polis, Dělnická, Prague 7-Holešovice, Czechia",
    },
    {
      'value': 72,
      'label':
          "Achrainer-Moosen | Urlaub am Bio-Bauernhof / Ferienwohnung / Appartment, Grafenweg 36, 6361 Grafenweg, Tirol, Austria",
    },
    {
      'value': 73,
      'label': "Roma Restaurant & Hotel, Libreville, Gabon",
    },
    {
      'value': 74,
      'label':
          "InstaCrypto.In, 9th Main Rd, Vyalikaval, Kodandarampura, Malleswaram, Bengaluru, Karnataka, India ",
    },
    {
      'value': 75,
      'label':
          "जिप्सीबुद, Gypsybud Street, Gandhi Nagar, Jaipur, Rajasthan, India",
    },
    {
      'value': 76,
      'label': "BTC Wine, Rue Notre Dame, Bordeaux, France",
    },
    {
      'value': 77,
      'label':
          "Munchies Smokehouse and Bar, Paseo Marítimo Rey de España, 43, 29640 Fuengirola, Málaga, Spain ",
    },
    {
      'value': 78,
      'label': "Walmart Supercenter, South Robert Street, Saint Paul, MN, USA",
    },
    {
      'value': 79,
      'label': "Masseria Le Lamie, Villa Castelli, BR, Italy",
    },
    {
      'value': 80,
      'label':
          "Su Bici - La Palma Active, 38712 Los Cancajos, Canary Islands, Spain",
    },
    {
      'value': 81,
      'label':
          "Alfa Vidrios y Aberturas, Coronel Pringles 2042, BHY, Ituzaingó, Buenos Aires, Argentina",
    },
    {
      'value': 82,
      'label': "La Dulce parada, Ramon y Cajal, Valencia, Spain",
    },
    {
      'value': 83,
      'label': "Wallaroo Media, 78 W Center St, Provo, UT 84601, USA ",
    },
    {
      'value': 84,
      'label': "ERP-Solutions GmbH, Waasen, Austria",
    },
    {
      'value': 85,
      'label':
          "Múscari Empresario Distribuidor, Carrera 44, Cali, Valle del Cauca, Colombia",
    },
    {
      'value': 86,
      'label': "PROMOCIONES Y GESTION INMOBILIARIA ALBOLUNCA S.L, Vera, Spain",
    },
    {
      'value': 87,
      'label':
          "Kingofood.com, Via Cassia, 52047 Marciano della Chiana, Province of Arezzo, Italy",
    },
    {
      'value': 88,
      'label':
          "Lañin Amoblamientos, Libertad 1034, AAV, Buenos Aires, Argentina",
    },
    {
      'value': 89,
      'label':
          "791 Hotel, Ingeniero Jacobacci, Las Grutas, Río Negro, Argentina",
    },
    {
      'value': 90,
      'label':
          "MG Mesón Galea Torrevieja - Aceptamos Bitcoin, Calle Cerezo, 515, 03184 Torrevieja, Alicante, España ",
    },
    {
      'value': 91,
      'label': "EM1191 13-6, Loulé, Portugal ",
    },
    {
      'value': 92,
      'label':
          "Casa Monte Isabel, Calle 8, Provincia de Puntarenas, Monteverde, Costa Rica ",
    },
    {
      'value': 93,
      'label': "Ecotros, L'Ametlla de Mar, Tarragona, España",
    },
    {
      'value': 94,
      'label':
          "Olé Idiomas, Torre D - Avenida Chedid Jafet - Vila Olímpia, São Paulo - State of São Paulo, Brazil",
    },
    {
      'value': 95,
      'label': "Nasau Resort & Villas, Nadi, Fiji",
    },
    {
      'value': 96,
      'label': "WorldWideAuto, Avinguda de Ramón y Cajal, Tarragona, España",
    },
    {
      'value': 97,
      'label':
          "Complejo Doña Olga, Santa Cruz, La Rioja, La Rioja Province, Argentina",
    },
    {
      'value': 98,
      'label':
          "Max Home Alava Sl, Alto de Armentia Kalea, 10, Vitoria-Gasteiz, Álava, España ",
    },
    {
      'value': 99,
      'label':
          "Australian Rock Walls, 37 Township Drive, Burleigh Heads QLD, Australia ",
    },
    {
      'value': 100,
      'label':
          "Filippo Esmaily Photography, Boulevard de la Fraternité, Luxembourg",
    }
  ];
}
