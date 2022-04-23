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
      'label':
          "Diljeet Auto Parts, Kuchesar Road, near HP Petrol Pump, B.B. Nagar, Uttar Pradesh, India ",
    },
    {
      'value': 3,
      'label':
          "HTML ECOSYSTEM, Block AG, Sanjay Gandhi Transport Nagar, Delhi, India ",
    },
    {
      'value': 4,
      'label': "NottyBoy® (Oddway Icare Private Limited) ",
    },
    {
      'value': 5,
      'label': "Digi195, Prem Nagar, Najafgarh, Delhi, India ",
    },
    {
      'value': 6,
      'label':
          "Advertising & Public Relations Branch, New Delhi, Delhi, India ",
    },
    {
      'value': 7,
      'label':
          "DailyVery Grocery mart, South Bopal, Ahmedabad, Gujarat, India ",
    },
    {
      'value': 8,
      'label':
          "Shah Property Solution, Jahangirabad, Sima Nagar, Surat, Gujarat, India ",
    },
    {
      'value': 9,
      'label':
          "Radha krishna textile Market, Jay Laxmi Market, Moti Begumwadi, Begampura, Surat, Gujarat, India ",
    },
    {
      'value': 10,
      'label':
          "B&Z LUXURY WORLD LLP, 1ST CROSS LANE, Swami Samarth Nagar, Lokhandwala Complex, Andheri West, Mumbai, Maharashtra, India ",
    },
    {
      'value': 11,
      'label':
          "Kino Cottage, Aram Nagar, Versova, Andheri West, Mumbai, Maharashtra, India ",
    },
    {
      'value': 12,
      'label':
          "Hosanna House Montessori, Veera Desai Road, Mhada Colony, Azad Nagar, Andheri West, Mumbai, Maharashtra, India ",
    },
    {
      'value': 13,
      'label':
          "Haute Dog Pet Salon & Boutique Store, Jukarwadi, Juhu, Mumbai, Maharashtra, India ",
    },
    {
      'value': 14,
      'label':
          "Copa, North South Road Number 13, Gaothan Number 2, Vithal Nagar, Juhu, Mumbai, Maharashtra, India ",
    },
    {
      'value': 15,
      'label':
          "Sunder Niwas, Malviya Road, Satsang CHSL, Navpada, Vile Parle East, Vile Parle, Mumbai, Maharashtra, India ",
    },
    {
      'value': 16,
      'label':
          "Paramount sports n nutrition, Road Number 18, Chembur Gaothan, Chembur, Mumbai, Maharashtra, India ",
    },
    {
      'value': 17,
      'label':
          "VIG Refreshments, Camp East, Chembur Colony, Chembur, Mumbai, Maharashtra, India ",
    },
    {
      'value': 18,
      'label':
          "Jo Hukum Mere Aaka, M G Road, Laxminagar, Khopoli, Maharashtra, India ",
    },
    {
      'value': 19,
      'label':
          "Bharat Adventure Tours, Shivaji Colony, Tilakwadi, Belagavi, Karnataka, India ",
    },
    {
      'value': 20,
      'label': "Black Bull Goa, Anjuna, Goa, India ",
    },
    {
      'value': 21,
      'label': "Mish-Mar, Majorda-Utorda, Dongorim, Margao, Goa, India ",
    },
    {
      'value': 22,
      'label': "Squirr Salon & Spa, Poovangal, Kozhikode, Kerala, India",
    },
    {
      'value': 23,
      'label': "Kookal Paradise, Kodaikanal, Tamil Nadu, India ",
    },
    {
      'value': 24,
      'label': "Club India Resorts, Poombarai, Tamil Nadu, India ",
    },
    {
      'value': 25,
      'label':
          "Passiflora Ristorante Italiano, Mannavanur to Kodaikanal Rd, Poombarai, Tamil Nadu 624103, India ",
    },
    {
      'value': 26,
      'label':
          "Boho Kodai, Thomas Summer House, Kurunji Nagar Road, Kodaikanal, Tamil Nadu, India ",
    },
    {
      'value': 27,
      'label':
          "The Craft Chain, Club Rd, Kodaikanal, Tamil Nadu 624101, India ",
    },
    {
      'value': 28,
      'label': "VJ Organic farms, Taluka, Hadoli, Maharashtra, India ",
    },
    {
      'value': 29,
      'label':
          "Sankar Srinivasan, Muthu cycle traders, Kulamangalam Main Road, Bama Nagar, Meenambalpuram, Tamil Nadu, India ",
    },
    {
      'value': 30,
      'label':
          "K9 Connection, Kalakruti Avenue, Hanuman Colony, Royal Enclave Extn, Sakthi Vinayakar Nagar, Injambakkam, Chennai, Tamil Nadu, India ",
    },
    {
      'value': 31,
      'label':
          "FIB-SOL Life Technologies Pvt. Ltd., OMR Road, Perungudi, Chennai, Tamil Nadu, India ",
    },
    {
      'value': 32,
      'label': "SMS ENTERPRISES, Mahalakshmi Layout, Kolar, Karnataka, India ",
    },
    {
      'value': 33,
      'label':
          "R N S Bikes Sales & Service, Venkatamma Layout, Subbayianiah Palyam, Kammanahalli, Bengaluru, Karnataka, India ",
    },
    {
      'value': 34,
      'label':
          "Tracy Tech Works, beside MRO Office, Ajit Singh Nagar, PNT Colony, Vijayawada, Andhra Pradesh 520015, India ",
    },
    {
      'value': 35,
      'label':
          "Samyuktha's Designer Studio, Kistamma Enclave, Alwal, Hyderabad, Telangana, India ",
    },
    {
      'value': 36,
      'label':
          "Chandra Bar and Restaurant, New Bustand, Korutla, Telangana, India ",
    },
    {
      'value': 37,
      'label': "Vilas avhad, Tadlimbla, Maharashtra, India ",
    },
    {
      'value': 38,
      'label':
          "SUNRISE SPORTS, near maharaja statue, Paralakhemundi, Odisha, India ",
    },
    {
      'value': 39,
      'label': "Tapas Jharsuguda, Odisha, India",
    },
    {
      'value': 40,
      'label':
          "Self employed, Dada Nagar, Azad Nagar, Kanpur, Uttar Pradesh, India ",
    },
    {
      'value': 41,
      'label':
          "Azhar Textiles, National Highway 33, Nathnagar, Bhagalpur, Bihar, India ",
    },
    {
      'value': 42,
      'label':
          "Dhan Lakshmi, Canning Street, Bagree Market, Bortola, Barabazar Market, Kolkata, West Bengal, India ",
    },
    {
      'value': 43,
      'label':
          "Couch Potato, Abhedananda Road, Girish Park, Darjipara, Ward Number 17, Kolkata, West Bengal, India ",
    },
    {
      'value': 44,
      'label':
          "CryptoKon IT & Consultancy Services, Pioneer Park, Chkravartipara, Barasat, Kolkata, West Bengal, India ",
    },
    {
      'value': 45,
      'label':
          "Fancy Bedding Store, Pundooah Station Road, Pandua, West Bengal, India ",
    },
    {
      'value': 46,
      'label': "Ar veraities store, Captain Monir Road, Cumilla, Bangladesh ",
    },
    {
      'value': 47,
      'label': "Ashuran Jame Masjid, Bangladesh ",
    },
    {
      'value': 48,
      'label': "IT Soft Ltd, Katasur Road, Dhaka, Bangladesh ",
    },
    {
      'value': 49,
      'label':
          "ওয়েস্টার্ন ইউনিয়ন মানি ট্রান্সফার, Begum Rokeya Avenue, Dhaka, Bangladesh ",
    },
    {
      'value': 50,
      'label': "RFL Best Buy - Uttara 10, Dhaka, Bangladesh ",
    },
    {
      'value': 51,
      'label':
          "DISCOUNT STORE, Lukram Leirak Rd, Mayaikoibi, Imphal, Manipur, India ",
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
          "Satoshi House, 236 Pasakhangwaeng Waeng Chiang Rai 57150 TH, Ban Pasakhangwaeng Waeng, Chiang Saen District, 57150, Thailand",
    },
    {
      'value': 2,
      'label':
          "Catmosphere Cat Café, 233/5 Huay Kaew Rd, Suthep, Mueang Chiang Mai District, Chiang Mai 50300, Thailand ",
    },
    {
      'value': 3,
      'label':
          "บ้านไร่ ส.ทรัพย์รุ่งเรือง KM. ไร่​ ส.ทรัพย์​รุ่งเรือง​ KM DPT. Alley, Ban Mai, Si Chomphu District, Khon Kaen, Thailand ",
    },
    {
      'value': 4,
      'label':
          "ບ້ານຊຳຄອນ, ເມືອງລ້ອງຊານ, ແຂວງໄຊ​ສົມບູນ Meung Hom ເມືອງລ້ອງຊານ ແຂວງໄຊ​ສົມບູນ Vientiane, Laos ",
    },
    {
      'value': 5,
      'label':
          "vuhaison doanh nghiep nho, Lý Thường Kiệt, Thành phố Yên Bái, Yên Bái, Viet Nam ",
    },
    {
      'value': 6,
      'label':
          "Agribank phòng giao dịch Nguyễn Trãi, Đường Nguyễn Trãi, Thượng Đình, Thanh Xuân, Hà Nội, Việt Nam ",
    },
    {
      'value': 7,
      'label':
          "Agribank - Atm, Nguyễn Trãi, Sao Do, Chí Linh, Hải Dương, Việt Nam ",
    },
    {
      'value': 8,
      'label':
          "Agribank Chi nhánh Đại Tân, Hoàng Tân, Chí Linh District, Hai Duong, Vietnam ",
    },
    {
      'value': 9,
      'label':
          "Mc Khánh Duy, An Định, Thụy Văn, Thái Thụy, Thai Binh, Vietnam ",
    },
    {
      'value': 10,
      'label': "Pilgrim's Kitchen & Inn, Savannakhet, Laos ",
    },
    {
      'value': 11,
      'label':
          "SA เฉลิมวงค์ Chiang Yuen, Chiang Yuen District, Maha Sarakham 44160, Thailand ",
    },
    {
      'value': 12,
      'label':
          "Melody Buffet BBQ, Lê Đức Thọ, Thọ Quang, Sơn Trà, Đà Nẵng, Viet Nam ",
    },
    {
      'value': 13,
      'label':
          "YOLO Apartment Homes, Trần Bạch Đằng, Phước Mỹ, Sơn Trà, Đà Nẵng, Vietnam ",
    },
    {
      'value': 14,
      'label':
          "COMPANY LIMITED TRADING HONG AN Import Export Service, Hồ Văn Leo, khu phố 1 p, Tam Hòa, Thành phố Biên Hòa, Dong Nai, Vietnam ",
    },
    {
      'value': 15,
      'label':
          "Sofa Êm, Cityland Center Hills, Phường 7, Gò Vấp, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 16,
      'label': "Sofa Êm, Nguyễn An Ninh, Vũng Tàu, Ba Ria - Vung Tau, Vietnam ",
    },
    {
      'value': 17,
      'label':
          "Future.Travel, Shop 6, Đường Lê Văn Huân, Phường 13, Tân Bình, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 18,
      'label':
          "Bitcoin ATM by BitcoinVN, Hưng Gia 3, Tân Phong, District 7, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 19,
      'label':
          "Bitcoin ATM by BitcoinVN, Located inside Italiani's Pizza, Hàn Thuyên, Bến Nghé, District 1, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 20,
      'label':
          "Bitcoin ATM by BitcoinVN, Pizza 8, Đường số 49B, Khu Phố 4, Thao Dien, District 2, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 21,
      'label':
          "Bitcoin ATM by BitcoinVN, Pig BBQ & Beer, Truong Son Street, Phường 2, Tân Bình, Ho Chi Minh City, Vietnam ",
    },
    {
      'value': 22,
      'label':
          "Italiani's Pizza Han Thuyen, Bến Nghé, Ho Chi Minh, Hồ Chí Minh, Việt Nam ",
    },
    {
      'value': 23,
      'label':
          "Shop Men Fashion, Đường Độc Lập, Phú Mỹ, Tân Thành, Ba Ria - Vung Tau, Vietnam ",
    },
    {
      'value': 24,
      'label': "Kep Coffee, Krong Kaeb, Cambodia ",
    },
    {
      'value': 25,
      'label': "Karma Traders Kampot, Red Rd, Krong Kampot, Cambodia ",
    },
    {
      'value': 26,
      'label': "Lao Sreyneang Shop, Phnom Penh, Cambodia ",
    },
    {
      'value': 27,
      'label': "Burgershack, Street 51, Phnom Penh, Cambodia ",
    },
    {
      'value': 28,
      'label':
          "KOOMPI Boran & Research Lab, Preah Ang Yukanthor Street (19), Phnom Penh, Cambodia ",
    },
    {
      'value': 29,
      'label': "Treetop Bungalows, Wat Svay Road, Krong Siem Reap, Cambodia ",
    },
    {
      'value': 30,
      'label':
          "My Pattaya Condo, Kasetsin, Pattaya City, Bang Lamung District, Chon Buri, Thailand ",
    },
    {
      'value': 31,
      'label':
          "Pattaya Beer Garden Beach Rd, Pattaya City, Bang Lamung District, Chon Buri 20260, Thailand ",
    },
    {
      'value': 32,
      'label':
          "Let's Hyde 4 Star Resort & Villas, ถนน พัทยา-นาเกลือ 18/2 ตำบล นาเกลือ Bang Lamung District, Chon Buri, Thailand ",
    },
    {
      'value': 33,
      'label':
          "ปูไข่ดองคลองขลุง บางนา, King Kaew 37 Alley, Racha Thewa, Bang Phli District, Samut Prakan, Thailand ",
    },
    {
      'value': 34,
      'label': "Thailand, Bangkok, Sukhumvit Road, JINGI ",
    },
    {
      'value': 35,
      'label':
          "AwesomeSauce Truck, ถนน สุขุมวิท Phra Khanong Nuea, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 36,
      'label':
          "AwesomeSauce Truck (Habito Mall) Habito Road, Phra Khanong Nuea, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 37,
      'label':
          "Washcoin​ Plus​ สาขา Plum Rangsit Alive 1 ตึก A Khlong Nueng, Khlong Luang District, Pathum Thani, Thailand ",
    },
    {
      'value': 38,
      'label':
          "Washcoin Plus วงศ์สว่าง11 Wong Sawang 11 Alley, Wong Sawang, Bang Sue, Bangkok, Thailand ",
    },
    {
      'value': 39,
      'label':
          "WashCoin Plus สาขา เอกสินคอนโด ตึก D Ngamwongwarn 23 Alley, Lane 8, Bang Khen, Mueang Nonthaburi District, Nonthaburi, Thailand ",
    },
    {
      'value': 40,
      'label':
          "WashCoin Plus สาขา เกกีงาม 3 (พระจอมเกล้าฯลาดกระบัง) ซอย เกกีงาม 3 Lat Krabang, Bangkok, Thailand ",
    },
    {
      'value': 41,
      'label':
          "หลักสองยางยนต์ LS Auto, Phet Kasem 65/2 Alley, Road, Bang Khae, Bangkok, Thailand ",
    },
    {
      'value': 42,
      'label':
          "Trimers the barbershop Bang Krasaw, Mueang Nonthaburi District, Nonthaburi, Thailand ",
    },
    {
      'value': 43,
      'label':
          "Boom&Boom salon ซอย81/1 ถนนเพชรเกษม แขวงหนองค้างพลู Nong Khaem, Bangkok, Thailand ",
    },
    {
      'value': 44,
      'label':
          "Inner Beauty - อินเนอร์บิวติ้, Sutthisan Winitchai Road, Samsen Nok, Huai Khwang, Bangkok, Thailand ",
    },
    {
      'value': 45,
      'label':
          "Landhaus Bakery Phahon Yothin 5, Samsen Nai, Phaya Thai, Bangkok, Thailand ",
    },
    {
      'value': 46,
      'label':
          "Bitcoin Center Thailand Bang Kapi, Huai Khwang, Bangkok, Thailand ",
    },
    {
      'value': 47,
      'label':
          "KOSY Massage & Cut, Soi Sukhumvit 23, Khlong Toei Nuea, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 48,
      'label':
          "Aspire, Sukhumvit Soi 16, Y SPA, Khlong Toei, Bangkok, Thailand ",
    },
    {
      'value': 49,
      'label':
          "MASH craft brews & bites, Convent Road, Silom, Bang Rak, Bangkok, Thailand ",
    },
    {
      'value': 50,
      'label':
          "The New Yorker Cafe, Sukhumvit Soi 22, Khlong Toei, Bangkok, Thailand ",
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
