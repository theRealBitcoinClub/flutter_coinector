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
    },
    {
      'value': 1,
      'label': "CARLO UOMO, Bogota, Colombia ",
    },
    {
      'value': 2,
      'label':
          "Fast Food Cachorros Asados, Carrera 56, Cali, Valle del Cauca, Colombia ",
    },
    {
      'value': 3,
      'label': "FUNCTIONAL BOX, Cali, Valle, Colombia ",
    },
    {
      'value': 4,
      'label': "Baby Premium, Carrera 11, Popayán, Cauca, Colombia ",
    },
    {
      'value': 5,
      'label': "SPA Motos Racing, Calle 8, Popayán, Cauca, Colombia ",
    },
    {
      'value': 6,
      'label':
          "CASA BLANCA Eventos Popayán, Calle 6, Popayán, Cauca, Colombia ",
    },
    {
      'value': 7,
      'label': "Vida Sana, Pasto, Narino, Colombia ",
    },
    {
      'value': 8,
      'label': "ILAR Arte+Diseño, Pasto, Nariño, Colombia ",
    },
    {
      'value': 9,
      'label': "Hostel Coco Loco, Canoa, Manabí, Ecuador ",
    },
    {
      'value': 10,
      'label': "Hotel San Antonio, Jr. Amazonas, Bagua, Peru ",
    },
    {
      'value': 11,
      'label': "PCGerente, Guayaquil, Ecuador ",
    },
    {
      'value': 12,
      'label': "DediSpace Networks, Manzana 6, Guayaquil, Ecuador ",
    },
    {
      'value': 13,
      'label': "Inter Apart Hotel, Salta - Capital, Salta Province, Argentina ",
    },
    {
      'value': 14,
      'label':
          "Agua de Mar Salta, Avenida San Martín, Salta, Salta Province, Argentina ",
    },
    {
      'value': 15,
      'label': "La Colchagüina - Avenida Rafael Casanova, Santa Cruz, Chile ",
    },
    {
      'value': 16,
      'label':
          "Panadería Dos Espigas, Avellaneda, Guaymallén, Mendoza, Argentina ",
    },
    {
      'value': 17,
      'label': "Mecpro - Rubén Barrales, Lo Barnechea, Chile ",
    },
    {
      'value': 18,
      'label':
          "Lavado de Autos Luminswash - Avenida El Peral, Santiago, Puente Alto, Chile ",
    },
    {
      'value': 19,
      'label':
          "Funerária Sociedade Paz na Eternidade - Passagem São Benedito - Sacramenta, Belém - PA, Brasil ",
    },
    {
      'value': 20,
      'label':
          "RMB Informática - Rua Padre Antônio Cassiano Da Silva - Quintas, Natal - State of Rio Grande do Norte, Brazil ",
    },
    {
      'value': 21,
      'label':
          "Rafaela Costa Estúdio Fotográfico - Alameda Engenheiro João Corner - Colubandê, São Gonçalo - State of Rio de Janeiro, Brazil ",
    },
    {
      'value': 22,
      'label':
          "Fisk Inglês e Espanhol - Rua Boticário Moncorvo - Centro, Feira de Santana - BA, Brasil ",
    },
    {
      'value': 23,
      'label':
          "MODA & CIA boutique - Praça Sebastião Alves - Cruzeiro Azul, Turmalina - State of Minas Gerais, Brazil ",
    },
    {
      'value': 24,
      'label':
          "FreeBSD Brasil - Av. Getúlio Vargas, 54 - Funcionários, Belo Horizonte - State of Minas Gerais, Brasil ",
    },
    {
      'value': 25,
      'label':
          "FULL STORE / Super Decorada / Arezzo - Rua Coronel Honório Palma - Centro, Altinópolis - State of São Paulo, Brazil ",
    },
    {
      'value': 26,
      'label':
          "Fast Brand - Backdrop RJ | Comunicação Visual - Rua Francisco de Sousa - Bento Ribeiro, Rio de Janeiro - State of Rio de Janeiro, Brazil ",
    },
    {
      'value': 27,
      'label':
          "Manacá Prumirim B&B, BR101 Condomínio Prumirim - Vereda Três - Prumirim Beach, Ubatuba - State of São Paulo, Brazil ",
    },
    {
      'value': 28,
      'label':
          "Restaurante Mestiço - Rua Fernando de Albuquerque - Consolação, São Paulo - SP, Brasil ",
    },
    {
      'value': 29,
      'label':
          "My Sushi Restaurante Indaiatuba - Avenida Presidente Vargas - Cidade Nova I, Indaiatuba - State of São Paulo, Brazil ",
    },
    {
      'value': 30,
      'label': "ATM Digital - Certificado Digital por Videoconferência ",
    },
    {
      'value': 31,
      'label':
          "RCC SUSTENTABILIDADE - Rua Sana Vermelha - Jardim Columbia IV, Arapongas - PR, Brasil ",
    },
    {
      'value': 32,
      'label':
          "Moper Coated & Decor - Rua Hayel Bon Faker - Centro, Dourados - State of Mato Grosso do Sul, Brazil ",
    },
    {
      'value': 33,
      'label':
          "Percus Assessoria de Marketing Digital - Centro, Dourados - State of Mato Grosso do Sul, Brazil ",
    },
    {
      'value': 34,
      'label':
          "Poran Cafés Especiais - Rua Tamoios - Vila Izabel, Curitiba - State of Paraná, Brazil ",
    },
    {
      'value': 35,
      'label':
          "Barbearia Steel Pulse - Rua Professor Dário Veloso - Vila Izabel, Curitiba - State of Paraná, Brazil ",
    },
    {
      'value': 36,
      'label':
          "Pé na Areia, Prainha, Arraial do Cabo. - Rua José Pinto de Macedo - Centro, Arraial do Cabo - State of Rio de Janeiro, Brazil ",
    },
    {
      'value': 37,
      'label': "Mini Market DS, C.A, Maiquetía, Vargas ",
    },
    {
      'value': 38,
      'label':
          "Bitcoin.com.py Compra y Venta de Bitcoins, Teniente Héctor Vera, Asunción, Paraguay ",
    },
    {
      'value': 39,
      'label': "McKickz ®, Briggate, Leeds, UK ",
    },
    {
      'value': 40,
      'label': "Karma Arts Ltd, Queens Arcade, Leeds, UK ",
    },
    {
      'value': 41,
      'label': "Phone Clinic, Briggate, Leeds, UK ",
    },
    {
      'value': 42,
      'label':
          "Inversiones Sandy, F.P., Mercado Cacique Maiquetia, Pasillo 3, Maiquetía, Vargas ",
    },
    {
      'value': 43,
      'label':
          "Ando Ganas, BFU, Avenida San Martín, Ushuaia, Tierra del Fuego Province, Argentina ",
    },
    {
      'value': 44,
      'label':
          "Ando Ganas, Avenida San Martín, BFL, Ushuaia, Tierra del Fuego, Argentina ",
    },
    {
      'value': 45,
      'label':
          "Lagunas Tolhuin, 9 de Julio 745, V9420 Río Grande, Tierra del Fuego, Argentina ",
    },
    {
      'value': 46,
      'label':
          "Rose Music Bar, Avenida Manuel Belgrano, Rio Grande, Tierra del Fuego Province, Argentina ",
    },
    {
      'value': 47,
      'label':
          "Moro Cafetín, Av. Manuel Belgrano 582, V9420 Río Grande, Tierra del Fuego, Argentina ",
    },
    {
      'value': 48,
      'label':
          "Hotel Atlántida, Avenida Manuel Belgrano 582, Río Grande, Tierra del Fuego Province, Argentina ",
    },
    {
      'value': 49,
      'label':
          "Quemehuencho, Roque Sáenz Peña, Puerto Madryn, Chubut Province, Argentina ",
    },
    {
      'value': 50,
      'label':
          "Navone Juan Servicio Tecnico, Avenida Juan Domingo Perón, Carmen de Patagones, Buenos Aires Province, Argentina ",
    }
  ];

  static final List<Map<String, dynamic>> searchCombosAfrica = const [
    {
      'value': 0,
      'label': 'Select Place in Africa',
    } /*,
    {
      'value': 1,
      'label': "ROCA 4G - 9 de Julio, General Roca, Río Negro, Argentina ",
    },
    {
      'value': 2,
      'label':
          "Dot Co working - Chacabuco 1512, R8332 Gral. Roca, Río Negro, Argentina ",
    },
    {
      'value': 3,
      'label':
          "Helados Lomoro - Lamadrid, Coronel Suárez, Buenos Aires Province, Argentina ",
    },
    {
      'value': 4,
      'label':
          "Theos café, bar y crypto - Bartolomé Mitre, Mar del Plata, Buenos Aires Province, Argentina ",
    },
    {
      'value': 5,
      'label':
          "Caffè Firenze - La Rioja 2055, Mar del Plata, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 6,
      'label':
          "Indiana Beer & Food - Mendoza, Santa Rosa de Calamuchita, Cordoba, Argentina ",
    },
    {
      'value': 7,
      'label':
          "Taos Pueblo | cabañas de montaña - Capilla del Monte, Capilla del Monte, Cordoba, Argentina ",
    },
    {
      'value': 8,
      'label':
          "La banana loca - Virgen de la Merced, San Miguel de Tucumán, Tucumán, Argentina ",
    },
    {
      'value': 9,
      'label':
          "Yugoo - Desarrollos Informáticos, Gobernador Lagraña 271, Corrientes, Argentina ",
    },
    {
      'value': 10,
      'label':
          "Maxi Cero - Bv. Presidente Julio A. Roca, Rafaela, Santa Fe Province, Argentina",
    },
    {
      'value': 11,
      'label': "Mitica Viajes - Rafaela, Santa Fe Province, Argentina ",
    },
    {
      'value': 12,
      'label': "Coreworks CoWorking - Argentina",
    },
    {
      'value': 13,
      'label': "Ken't Cultura Urbana - San Martín, DVA, Entre Ríos, Argentina ",
    },
    {
      'value': 14,
      'label':
          "Mae sport - El Rosedal, Granadero Baigorria, Santa Fe Province, Argentina ",
    },
    {
      'value': 15,
      'label':
          "El Patio de Normita, Lavardén, Funes, Santa Fe Province, Argentina ",
    },
    {
      'value': 16,
      'label':
          "Estudio Rohner R&R - Jurídico y Agrimensura, Leandro N. Alem, Las Flores, Buenos Aires Province, Argentina ",
    },
    {
      'value': 17,
      'label':
          "Mical Materiales - Avenida Hipólito Yrigoyen, Chacabuco, Buenos Aires Province, Argentina ",
    },
    {
      'value': 18,
      'label':
          "Cimientos Materiales para la Construcción - BYG, Avenida General San Martín, Belén de Escobar, Buenos Aires Province, Argentina ",
    },
    {
      'value': 19,
      'label': "Viejo Wence Argentina",
    },
    {
      'value': 20,
      'label':
          "CM make up studio - Moreno, Pilar Centro, Buenos Aires Province, Argentina",
    },
    {
      'value': 21,
      'label':
          "Estacionamiento Paseo del Corralón - ARJ, Bartolomé Mitre, Luján, Buenos Aires Province, Argentina ",
    },
    {
      'value': 22,
      'label':
          "LosTatosRestobar - Mariano Acosta, Pilar Centro, Buenos Aires Province, Argentina ",
    },
    {
      'value': 23,
      'label':
          'Kiosco El Tari - Labardén 1051, José C. Paz, Provincia de Buenos Aires, Argentina ',
    },
    {
      'value': 24,
      'label':
          "Dr. Pablo Javier Baglioni - Cardiólogo, Doctor Gabriel Ardoino, Ramos Mejía, Buenos Aires Province, Argentina",
    },
    {
      'value': 25,
      'label':
          "Domenica Pizza y Cafe - Av. Dr. Ignacio Arieta 3596, B1754 San Justo, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 26,
      'label': "Club Larrazabal - Av. Larrazábal, Buenos Aires, Argentina ",
    },
    {
      'value': 27,
      'label':
          "Carmelita Beauty - Mitre 3885, B1650 San Martín, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 28,
      'label':
          "K24 - Av. de los Constituyentes, C1431 EZJ, Buenos Aires, Argentina ",
    },
    {
      'value': 29,
      'label': "K24 - Av. Lope de Vega 3527, C1419 Buenos Aires, Argentina ",
    },
    {
      'value': 30,
      'label':
          "Hazme Limpio - Avenida Fondo de la Legua, Villa Adelina, Provincia de Buenos Aires, Argentina ",
    },
    {
      'value': 31,
      'label': "Kiosco Monroe - Avenida Monroe, Buenos Aires, Argentina ",
    },
    {
      'value': 32,
      'label':
          "Kiosco TXV, Avenida General Indalecio Chenaut, Buenos Aires, Argentina ",
    },
    {
      'value': 33,
      'label': "K24 - (Kiosco) Av. Álvarez Thomas 801, Buenos Aires, Argentina",
    },
    {
      'value': 34,
      'label':
          "Kiosco K24 - General José Gervasio Artigas, Buenos Aires, Argentina ",
    },
    {
      'value': 35,
      'label': "K24 (Kiosco) Neuquén 1698, C1406 FOD, Buenos Aires",
    },
    {
      'value': 36,
      'label':
          "K24 Kioscos - Avenida Francisco Beiró, C1419HZY, Buenos Aires, Argentina",
    },
    {
      'value': 37,
      'label':
          "M24 Market Lope de Vega - Avenida Lope de Vega, Buenos Aires, Argentina ",
    },
    {
      'value': 38,
      'label':
          "Kiosco M24 Market - Cuenca 2599, C1417AAG, Buenos Aires, Argentina ",
    } ,
    {
      'value': 1,
      'label':
          'Froggs & Habit Intergalactic Trading Corporation - Lakeside Road, Farms, Gqeberha, South Africa',
    },
    {
      'value': 2,
      'label':
          'Linen and Bath Vaal Mall - Barrage Road, Vanderbijlpark S. W. 2, Vanderbijlpark, South Africa',
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
    }*/
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
    } /*,
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
    }*/
  ];

  static final List<Map<String, dynamic>> searchCombosSouthAmerica = const [
    {
      'value': 0,
      'label': 'Select Place in South America',
    },
    {
      'value': 1,
      'label':
          "Aspire Club, Soi Sukhumvit 23, Klongtoey Nue, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 2,
      'label':
          "The Sport Corner Sukhumvit Rd., Klongtoey Khlong Toei, Thailand Bangkok 10110, Thailand ",
    },
    {
      'value': 3,
      'label':
          "Cute Corner Cuisine, Sukhumvit Soi 18, Khlong Toei, Bangkok, Thailand ",
    },
    {
      'value': 4,
      'label':
          "Cute Concept constant beauty, Sukhumvit Soi 18, Khlong Toei, Bangkok, Thailand ",
    },
    {
      'value': 5,
      'label':
          "Panini MAFIA, Soi Ekkamai 5, Klongton Nua, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 6,
      'label':
          "Sole Mio Akkhara Phat Alley, Khlong Tan Nuea, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 7,
      'label':
          "UnionSPACE, Sukhumvit 61 Alley, Khlong Tan Nuea, Watthana, Bangkok, Thailand ",
    },
    {
      'value': 8,
      'label':
          "LBD™ - La Bombona Diving™, MAIN CENTER, Ko Tao, Koh Tao Surat Thani, Thailand ",
    },
    {
      'value': 9,
      'label':
          "Drift by Big Blue, Ko Tao, Ko Pha-ngan District, Surat Thani, Thailand ",
    },
    {
      'value': 10,
      'label':
          "Buddha Cafe, Ko Pha-ngan Sub-district, Ko Pha-ngan District, Surat Thani, Thailand ",
    },
    {
      'value': 11,
      'label':
          "BEACHUB, Ko Pha-ngan Sub-district, Ko Pha-ngan District, Surat Thani 84280, Thailand ",
    },
    {
      'value': 12,
      'label':
          "Bliss Villas, Koh Phangan, Ko Pha-ngan District, Surat Thani, Thailand ",
    },
    {
      'value': 13,
      'label':
          "One Love Dome, Ko Pha-ngan Sub-district, Ko Pha-ngan District, Surat Thani 84280, Thailand ",
    },
    {
      'value': 14,
      'label':
          "Out back Bar & Restaurant, Ban Tai, Kohphangan, Surat Thani, Thailand ",
    },
    {
      'value': 15,
      'label':
          "500Rai Floating Resort, รัช ช ประภา Khao Phang, Ban Ta Khun District, Surat Thani, Thailand ",
    },
    {
      'value': 16,
      'label':
          "Drinks & Co Phuket, Choeng Thale, Thalang District, Phuket, Thailand ",
    },
    {
      'value': 17,
      'label':
          "Siam Supper Club, Lagoon Rd, Tambon Cherngtalay Thalang District, Phuket 83110, Thailand ",
    },
    {
      'value': 18,
      'label':
          "Harrys Restaurant, Bar & Hotel, Patong Beach, Phuket Thawewong Road, Pa Tong, Kathu District, Phuket, Thailand ",
    },
    {
      'value': 19,
      'label':
          "Santosa, Patak Road, Karon, Mueang Phuket District, Phuket, Thailand ",
    },
    {
      'value': 20,
      'label':
          "Kata On Sea Taina Road, Karon, Mueang Phuket District, Phuket, Thailand ",
    },
    {
      'value': 21,
      'label':
          "Flip Side, Wiset Road, Rawai, Mueang Phuket District, Phuket, Thailand ",
    },
    {
      'value': 22,
      'label':
          "AYAMCHON สาขา Central Festival Hatyai Kanjanavanich Road, Kho Hong, Hat Yai District, Songkhla, Thailand ",
    },
    {
      'value': 23,
      'label':
          "AYAMCHON Charoen Pradit Road, Rusamilae, Mueang Pattani District, Pattani, Thailand ",
    },
    {
      'value': 24,
      'label': "AYAMCHON Talubo, Mueang Pattani District, Pattani, Thailand",
    },
    {
      'value': 25,
      'label':
          "AYAMCHON สาขา Central Festival Hatyai Kanjanavanich Road, Kho Hong, Hat Yai District, Songkhla, Thailand",
    },
    {
      'value': 26,
      'label':
          "AYAMCHON 42 Bang Nak, Mueang Narathiwat District, Narathiwat, Thailand",
    },
    {
      'value': 27,
      'label':
          "SAIL TECHNOLOGIES OU, Jalan Bukit Marak, Kota Bharu, Kelantan, Malaysia ",
    },
    {
      'value': 28,
      'label':
          "VIVO MALAYSIA I PHONE COMMUNICATIONS ENTERPRISE, Jalan Kuala Kangsar, Taman Tasek Damai, Ipoh, Perak, Malaysia ",
    },
    {
      'value': 29,
      'label':
          "HANGOUT @ IPOH, Jalan Sultan Idris Shah, Taman Jubilee, Ipoh, Perak, Malaysia ",
    },
    {
      'value': 30,
      'label':
          "Home Appliances - XAM MAX, Jalan SS 21/60, Damansara Utama, Petaling Jaya, Selangor, Malaysia ",
    },
    {
      'value': 31,
      'label':
          "Antara Hardware Home Centre Sdn Bhd 安泰五金, Taman Putra Sulaiman, Kuala Lumpur, Selangor, Malaysia ",
    },
    {
      'value': 32,
      'label':
          "Studio One Zero One / 101 Studios, Jalan SS 3/39, Ss 3, 47300 Petaling Jaya, Selangor, Malaysia ",
    },
    {
      'value': 33,
      'label':
          "Nk Freight (M) Sdn. Bhd., Jalan 9 Kosmoplek, Bandar Baru Salak Tinggi, Sepang, Selangor, Malaysia ",
    },
    {
      'value': 34,
      'label':
          "Saudagar Durian, Jalan Tambak Paya / Ayer Molek, Kampung Tambak Paya, 75460 Ayer Molek, Melaka, Malaysia ",
    },
    {
      'value': 35,
      'label': "Hougang Street 11, El Gaming Pte. Ltd., Singapore ",
    },
    {
      'value': 36,
      'label': "Cove Drive, Sip N Sail, Sentosa Cove, Singapore ",
    },
    {
      'value': 37,
      'label': "Robinson Road, Ducatus Cafe Singapore, Singapore ",
    },
    {
      'value': 38,
      'label': "Telok Kurau Road, Meat And Green, Singapore ",
    },
    {
      'value': 39,
      'label':
          "Raffles Boulevard, Black Knight Hotpot, Nihon Street, Singapore ",
    },
    {
      'value': 40,
      'label': "Hotel, CÉ LA VI Singapore, Singapore ",
    },
    {
      'value': 41,
      'label': "RAJEX.ID, Lampaseh Kota, Banda Aceh City, Aceh, Indonesia ",
    },
    {
      'value': 42,
      'label':
          "Mie Pangsit Bunda Juli Patok 6, Jalan Raya Bireuen - Takengon, Bireun Meunasah Capa, Bireuen Regency, Aceh, Indonesia",
    },
    {
      'value': 43,
      'label':
          "TOP RELOAD SUKSES, Jalan Pendowo, Bukit Batrem, Kota Dumai, Riau, Indonesia ",
    },
    {
      'value': 44,
      'label':
          "Tapung Hulu Motor, Suka Ramai, Kampar Regency, Riau, Indonesia ",
    },
    {
      'value': 45,
      'label':
          "PT.NUSANTARA BANGKA JAYA, Jl. RE. Martadinata, Opas Indah, Pangkal Pinang City, Bangka Belitung Islands, Indonesia ",
    },
    {
      'value': 46,
      'label':
          "Distro NgabreetRY, Link. Tegal malang, Warnasari, Kec. Jombang, Kota Cilegon, Banten 42411, Indonesia ",
    },
    {
      'value': 47,
      'label':
          "NEOSIS - Pembuatan Website dan Jasa Design, RT.9/RW.11, East Cengkareng, West Jakarta City, Jakarta, Indonesia",
    },
    {
      'value': 48,
      'label':
          "Bitcoins Crypto, Jl. Jambu II, Depok Jaya, Depok City, West Java, Indonesia ",
    },
    {
      'value': 49,
      'label':
          "Wisata Budidaya Jahe, Leuit Jahe, Pasir Lame Kubang, Cikadu, West Bandung Regency, West Java, Indonesia",
    },
    {
      'value': 50,
      'label':
          "BTC Fashion Mall, Jalan Doktor Djunjunan, Pajajaran, Bandung City, West Java, Indonesia ",
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
