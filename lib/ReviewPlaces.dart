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
