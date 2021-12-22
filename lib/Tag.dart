// Identifier a

class Tag {
  final String content;
  final int id;

  Tag(this.content, this.id);

  static int getTagIndex(String searchTerm) {
    if (!Tag.tagText.any((String e) {
          return e.toLowerCase().contains(searchTerm.toLowerCase());
        }) &&
        !Tag.tagTextES.contains(searchTerm) &&
        !Tag.tagTextDE.contains(searchTerm) &&
        !Tag.tagTextFR.contains(searchTerm) &&
        !Tag.tagTextIT.contains(searchTerm) &&
        !Tag.tagTextINDONESIA.contains(searchTerm) &&
        !Tag.tagTextJP1.contains(searchTerm) &&
        !Tag.tagTextJP2.contains(searchTerm)) return -1;

    int result = -1;
    if ((result = _findTagIndex(searchTerm, Tag.tagText)) == -1) if ((result =
            _findTagIndex(searchTerm, Tag.tagTextES)) ==
        -1) if ((result =
            _findTagIndex(searchTerm, Tag.tagTextDE)) ==
        -1) if ((result =
            _findTagIndex(searchTerm, Tag.tagTextFR)) ==
        -1) if ((result =
            _findTagIndex(searchTerm, Tag.tagTextIT)) ==
        -1) if ((result =
            _findTagIndex(searchTerm, Tag.tagTextINDONESIA)) ==
        -1) if ((result = _findTagIndex(searchTerm, Tag.tagTextJP1)) == -1)
      result = _findTagIndex(searchTerm, Tag.tagTextJP2);

    return result;
  }

  static int _findTagIndex(String searchTerm, tags) {
    for (int i = 0; i < tags.length; i++) {
      String item = tags.elementAt(i);
      if (item.toLowerCase().startsWith(searchTerm.toLowerCase())) {
        return i;
      }
    }
    return -1;
  }

  //Only if the tag is totally unused, that means there are zero results when searching inside the app, then it can be replaced by another tag

  static final tagText = const {
    'Spicy 🌶️', //0
    'Salty 🥨',
    'Sour 😜',
    'Organic 🐵',
    'Vegetarian 🥕', //4
    'Vegan 🐮',
    'Healthy 💓',
    'Burger 🍔',
    'Sandwich 🥪',
    'Muffin 🧁', //9 The muffin icon is invisible
    'Brownie 🥮', //10 Brownie is invisible too
    'Cake 🎂',
    'Cookie 🍪',
    'Arabic 🥙',
    'Pizza 🍕', //14
    'Salad 🥗',
    'Smoothie 🥤',
    'Fruit 🍓',
    'IceCream 🍦',
    'Raw 🥦', //19
    'Handbag 👜',
    'Cosmetic 💅',
    'Tattoo ♣',
    'Piercing 🌀',
    'Souvenir 🎁', //24
    'Hatha 🧘',
    'Vinyasa 🧘',
    'Massage 💆',
    'Upcycled 🌲',
    'Coffee ☕', //29
    'NoGluten 🌽',
    'Cocktails 🍹',
    'Beer 🍺',
    'Music 🎵',
    'Chinese 🍜', //34
    'Duck 🍱',
    'Rock 🎸',
    'LiveDJ 🎧',
    'Terrace ☀',
    'Seeds 🌱', //39
    'Grinder 🍌',
    'Papers 🚬',
    'Advice 🌴',
    'Calzone 🥟',
    'Falafel 🥙', //44
    'MakeUp 🤡',
    'Gifts 🎁',
    'Tapas 🍠',
    'Copas 🍹',
    'Piadina 🌮', //49
    'Cheese 🧀',
    'Grains 🌾',
    'Fashion 👗',
    'Fair 🤗',
    'Women 👩', //54
    'Drinks 🍹',
    'TV 📺',
    'Retro 🦄',
    'Feta 🐐',
    'WiFi 🌐', //'DASH Ð', //59
    'Shopping Center 🛍️', //'BTC',
    'Department Store 🏬', //'BCH',
    'Cigarette 🚬', //'Anypay',
    'Recharge 📱', //'ETH',
    'HotDog 🌭', //64
    'Fast ⏩',
    'Kosher 🕍',
    'Sushi 🍣',
    'Motorbike 🛵', //DOUBLE CHECK DOWN AT MOTORBIKE
    'Car 🚘', //69
    'Bicycle 🚴', //'GoCrypto UNUSED',
    'Chicken 🐔',
    'Rabbit 🐰',
    'Potato 🥔',
    'Kumpir 🥔', //74
    'Kebap 🐄',
    'ATM 🏦',
    'Gyros 🐖',
    'Coconut 🥥',
    'ToGo 📦', //79
    'Meditation 🧘',
    'Wine 🍷',
    'Champagne 🥂',
    'Alcohol 🍾',
    'Booze 🥃', //84
    'Pancakes 🥞', //You cant remove because we use fixed indexes, but replace with another string that is unlikely to be typed in by the user
    'Croissant 🥐',
    'Popcorn 🍿',
    'SoftIce 🍦',
    'Dango 🍡',
    'BnB 🛏️', //90
    'Haircut ✂',
    'Candy 🍭',
    'Beauty 💅',
    'Miso 🍱',
    'Chocolate 🍫', //95
    'Rice 🍚',
    'Seafood 🦀',
    'Hostel 🛏️',
    'Fries 🍟',
    'Fish 🐟', //100
    'Chips 🍟',
    'Italian 🇮🇹',
    'Whiskey 🥃',
    ' - - - ', //This is number 104 the no tag indicator, currently not used //TODO hide this field from the suggestions
    'Bourbon 🥃', //105
    'Liquor 🥃',
    'Men ♂',
    'Pasta 🍝',
    'Dessert 🍬', //109
    'Starter 🥠', //110
    'BBQ 🍗',
    'Noodle 🍜',
    'Korean 🥟',
    'Market 🧺', //114 invisible item
    'Bread 🥖',
    'Bakery 🥨',
    'Cafe ☕',
    'Games 🎮',
    'Snacks 🍿', //119
    'Elegant 🕴️',
    'Piano 🎹',
    'Brunch 🍱',
    'Nachos 🌽',
    'Lunch 🥡',
    'Breakfast 🥐', //125
    'HappyHour 🥳', //hidden item
    'LateNight 🌜',
    'Mexican 🇲🇽',
    'Burrito 🌯',
    'Tortilla 🌮', //130
    'Indonesian 🇮🇩',
    'Sports 🏆',
    'Pastry 🥧',
    'Bistro 🍲',
    'Soup 🥣', //135
    'Tea 🍵',
    'Onion 🧅',
    'Steak 🥩',
    'Shakes 🥤',
    'Empanadas 🥟', //140
    'Dinner 🍽️',
    'Sweet 🍭',
    'Fried 🍳',
    'Omelette 🥚',
    'Gin 🍸', //145
    'Donut 🍩',
    'Delivery 🚚',
    'Cups ☕',
    'Filter',
    'Juice 🍊', //150
    'Vietnamese 🇻🇳',
    'Pie 🥮', //invisible item
    'Unagi 🐡',
    'Greek 🇬🇷',
    'Japanese 🇯🇵', //155
    'Tacos 🌮',
    'Kombucha 🍵',
    'Indian 🇮🇳',
    'Nan 🥪', //
    'Club 🎶', //160
    'Honey 🍯',
    'Pool 🎱',
    'Hotel 🏨',
    'Pork 🥓',
    'Ribs 🍖', //165
    'Kava 🍵',
    'Chai 🍵',
    'Izzy 🍵',
    'Matcha 🍵',
    'Oden 🍢', //170
    'Latte ☕',
    'Pool 🏊', //'DASHText Ð', //
    'Air Cond. ❄', //'CoinTigo',
    'Powerplant 🔌', //'CoinText',
    'Rental 🏠', //'Salamantex',//175
    'Supply 🧺', //'CryptoBuyer',
    'Kiosk 🏪', //'XPay',
    'Electronic 💻', //'Panmoni'
    'Cellphone 📱', //180
    'Parking 🅿️',
    'Accessories 💠',
    'Shoes 👞',
    'Beach 🏖️',
    'River 🏞️', //185
    'Natural 🌲',
    'Imported 🌎',
    'Tools 🔨',
    'Flour 🥖',
    'Cleaning 🧹', //190
    'Soap 🧼',
    'Detergent ☢',
    'Pharmacy 🏥',
    'Sugar 😍',
    'Simcard 📶', //195
    'Microsd 💾',
    'Battery 🔋',
    'Water 🚰',
    'Clock ⌚', //200,
    'Key 🔑',
    'Padlock 🔒',
    'Pet 🐶',
    'Kids 🚸',
    'Movie 🎥', //205
    'Photo 📸',
    'Camera 📷',
    'Security 👮',
    'Mattress 🛏️',
    'Maintenance 🔧', //210
    'Washingmachine 🚿',
    'Sausage 🌭',
    'Egg 🥚',
    'Milk 🥛'
  };

  static final tagTextJP1 = const {
    'スパイシー🌶️',
    '塩味の🥨',
    '酸っぱい😜',
    'オーガニック🐵',
    'ベジタリアン🥕',
    'ビーガン🐮',
    '健康💓',
    'バーガー🍔',
    'サンドイッチ🥪',
    'マフィン🧁',
    'ブラウニー🥮',
    'ケーキ🎂',
    'クッキー🍪',
    'アラビア語',
    'ピザ🍕',
    'サラダ🥗',
    'スムージー🥤',
    'フルーツ🍓',
    '🍔🍔🍔IceCream🍦',
    '生🥦',
    'ハンドバッグ,',
    '化粧品💅',
    'タトゥー♣',
    'ピアス🌀',
    'お土産',
    'ハタ🧘',
    'ヴィンヤサ🧘',
    'マッサージ💆',
    'アップサイクル🌲',
    'コーヒー☕',
    '🍔🍔🍔NoGluten🌽',
    'カクテル🍹',
    'ビール🍺',
    'ミュージック🎵',
    '中国語🍜',
    'アヒル🍱',
    'ロック🎸',
    '🍔🍔🍔LiveDJ🎧',
    'テラス☀️',
    '種子🌱',
    'グラインダー🍌',
    '論文🚬',
    'アドバイス🌴',
    'カルゾーン🥟',
    'ファラフェル🥙',
    '🍔🍔🍔MakeUp🤡',
    'ギフト🎁',
    'タパス🍠',
    'コパス🍹',
    '🍔🍔🍔Piadina🌮',
    'チーズ🧀',
    '穀物🌾',
    'ファッション👗',
    'フェア🤗',
    '女性👩',
    '飲み物🍹',
    'テレビ📺',
    'レトロ🦄',
    '🍔🍔🍔Feta🐐',
    '🍔🍔🍔DASH₿',
    '🍔🍔🍔BTC₿',
    '🍔🍔🍔BCH₿',
    '🍔🍔🍔BSV₿',
    '🍔🍔🍔ETH,',
    '🍔🍔🍔HotDog🌭',
    '速い⏩',
    'コーシャー',
    '寿司🍣',
    'モト🛵',
    'コシェ🚘',
    '🍔🍔🍔GoCrypto₿',
    'チキン🐔',
    'うさぎ🐰',
    'じゃがいも🥔',
    '🍔🍔🍔Kumpir🥔',
    'ケバプ🐄',
    '🍔🍔🍔ATM🏦',
    'ジャイロ🐖',
    'ココナッツ🥥',
    '🍔🍔🍔ToGo📦',
    '瞑想🧘',
    'ワイン🍷',
    'シャンパン',
    'アルコール🍾',
    '酒o',
    'パンケーキ🥞',
    'クロワッサン',
    'ポップコーン🍿',
    '🍔🍔🍔SoftIce🍦',
    '🍔🍔🍔Dango🍡',
    '🍔🍔🍔BnB🛏️',
    'ヘアカット✂️',
    'キャンディ🍭',
    '美しさ💅',
    'みそ🍱',
    'チョコレート🍫',
    '米🍚',
    'シーフード🦀',
    'ホステル🛏️',
    'フライドポテト',
    '魚🐟',
    'チップ',
    'イタリア語🇮🇹',
    'ウイスキー🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104
    'ブルボン🥃',
    '酒🥃',
    'メン♂️',
    'パスタ🍝',
    'デザート🍬',
    'スターター🥠',
    'バーベキュー',
    '麺',
    '韓国語🥟',
    'マーケット🧺',
    'パン🥖',
    'パン屋さん',
    'カフェ☕',
    'ゲーム',
    'スナック🍿',
    'エレガント🕴️',
    'ピアノ🎹',
    'ブランチ🍱',
    'ナチョス',
    'ランチ🥡',
    '朝食🥐',
    '🍔🍔🍔HappyHour🥳',
    '🍔🍔🍔LateNight🌜',
    'メキシカン🇯🇽',
    'ブリトー🌯',
    'トルティーヤ🌮',
    'インドネシア語🇮🇩',
    'スポーツ🏆',
    'ペストリー🥧',
    'ビストロ🍲',
    'スープ🥣',
    'お茶',
    '玉ねぎ',
    'ステーキ🥩',
    'シェイク🥤',
    '🍔🍔🍔Empanadas🥟',
    '夕食🍽️',
    '甘い🍭',
    '揚げ🍳',
    'オムレツ🥚',
    'ジン🍸',
    'ドーナツ🍩',
    '配達',
    'カップ☕',
    'フィルタ',
    'ジュース🍊',
    'ベトナム語🇻🇳',
    'パイ🥮',
    'うなぎ🐡',
    'ギリシャ語🇬🇷',
    '日本の🇯🇵',
    'タコス🌮',
    'こんぶちゃ',
    'インド🇮🇳',
    '南🥪',
    'クラブ🎶',
    'ハニー🍯',
    'プール🎱',
    'ホテル🏨',
    '豚肉',
    'リブ🍖',
    'カバ🍵',
    'チャイ',
    'イジー🍵',
    '抹茶🍵',
    'おでん🍢',
    'ラテ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex',
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };
  /*
  static final tagTextJP1 = const {
    'Spicy 🌶️',
    'Salty 🥨',
    'Sour 😜',
    'Organic 🐵',
    'Vegetarian 🥕',
    'Vegan 🐮',
    'Healthy 💓',
    'Burger 🍔',
    'Sandwich 🥪',
    'Muffin 🧁',
    'Brownie 🥮',
    'Cake 🎂',
    'Cookie 🍪',
    'Arabic 🥙',
    'Pizza 🍕',
    'Salad 🥗',
    'Smoothie 🥤',
    'Fruit 🍓',
    'IceCream 🍦',
    'Raw 🥦',
    'Handbag 👜',
    'Cosmetic 💅',
    'Tattoo ♣',
    'Piercing 🌀',
    'Souvenir 🎁',
    'Hatha 🧘',
    'Vinyasa 🧘',
    'Massage 💆',
    'Upcycled 🌲',
    'Coffee ☕',
    'NoGluten 🌽',
    'Cocktails 🍹',
    'Beer 🍺',
    'Music 🎵',
    'Chinese 🍜',
    'Duck 🍱',
    'Rock 🎸',
    'LiveDJ 🎧',
    'Terrace ☀️',
    'Seeds 🌱',
    'Grinder 🍌',
    'Papers 🚬',
    'Advice 🌴',
    'Calzone 🥟',
    'Falafel 🥙',
    'MakeUp 🤡',
    'Gifts 🎁',
    'Tapas 🍠',
    'Copas 🍹',
    'Piadina 🌮',
    'Cheese 🧀',
    'Grains 🌾',
    'Fashion 👗',
    'Fair 🤗',
    'Women 👩',
    'Drinks 🍹',
    'TV 📺',
    'Retro 🦄',
    'Feta 🐐',
    '🍔🍔🍔WiFi',
    'BTC',
    'BCH',
    'BSV',
    'ETH',
    'HotDog 🌭',
    'Fast ⏩',
    'Kosher 🦄',
    'Sushi 🍣',
    'Moto 🛵',
    'Coche 🚘',
    'GoCrypto',
    'Chicken 🐔',
    'Rabbit 🐰',
    'Potato 🥔',
    'Kumpir 🥔',
    'Kebap 🐄',
    'ATM 🏦',
    'Gyros 🐖',
    'Coconut 🥥',
    'ToGo 📦',
    'Meditation 🧘',
    'Wine 🍷',
    'Champagne 🥂',
    'Alcohol 🍾',
    'Booze 🥃',
    'Pancakes 🥞',
    'Croissant 🥐',
    'Popcorn 🍿',
    'SoftIce 🍦',
    'Dango 🍡',
    'BnB 🛏️',
    'Haircut ✂️',
    'Candy 🍭',
    'Beauty 💅',
    'Miso 🍱',
    'Chocolate 🍫',
    'Rice 🍚',
    'Seafood 🦀',
    'Hostel 🛏️',
    'Fries 🍟',
    'Fish 🐟',
    'Chips 🍟',
    'Italian 🇮🇹',
    'Whiskey 🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104
    'Bourbon 🥃',
    'Liquor 🥃',
    'Men ♂️',
    'Pasta 🍝',
    'Dessert 🍬',
    'Starter 🥠',
    'BBQ 🍗',
    'Noodle 🍜',
    'Korean 🥟',
    'Market 🧺',
    'Bread 🥖',
    'Bakery 🥨',
    'Cafe ☕',
    'Games 🎮',
    'Snacks 🍿',
    'Elegant 🕴️',
    'Piano 🎹',
    'Brunch 🍱',
    'Nachos 🌽',
    'Lunch 🥡',
    'Breakfast 🥐',
    'HappyHour 🥳',
    'LateNight 🌜',
    'Mexican 🇲🇽',
    'Burrito 🌯',
    'Tortilla 🌮',
    'Indonesian 🇮🇩',
    'Sports 🏆',
    'Pastry 🥧',
    'Bistro 🍲',
    'Soup 🥣',
    'Tea 🍵',
    'Onion',
    'Steak 🥩',
    'Shakes 🥤',
    'Empanadas 🥟',
    'Dinner 🍽️',
    'Sweet 🍭',
    'Fried 🍳',
    'Omelette 🥚',
    'Gin 🍸',
    'Donut 🍩',
    'Delivery 🚚',
    'Cups ☕',
    'Filter',
    'Juice 🍊',
    'Vietnamese 🇻🇳',
    'Pie 🥮',
    'Unagi 🐡',
    'Greek 🇬🇷',
    'Japanese 🇯🇵',
    'Tacos 🌮',
    'Kombucha 🍵',
    'Indian 🇮🇳',
    'Nan 🥪',
    'Club 🎶',
    'Honey 🍯',
    'Pool 🎱',
    'Hotel 🏨',
    'Pork 🥓',
    'Ribs 🍖',
    'Kava 🍵',
    'Chai 🍵',
    'Izzy 🍵',
    'Matcha 🍵',
    'Oden 🍢',
    'Latte ☕'
  };*/
  static final tagTextJP2 = const {
    'supaishī 🌶️ ',
    'shioaji no 🥨',
    'suppai 😜',
    'ōganikku 🐵',
    'bejitarian 🥕',
    'bīgan 🐮',
    'kenkō 💓',
    'bāgā 🍔',
    'sandoitchi 🥪',
    'mafin 🧁',
    'buraunī 🥮',
    'kēki 🎂',
    'kukkī 🍪',
    'Arabia-go',
    'piza 🍕',
    'sarada 🥗',
    'sumūjī 🥤',
    'furūtsu 🍓',
    '🍔🍔🍔IceCream 🍦',
    '-sei 🥦',
    'handobaggu,',
    'keshōhin 💅',
    'tato~ū ♣',
    'piasu 🌀',
    'odosan',
    'Hata 🧘',
    'vu~inyasa 🧘',
    'massāji 💆',
    'appu saikuru 🌲',
    'kōhī ☕',
    '🍔🍔🍔NoGluten 🌽',
    'kakuteru 🍹',
    'bīru 🍺',
    'myūjikku 🎵',
    'chūgokugo 🍜',
    'ahiru 🍱',
    'rokku 🎸',
    '🍔🍔🍔LiveDJ 🎧',
    'terasu ☀ ️ ',
    'shushi 🌱',
    'guraindā 🍌',
    'ronbun 🚬',
    'adobaisu 🌴',
    'karuzōn 🥟',
    'faraferu 🥙',
    '🍔🍔🍔MakeUp 🤡',
    'gifuto 🎁',
    'tapasu 🍠',
    'kopasu 🍹',
    '🍔🍔🍔piadīna 🌮',
    'chīzu 🧀',
    'kokumotsu 🌾',
    'fasshon 👗',
    'fea 🤗',
    'josei 👩',
    'nomimono 🍹',
    'terebi 📺',
    'Retoro 🦄',
    '🍔🍔🍔feta 🐐',
    '🍔🍔🍔dasshu',
    '🍔🍔🍔BTC',
    '🍔🍔🍔BCH',
    '🍔🍔🍔BSV',
    '🍔🍔🍔ETH,',
    '🍔🍔🍔HotDog 🌭',
    'hayai ⏩',
    'kōshā',
    'sushi 🍣',
    '🍔🍔🍔Moto 🛵',
    '🍔🍔🍔koshe 🚘',
    '🍔🍔🍔GoCrypto',
    'chikin 🐔',
    'usagi 🐰',
    'jagaimo 🥔',
    '🍔🍔🍔Kumpir 🥔',
    'kebapu 🐄',
    '🍔🍔🍔ATM 🏦',
    'jairo 🐖',
    'kokonattsu 🥥',
    '🍔🍔🍔ToGo 📦',
    'meisō 🧘',
    'wain 🍷',
    'shanpan',
    'arukōru 🍾',
    '-shu o',
    'pankēki 🥞',
    'kurowassan',
    'poppukōn 🍿',
    '🍔🍔🍔SoftIce 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️ ',
    'hea katto ✂ ️ ',
    'kyandi 🍭',
    'utsukushi-sa 💅',
    '🍔🍔🍔miso 🍱',
    'chokorēto 🍫',
    'gohan 🍚',
    'shīfūdo 🦀',
    'hosuteru 🛏️ ',
    'furaidopoteto',
    '-gyo 🐟',
    'chippu',
    'Itaria-go 🇮🇹',
    'uisukī 🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104
    'Burubon 🥃',
    'sake 🥃',
    '🍔🍔🍔men ♂ ️ ',
    'pasuta 🍝',
    'dezāto 🍬',
    'sutātā 🥠',
    'bābekyū',
    '🍔🍔🍔men',
    'Kankoku-go 🥟',
    'māketto 🧺',
    '🍔🍔🍔pan 🥖',
    'panyasan 🥖',
    'kafe ☕',
    'gēmu',
    'sunakku 🍿',
    'ereganto 🕴️ ',
    '🍔🍔🍔piano 🎹',
    'buranchi 🍱',
    'nachosu',
    'ranchi 🥡',
    'chōshoku 🥐',
    '🍔🍔🍔HappyHour 🥳',
    '🍔🍔🍔LateNight 🌜',
    'mekishikan 🇲🇽',
    'buritō 🌯',
    'torutīya 🌮',
    'Indoneshia-go 🇮🇩',
    'supōtsu 🏆',
    'pesutorī 🥧',
    'bisutoro 🍲',
    'sūpu 🥣',
    'ocha',
    'tamanegi',
    'sutēki 🥩',
    'Sheiku 🥤',
    '🍔🍔🍔Empanadas 🥟',
    'yūshoku 🍽️ ',
    'amai 🍭',
    '-age 🍳',
    'omuretsu 🥚',
    'Jin 🍸',
    'dōnatsu 🍩',
    'haitatsu',
    'kappu ☕',
    'firuta',
    'jūsu 🍊',
    'Betonamu-go 🇻🇳',
    'pai 🥮',
    'unagi 🐡',
    'Girisha-go 🇬🇷',
    'Nihon no 🇯🇵',
    'takosu 🌮',
    'konbucha',
    'Indo 🇮🇳',
    'minami 🥪',
    'kurabu 🎶',
    'hanī 🍯',
    'pūru 🎱',
    'hoteru 🏨',
    'butaniku',
    'ribu 🍖',
    'kaba 🍵',
    '🍔🍔🍔Chai',
    'ijī 🍵',
    '🍔🍔🍔matcha 🍵',
    'oden 🍢',
    'rate ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex',
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };
  static final tagTextINDONESIA = const {
    'Pedas 🌶️', //0
    'Asin 🥨',
    'Asam 😜',
    'Organik 🐵',
    '🍔🍔🍔Vegetarian 🥕', //4
    '🍔🍔🍔Vegan 🐮',
    'Sehat 💓',
    '🍔🍔🍔Burger 🍔',
    '🍔🍔🍔Sandwich 🥪',
    '🍔🍔🍔Muffin 🧁', //9 The muffin icon is invisible
    '🍔🍔🍔Brownie 🥮', //10 Brownie is invisible too
    'Kue 🎂',
    '🍔🍔🍔Cookie 🍪',
    'Arab 🥙',
    '🍔🍔🍔Pizza 🍕', //14
    '🍔🍔🍔Salad 🥗',
    '🍔🍔🍔Smoothie 🥤',
    'Buah 🍓',
    '🍔🍔🍔IceCream 🍦',
    '🍔🍔🍔Raw 🥦', //19
    'TasTangan 👜',
    'Kosmetik 💅',
    'Tato ♣',
    'Menusuk 🌀',
    '🍔🍔🍔Souvenir 🎁', //24
    '🍔🍔🍔Hatha 🧘',
    '🍔🍔🍔Vinyasa 🧘',
    'Pijat 💆',
    'Diperbaiki 🌲',
    'Kopi ☕', //29
    '🍔🍔🍔NoGluten 🌽',
    'Koktail 🍹',
    'Bir 🍺',
    'Musik 🎵',
    'Cina 🍜', //34
    'Bebek 🍱',
    '🍔🍔🍔Rock 🎸',
    '🍔🍔🍔LiveDJ 🎧',
    'Teras ☀️',
    'Benih 🌱', //39
    '🍔🍔🍔Grinder 🍌',
    'Makalah 🚬',
    'Saran 🌴',
    '🍔🍔🍔Calzone 🥟',
    '🍔🍔🍔Falafel 🥙', //44
    '🍔🍔🍔MakeUp 🤡',
    'Hadiah 🎁',
    '🍔🍔🍔Tapas 🍠',
    '🍔🍔🍔Copas 🍹',
    '🍔🍔🍔Piadina 🌮', //49
    'Keju 🧀',
    '🍔🍔🍔Grains 🌾',
    'Mode 👗',
    'Adil 🤗',
    'Perempuan 👩', //54
    'Minuman 🍹',
    '🍔🍔🍔TV 📺',
    '🍔🍔🍔Retro 🦄',
    '🍔🍔🍔Feta 🐐',
    '🍔🍔🍔WiFi', //59
    '🍔🍔🍔BTC',
    '🍔🍔🍔BCH',
    '🍔🍔🍔BSV',
    '🍔🍔🍔ETH',
    '🍔🍔🍔HotDog 🌭', //64
    'Cepat ⏩',
    '🍔🍔🍔Kosher 🦄',
    '🍔🍔🍔Sushi 🍣',
    '🍔🍔🍔Moto 🛵',
    '🍔🍔🍔Coche 🚘', //69
    '🍔🍔🍔GoCrypto',
    'Ayam 🐔',
    'Kelinci 🐰',
    'Kentang 🥔',
    '🍔🍔🍔Kumpir 🥔', //74
    '🍔🍔🍔Kebap 🐄',
    '🍔🍔🍔ATM 🏦',
    '🍔🍔🍔Gyros 🐖',
    'Kelapa 🥥',
    '🍔🍔🍔ToGo 📦', //79
    'Meditasi 🧘',
    'Anggur 🍷',
    'Sampanye 🥂',
    '🍔🍔🍔Alkohol 🍾',
    'MinumanKeras 🥃', //84
    '🍔🍔🍔Pancakes 🥞', //You cant remove because we use fixed indexes, but replace with another string that is unlikely to be typed in by the user
    '🍔🍔🍔Croissant 🥐',
    '🍔🍔🍔Popcorn 🍿',
    '🍔🍔🍔SoftIce 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️', //90
    'Potongan ✂️',
    'Permen 🍭',
    'Kecantikan 💅',
    '🍔🍔🍔Miso 🍱',
    'Cokelat 🍫', //95
    'Beras 🍚',
    'MakananLaut 🦀',
    '🍔🍔🍔Hostel 🛏️',
    '🍔🍔🍔Goreng 🍟',
    'Ikan 🐟', //100
    'Keripik 🍟',
    'Italia 🇮🇹',
    'Wiski 🥃',
    '🍔🍔🍔Rum 🥃', //This is number 104 the no tag indicator, currently not used
    '🍔🍔🍔Bourbon 🥃', //105
    '🍔🍔🍔Liquor 🥃',
    'Pria ♂️',
    '🍔🍔🍔Pasta 🍝',
    'MakananPenutup 🍬', //109
    'Pemula 🥠', //110
    '🍔🍔🍔BBQ 🍗',
    'Mie 🍜',
    'Korea 🥟',
    'Pasar 🧺', //114 invisible item
    'Roti 🥖',
    'TokoRoti 🥨',
    'Kafe ☕',
    'Game 🎮',
    'MakananRingan 🍿', //119
    'Elegan 🕴️',
    '🍔🍔🍔Piano 🎹',
    '🍔🍔🍔Brunch 🍱',
    '🍔🍔🍔Nachos 🌽',
    'MakanSiang 🥡',
    'Sarapan 🥐', //125
    '🍔🍔🍔HappyHour 🥳', //hidden item
    '🍔🍔🍔LateNight 🌜',
    'Meksiko 🇲🇽',
    '🍔🍔🍔Burrito 🌯',
    '🍔🍔🍔Tortilla 🌮', //130
    'Indonesia 🇮🇩',
    'Olahraga 🏆',
    '🍔🍔🍔Pastry 🥧',
    '🍔🍔🍔Bistro 🍲',
    'Sup 🥣', //135
    'Teh 🍵',
    'Bawang',
    'Carne 🥩',
    'Getar 🥤',
    '🍔🍔🍔Empanadas 🥟', //140
    'MakanMalam 🍽️',
    'Manis 🍭',
    'Goreng 🍳',
    'Omelet 🥚',
    '🍔🍔🍔Gin 🍸', //145
    'Donat 🍩',
    'Pengiriman 🚚',
    'Piala ☕',
    '🍔🍔🍔Filter',
    'Jus 🍊', //150
    'Vietnam 🇻🇳',
    'Pai 🥮', //invisible item
    '🍔🍔🍔Unagi 🐡',
    'BahasaYunani 🇬🇷',
    'Jepang 🇯🇵', //155
    '🍔🍔🍔Tacos 🌮',
    '🍔🍔🍔Kombucha 🍵',
    'India 🇮🇳',
    'Nan 🥪', //
    'Klub 🎶', //160
    'Sayang 🍯',
    '🍔🍔🍔Pool 🎱',
    '🍔🍔🍔Hotel 🏨',
    'Babi 🥓',
    'Iga 🍖', //165
    '🍔🍔🍔Kava 🍵',
    '🍔🍔🍔Chai 🍵',
    '🍔🍔🍔Izzy 🍵',
    '🍔🍔🍔Matcha 🍵',
    '🍔🍔🍔Oden 🍢', //170
    '🍔🍔🍔Latte ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex', //175
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };

  static final tagTextIT = const {
    'Piccante 🌶️', //0
    'Salato 🥨',
    '🍔🍔🍔Sour 😜',
    'Organico 🐵',
    'Vegetariano 🥕', //4
    'Vegano 🐮',
    'Sano 💓',
    'Hamburger 🍔',
    'Panino 🥪',
    'Focaccina 🧁', //9 The muffin icon is invisible
    'Folletto 🥮', //10 Brownie is invisible too
    'Torta 🎂',
    'Biscotto 🍪',
    'Arabo 🥙',
    '🍔🍔🍔Pizza 🍕', //14
    'Insalata 🥗',
    'Frullato 🥤',
    'Frutta 🍓',
    'Gelato 🍦',
    'Cruda 🥦', //19
    'Borsetta 👜',
    'Cosmetico 💅',
    'Tatuaggio ♣',
    'Lancinante 🌀',
    'Ricordo 🎁', //24
    '🍔🍔🍔Hatha 🧘',
    '🍔🍔🍔Vinyasa 🧘',
    'Massaggio 💆',
    'Riciclado 🌲',
    'Espresso ☕', //29
    'GlutineZero 🌽',
    '🍔🍔🍔Cocktails 🍹',
    'Birra 🍺',
    'Musica 🎵',
    'Cinese 🍜', //34
    'Anatra 🍱',
    '🍔🍔🍔Rock 🎸',
    '🍔🍔🍔LiveDJ 🎧',
    'Terrazza ☀️',
    'Semi 🌱', //39
    'Macina 🍌',
    '🍔🍔🍔Papers 🚬',
    'Consigli 🌴',
    '🍔🍔🍔Calzone 🥟',
    '🍔🍔🍔Falafel 🥙', //44
    'Trucco 🤡',
    'Regali 🎁',
    'Spuntino 🍠',
    'Bevande 🍹',
    '🍔🍔🍔Piadina 🌮', //49
    'Fromaggio 🧀',
    'Cereali 🌾',
    'Moda 👗',
    'Giusto 🤗',
    'Donne 👩', //54
    'Beres 🍹',
    'Tivù 📺',
    'Retrò 🦄',
    '🍔🍔🍔Feta 🐐',
    '🍔🍔🍔WiFi', //59
    '🍔🍔🍔BTC',
    '🍔🍔🍔BCH',
    '🍔🍔🍔BSV',
    '🍔🍔🍔ETH',
    '🍔🍔🍔HotDog 🌭', //64
    'Rapido ⏩',
    '🍔🍔🍔Kosher 🦄',
    '🍔🍔🍔Sushi 🍣',
    'Motociclo 🛵',
    'Macchina 🚘', //69
    '🍔🍔🍔GoCrypto',
    'Pollo 🐔',
    'Coniglio 🐰',
    'Patata 🥔',
    '🍔🍔🍔Kumpir 🥔', //74
    '🍔🍔🍔Kebap 🐄',
    'Cajero 🏦',
    '🍔🍔🍔Gyros 🐖',
    'Cocco 🥥',
    'Levare 📦', //79
    'Meditazione 🧘',
    'Vino 🍷',
    '🍔🍔🍔Champagne 🥂',
    'Alcool 🍾',
    '🍔🍔🍔Booze 🥃', //84
    'Frittella 🥞', //You cant remove because we use fixed indexes, but replace with another string that is unlikely to be typed in by the user
    '🍔🍔🍔Croissant 🥐',
    '🍔🍔🍔Popcorn 🍿',
    '🍔🍔🍔SoftIce 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️', //90
    'Taglio ✂️',
    'Caramella 🍭',
    'Bellezza 💅',
    '🍔🍔🍔Miso 🍱',
    'Cioccolato 🍫', //95
    'Riso 🍚',
    'FruttiMare 🦀',
    'Ostello 🛏️',
    'Patatine 🍟',
    'Pesce 🐟', //100
    'Fritte 🍟',
    '🍔🍔🍔Italiano 🇮🇹',
    'Whisky 🥃',
    '🍔🍔🍔Rum 🥃', //This is number 104 the no tag indicator, currently not used
    '🍔🍔🍔Bourbon 🥃', //105
    'Liquore 🥃',
    'Uomini ♂️',
    'Pasta 🍝',
    'Dolce 🍬', //109
    'Antipasto 🥠', //110
    '🍔🍔🍔BBQ 🍗',
    'Tagliatelle 🍜',
    'Coreana 🥟',
    'Mercato 🧺', //114 invisible item
    'Pane 🥖',
    'Forno 🥨',
    'Caffé ☕',
    'Giochi 🎮',
    'Spuntini 🍿', //119
    'Elegante 🕴️',
    '🍔🍔🍔Piano 🎹',
    '🍔🍔🍔Brunch 🍱',
    '🍔🍔🍔Nachos 🌽',
    'Pranzo 🥡',
    'Colazione 🥐', //125
    'Aperitivo 🥳', //hidden item
    'NotteFonda 🌜',
    'Messicana 🇲🇽',
    '🍔🍔🍔Burrito 🌯',
    '🍔🍔🍔Tortilla 🌮', //130
    'Indonesiana 🇮🇩',
    'Sportivo 🏆',
    'Pasticcino 🥧',
    '🍔🍔🍔Bistro 🍲',
    'Zuppa 🥣', //135
    'Tè 🍵',
    'Cipolla',
    'Bistecca 🥩',
    'Scossa 🥤',
    '🍔🍔🍔Empanadas 🥟', //140
    'Cena 🍽️',
    'Zuccherino 🍭',
    'Fritto 🍳',
    'Frittata 🥚',
    '🍔🍔🍔Gin 🍸', //145
    'Ciambella 🍩',
    'Consegna 🚚',
    'Tazze ☕',
    'Filtro',
    'Succo 🍊', //150
    'Vietnamita 🇻🇳',
    '🍔🍔🍔Torta 🥮', //invisible item
    '🍔🍔🍔Unagi 🐡',
    'Greca 🇬🇷',
    'Giapponese 🇯🇵', //155
    '🍔🍔🍔Tacos 🌮',
    '🍔🍔🍔Kombucha 🍵',
    'Indiano 🇮🇳',
    '🍔🍔🍔Nan 🥪', //
    '🍔🍔🍔Club 🎶', //160
    'Miele 🍯',
    'Billard 🎱',
    'Albergo 🏨',
    'Maiale 🥓',
    'Costolette 🍖', //165
    '🍔🍔🍔Kava 🍵',
    '🍔🍔🍔Chai 🍵',
    '🍔🍔🍔Izzy 🍵',
    '🍔🍔🍔Matcha 🍵',
    '🍔🍔🍔Oden 🍢', //170
    '🍔🍔🍔Latte ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex', //175
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };

  static final tagTextFR = const {
    'Épicé 🌶️', //0 //TODO filter for éÈ
    'Salé 🥨',
    'Acide 😜',
    'Bio 🐵',
    'Végétarien 🥕', //4
    'Végétalienne 🐮',
    'Sain 💓',
    '🍔🍔🍔Burger 🍔',
    'Baguette 🥪',
    '🍔🍔🍔Muffin 🧁', //9 The muffin icon is invisible
    'Lutin 🥮', //10 Brownie is invisible too
    'Gâteau 🎂',
    'Biscuit 🍪',
    'Arabe 🥙',
    '🍔🍔🍔Pizza 🍕', //14
    'Salade 🥗',
    '🍔🍔🍔Smoothie 🥤',
    '🍔🍔🍔Fruit 🍓',
    'Glace 🍦',
    'Écru 🥦', //19
    'Sac 👜',
    'Cosmétique 💅',
    'Tatouage ♣',
    'Perçant 🌀',
    '🍔🍔🍔Souvenir 🎁', //24
    '🍔🍔🍔Hatha 🧘',
    '🍔🍔🍔Vinyasa 🧘',
    '🍔🍔🍔Massage 💆',
    'Recyclé 🌲',
    'Café ☕', //29
    'SansGluten 🌽',
    'Cocktails 🍹',
    'Bière 🍺',
    'Musique 🎵',
    'Chinoise 🍜', //34
    'Canard 🍱',
    '🍔🍔🍔Rock 🎸',
    '🍔🍔🍔LiveDJ 🎧',
    'Terrasse ☀️',
    'Graines 🌱', //39
    '🍔🍔🍔Grinder 🍌',
    'Papiers 🚬',
    'Conseil 🌴',
    '🍔🍔🍔Calzone 🥟',
    '🍔🍔🍔Falafel 🥙', //44
    'Maquillage 🤡',
    'Cadeaux 🎁',
    '🍔🍔🍔Tapas 🍠',
    '🍔🍔🍔Copas 🍹',
    '🍔🍔🍔Piadina 🌮', //49
    'Fromage 🧀',
    '🍔🍔🍔Grains 🌾',
    'Mode 👗',
    'Juste 🤗',
    'Femme 👩', //54
    'Boissons 🍹',
    'Télé 📺',
    'Rétro 🦄',
    '🍔🍔🍔Feta 🐐',
    '🍔🍔🍔WiFi', //59
    '🍔🍔🍔BTC',
    '🍔🍔🍔BCH',
    '🍔🍔🍔BSV',
    '🍔🍔🍔ETH',
    '🍔🍔🍔HotDog 🌭', //64
    'Vite ⏩',
    '🍔🍔🍔Kosher 🦄',
    '🍔🍔🍔Sushi 🍣',
    '🍔🍔🍔Moto 🛵',
    'Voiture 🚘', //69
    '🍔🍔🍔GoCrypto',
    'Poulet 🐔',
    'Lapine 🐰',
    'Patate 🥔',
    '🍔🍔🍔Kumpir 🥔', //74
    '🍔🍔🍔Kebap 🐄',
    '🍔🍔🍔ATM 🏦',
    '🍔🍔🍔Gyros 🐖',
    'Coco 🥥',
    'Emporter 📦', //79
    'Méditation 🧘',
    'Vin 🍷',
    'Champagner 🥂',
    'Alcool 🍾',
    '🍔🍔🍔Booze 🥃', //84
    'Crêpes 🥞', //You cant remove because we use fixed indexes, but replace with another string that is unlikely to be typed in by the user
    '🍔🍔🍔Croissant 🥐',
    '🍔🍔🍔Popcorn 🍿',
    '🍔🍔🍔SoftIce 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️', //90
    'Coupe ✂️',
    'Bonbon 🍭',
    'Beauté 💅',
    '🍔🍔🍔Miso 🍱',
    'Chocolat 🍫', //95
    'Riz 🍚',
    'FruitDeMer 🦀',
    'Auberge 🛏️',
    'Frites 🍟',
    'Poisson 🐟', //100
    'PommesF. 🍟',
    'Italienne 🇮🇹',
    'Whisky 🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104 //This is number 104 the no tag indicator, currently not used
    '🍔🍔🍔Bourbon 🥃', //105
    'Spiritueux 🥃',
    'Hommes ♂️',
    'Pâtes 🍝',
    '🍔🍔🍔Dessert 🍬', //109
    'Entrée 🥠', //110
    'Barbecue 🍗',
    'Nouille 🍜',
    'Coréen 🥟',
    'Marché 🧺', //114 invisible item
    'Pain 🥖',
    'Boulangerie 🥨',
    'Cafe ☕',
    'Jeux 🎮',
    'Collations 🍿', //119
    'Élégante 🕴️',
    '🍔🍔🍔Piano 🎹',
    '🍔🍔🍔Brunch 🍱',
    '🍔🍔🍔Nachos 🌽',
    'Déjeuner 🥡',
    'PetitDéj. 🥐', //125
    '🍔🍔🍔HappyHour 🥳', //hidden item
    'Nuit 🌜',
    'Mexicaine 🇲🇽',
    '🍔🍔🍔Burrito 🌯',
    '🍔🍔🍔Tortilla 🌮', //130
    'Indonésienne 🇮🇩',
    'Sportif 🏆',
    'Pâtisserie 🥧',
    '🍔🍔🍔Bistro 🍲',
    'Soupe 🥣', //135
    'Thé 🍵',
    'Oignon',
    'Bifteck 🥩',
    'Secoue 🥤',
    '🍔🍔🍔Empanadas 🥟', //140
    'Dîner 🍽️',
    'Sucré 🍭',
    'Frit 🍳',
    '🍔🍔🍔Omelette 🥚',
    '🍔🍔🍔Gin 🍸', //145
    'Beignet 🍩',
    'Livraison 🚚',
    'Tasses ☕',
    'Filtre',
    'Jus 🍊', //150
    'Vietnamienne 🇻🇳',
    'Tarte 🥮', //invisible item
    '🍔🍔🍔Unagi 🐡',
    'Grecque 🇬🇷',
    'Japonaise 🇯🇵', //155
    '🍔🍔🍔Tacos 🌮',
    '🍔🍔🍔Kombucha 🍵',
    'Indienne 🇮🇳',
    '🍔🍔🍔Nan 🥪', //
    '🍔🍔🍔Club 🎶', //160
    'Miel 🍯',
    'Billard 🎱',
    'Hôtel 🏨',
    'Porc 🥓',
    'Côtes 🍖', //165
    '🍔🍔🍔Kava 🍵',
    '🍔🍔🍔Chai 🍵',
    '🍔🍔🍔Izzy 🍵',
    '🍔🍔🍔Matcha 🍵',
    '🍔🍔🍔Oden 🍢', //170
    'Lait ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex', //175
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };

  static final tagTextDE = const {
    'Würzig 🌶️', //0
    'Salzig 🥨',
    'Sauer 😜',
    'Biologisch 🐵',
    'Vegetarisch 🥕', //4
    'Vegan 🐮',
    'Gesund 💓',
    '🍔🍔🍔Burger 🍔',
    'Stulle 🥪',
    '🍔🍔🍔Muffin 🧁', //9 The muffin icon is invisible
    '🍔🍔🍔Brownie 🥮', //10 Brownie is invisible too
    'Kuchen 🎂',
    'Kekse 🍪',
    'Arabisch 🥙',
    '🍔🍔🍔Pizza 🍕', //14
    'Salat 🥗',
    '🍔🍔🍔Smoothie 🥤',
    'Früchte 🍓',
    'Eis 🍦',
    'Roh 🥦', //19
    'Handtasche 👜',
    'Kosmetik 💅',
    '🍔🍔🍔Tatu ♣',
    '🍔🍔🍔Piercing 🌀',
    '🍔🍔🍔Souvenir 🎁', //24
    '🍔🍔🍔Hatha 🧘',
    '🍔🍔🍔Vinyasa 🧘',
    '🍔🍔🍔Massage 💆',
    '🍔🍔🍔Upcycled 🌲',
    'Kaffee ☕', //29
    'GlutenFrei 🌽',
    '🍔🍔🍔Cocktails 🍹',
    'Bier 🍺',
    '🍔🍔🍔Musik 🎵',
    'Chines. 🍜', //34
    'Ente 🍱',
    '🍔🍔🍔Rock 🎸',
    '🍔🍔🍔LiveMusik 🎧',
    'Terasse ☀️',
    'Samen 🌱', //39
    'Mühle 🍌',
    'Blättchen 🚬',
    'Beratung 🌴',
    '🍔🍔🍔Calzone 🥟',
    '🍔🍔🍔Falafel 🥙', //44
    'Schminke 🤡',
    'Geschenke 🎁',
    '🍔🍔🍔Tapas 🍠',
    'Gläser 🍹',
    '🍔🍔🍔Piadina 🌮', //49
    'Käse 🧀',
    'Körner 🌾',
    'Mode 👗',
    '🍔🍔🍔Fair 🤗',
    'Frauen 👩', //54
    'Getränke 🍹',
    'Fernseher 📺',
    '🍔🍔🍔Retro 🦄',
    'Ziegenkäse 🐐',
    '🍔🍔🍔WiFi', //59
    'BTC',
    'BCH',
    'BSV',
    'ETH',
    'Wurst 🌭', //64
    'Schnell ⏩',
    '🍔🍔🍔Kosher 🦄',
    '🍔🍔🍔Sushi 🍣',
    'Motorrad 🛵',
    'Auto 🚘', //69
    'GoCrypto',
    'Huhn 🐔',
    'Hase 🐰',
    'Kartoffel 🥔',
    '🍔🍔🍔Kumpir 🥔', //74
    'Döner 🐄',
    'Geldautomat 🏦',
    '🍔🍔🍔Gyros 🐖',
    'Kokosnuss 🥥',
    'Mitnehmen 📦', //79
    '🍔🍔🍔Meditation 🧘',
    'Wein 🍷',
    'Champagner 🥂',
    'Alkohol 🍾',
    'Schnaps 🥃', //84
    'Pfannkuchen 🥞', //
    '🍔🍔🍔Croissant 🥐',
    '🍔🍔🍔Popcorn 🍿',
    'SoftEis 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️', //90
    'Haarschnitt ✂️',
    'Süßes 🍭',
    'Schönheit 💅',
    '🍔🍔🍔🍔Miso 🍱',
    'Schokolade 🍫', //95
    'Reis 🍚',
    'Meeresfr. 🦀',
    'Herberge 🛏️',
    'Fritten 🍟',
    'Fisch 🐟', //100
    'Pommes 🍟',
    'Ital. 🇮🇹',
    '🍔🍔🍔Whiskey 🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104 //This is number 104 the no tag indicator, currently not used
    '🍔🍔🍔Bourbon 🥃', //105
    'Shots 🥃',
    'Männer ♂️',
    'Spaghetti 🍝',
    'Nachtisch 🍬', //109
    'Vorspeise 🥠', //110
    'Grill 🍗',
    'Nudeln 🍜',
    'Korean. 🥟',
    'Markt 🧺', //114 invisible item
    'Brot 🥖',
    'Bäckerei 🥨',
    '🍔🍔🍔Cafe ☕',
    'Spiele 🎮',
    '🍔🍔🍔Snacks 🍿', //119
    '🍔🍔🍔Elegant 🕴️',
    'Klavier 🎹',
    '🍔🍔🍔Brunch 🍱',
    '🍔🍔🍔Nachos 🌽',
    'Mittag 🥡',
    'Frühstück 🥐', //125
    '🍔🍔🍔HappyHour 🥳', //hidden item
    'Nachts 🌜',
    'Mexikan. 🇲🇽',
    '🍔🍔🍔Burrito 🌯',
    '🍔🍔🍔Tortilla 🌮', //130
    'Indones. 🇮🇩',
    'Sport 🏆',
    'Torte 🥧',
    'Bistrot 🍲',
    'Suppe 🥣', //135
    'Tee 🍵',
    'Zwiebeln',
    'Steak 🥩',
    '🍔🍔🍔Shakes 🥤',
    '🍔🍔🍔Empanadas 🥟', //140
    'Abendmahl 🍽️',
    'Süßigk. 🍭',
    'Fritiert 🍳',
    '🍔🍔🍔Omelette 🥚',
    '🍔🍔🍔Gin 🍸', //145
    '🍔🍔🍔Donut 🍩',
    'Lieferung 🚚',
    'Tassen ☕',
    '🍔🍔🍔Filter',
    'Saft 🍊', //150
    'Vietnam. 🇻🇳',
    'Kuchen 🥮', //invisible item
    '🍔🍔🍔Unagi 🐡',
    'Griech. 🇬🇷',
    'Japan. 🇯🇵', //155
    '🍔🍔🍔Tacos 🌮',
    '🍔🍔🍔Kombucha 🍵',
    'Indien 🇮🇳',
    '🍔🍔🍔Nan 🥪', //
    '🍔🍔🍔Club 🎶', //160
    'Honig 🍯',
    'Billard 🎱',
    '🍔🍔🍔Hotel 🏨',
    'Schwein 🥓',
    'Rippchen 🍖', //165
    '🍔🍔🍔Kava 🍵',
    '🍔🍔🍔Chai 🍵',
    '🍔🍔🍔Izzy 🍵',
    '🍔🍔🍔Matcha 🍵',
    '🍔🍔🍔Oden 🍢', //170
    'Milch ☕',
    '🍔🍔🍔DASHText Ð',
    '🍔🍔🍔CoinTigo',
    '🍔🍔🍔CoinText',
    '🍔🍔🍔Salamantex', //175
    '🍔🍔🍔CryptoBuyer',
    '🍔🍔🍔XPay',
    '🍔🍔🍔Panmoni'
  };

  static final tagTextES = const {
    'Picante 🌶️', //0
    'Salado 🥨',
    'Acido 😜',
    'Ecologico 🐵',
    'Vegetariano 🥕', //4
    'Vegano 🐮',
    'Saludable 💓',
    'Hamburguesa 🍔',
    'Bocadillo 🥪',
    '🍔🍔🍔Muffin 🧁', //9 The muffin icon is invisible
    '🍔🍔🍔Brownie 🥮', //10 Brownie is invisible too
    'Tarta 🎂',
    'Galletas 🍪',
    'Árabe 🥙',
    '🍔🍔🍔Pizza 🍕', //14
    'Ensalada 🥗',
    'Jugo 🥤',
    'Fruta 🍓',
    'Helado 🍦',
    'Crudo 🥦', //19
    'Bolsas 👜',
    'Cosmética 💅',
    'Tatuaje ♣',
    '🍔🍔🍔Piercing 🌀',
    'Recuerdo 🎁', //24
    '🍔🍔🍔Hatha 🧘',
    '🍔🍔🍔Vinyasa 🧘',
    'Masaje 💆',
    'Reciclado 🌲',
    '🍔🍔🍔Coffee ☕', //29
    'SinGluten 🌽',
    'Cócteles 🍹',
    'Cerveza 🍺',
    'Música 🎵',
    'Chino 🍜', //34
    'Pato 🍱',
    'Rock 🎸',
    'EnVivo 🎧',
    'Terraza ☀️',
    'Semillas 🌱', //39
    'Grinder 🍌',
    'Papeles 🚬',
    'Consejos 🌴',
    '🍔🍔🍔Calzone 🥟',
    '🍔🍔🍔Falafel 🥙', //44
    'Maquillaje 🤡',
    'Regalos 🎁',
    '🍔🍔🍔Tapas 🍠',
    '🍔🍔🍔Copas 🍹', //TODO english translation???
    '🍔🍔🍔Piadina 🌮', //49
    'Queso 🧀',
    'Granos 🌾',
    'Moda 👗',
    'Justo 🤗',
    'Mujer 👩', //54
    'Refresco 🍹',
    'Tele 📺',
    '🍔🍔🍔Retro 🦄',
    '🍔🍔🍔Feta 🐐',
    '🍔🍔🍔WiFi', //59
    'Centro Comercial', //'BTC',
    'Hipermercado', //'BCH',
    'Cigarro', //'Anypay',
    'Recarga', //'ETH',
    'PerroCal. 🌭', //64
    'Rapido ⏩',
    '🍔🍔🍔Kosher 🦄',
    '🍔🍔🍔Sushi 🍣',
    'Moto 🛵', //TODO translate in original to english
    'Coche 🚘', //69
    '', //GoCrypto
    'Pollo 🐔',
    'Conejo 🐰',
    'Patata 🥔',
    '🍔🍔🍔Kumpir 🥔', //74
    '🍔🍔🍔Kebap 🐄',
    '🍔🍔🍔ATM 🏦',
    '🍔🍔🍔Gyros 🐖',
    'Coco 🥥',
    'Llevar 📦', //79
    'Meditación 🧘',
    'Vino 🍷',
    '🍔🍔🍔Champagne 🥂',
    'Alcool 🍾',
    '🍔🍔🍔Booze 🥃', //84
    'Panqueques 🥞', //You cant remove because we use fixed indexes, but replace with another string that is unlikely to be typed in by the user
    '🍔🍔🍔Croissant 🥐',
    'Palomitas 🍿',
    '🍔🍔🍔SoftIce 🍦',
    '🍔🍔🍔Dango 🍡',
    '🍔🍔🍔BnB 🛏️', //90
    'CortePelo ✂️',
    'Caramelo 🍭',
    'Belleza 💅',
    '🍔🍔🍔Miso 🍱',
    'Chocolate 🍫', //95
    'Riso 🍚',
    'Mariscos 🦀',
    '🍔🍔🍔Hostel 🛏️',
    'Patatas 🍟',
    'Pescado 🐟', //100
    'Fritas 🍟',
    '🍔🍔🍔Italiano 🇮🇹',
    'Whisky 🥃',
    '🍔🍔🍔ラム🥃', //NOTAG INDICATOR 104 //This is number 104 the no tag indicator, currently not used
    'Borbón 🥃', //105
    'Licor 🥃',
    'Hombres ♂️',
    'Pasta 🍝',
    'Postre 🍬', //109
    'Aperitivo 🥠', //110
    'Barbacoa 🍗',
    'Fideos 🍜',
    'Coreano 🥟',
    'Mercado 🧺', //114 invisible item
    'Pan 🥖',
    'Panadería 🥨',
    'Café ☕',
    'Juegos 🎮',
    'Merienda 🍿', //119
    'Elegante 🕴️',
    '🍔🍔🍔Piano 🎹',
    'Desalmuerzo 🍱',
    '🍔🍔🍔Nachos 🌽',
    'Almuerzo 🥡',
    'Desayuno 🥐', //125
    '🍔🍔🍔HappyHour 🥳', //hidden item
    'Noche 🌜',
    'Mexicano 🇲🇽',
    '🍔🍔🍔Burrito 🌯',
    '🍔🍔🍔Tortilla 🌮', //130
    'Indonesio 🇮🇩',
    'Deportes 🏆',
    'Pasteles 🥧',
    'Bistro 🍲',
    'Sopa 🥣', //135 //TODO FIX EMOJICONS AFTER TRANSLATION SOME GET LOST
    'Té 🍵', //TODO translate all accent letters to normal to show them as suggestions
    'Cebolla',
    '🍔🍔🍔Steak 🥩',
    'Zumo 🥤',
    '🍔🍔🍔Empanadas 🥟', //140
    'Cena 🍽️',
    'Bonbon 🍭',
    'Frito 🍳',
    'Tortilla 🥚',
    '🍔🍔🍔Gin 🍸', //145
    'Donas 🍩',
    'Entrega 🚚',
    'Copas ☕',
    'Filtro',
    'Jugo 🍊', //150
    'Vietnamita 🇻🇳',
    '🍔🍔🍔Pie 🥮', //invisible item
    '🍔🍔🍔Unagi 🐡',
    'Griego 🇬🇷',
    'Japonés 🇯🇵', //155
    '🍔🍔🍔Tacos 🌮',
    '🍔🍔🍔Kombucha 🍵',
    '🍔🍔🍔Indio 🇮🇳',
    '🍔🍔🍔Nan 🥪', //
    '🍔🍔🍔Club 🎶', //160
    'Miel 🍯',
    '🍔🍔🍔Pool 🎱',
    '🍔🍔🍔Hotel 🏨',
    'Cerdo 🥓',
    'Costillas 🍖', //165
    '🍔🍔🍔Kava 🍵',
    '🍔🍔🍔Chai 🍵',
    '🍔🍔🍔Izzy 🍵',
    '🍔🍔🍔Matcha 🍵',
    '🍔🍔🍔Oden 🍢', //170
    '🍔🍔🍔Latte ☕',
    'Piscina', //'DASHText Ð',
    'Pire acond.', //'CoinTigo',
    'Planta Electr.', //'CoinText',
    'Alquiler', //'Salamantex',//175
    'Bodegon', //'CryptoBuyer',
    'Kiosco', //'XPay',
    'Electro', //'Panmoni'
    'Telefonos', //180
    'Estacionamiento',
    'Accesorios',
    'Zapatos',
    'Playa',
    'Rio', //185
    'Naturista',
    'Importado',
    'Bicicleta',
    'Harina',
    'Limpieza', //190
    'Jabon',
    'Detergente',
    'Farmacia',
    'Azucar',
    'Tarjeta Sim', //195
    'MicroSD',
    'Bateria',
    'Agua',
    'Reloj', //200,
    'Llave',
    'Candado',
    'Mascota',
    'Nino',
    'Pelicula', //205
    'Foto',
    'Camara',
    'Seguridad',
    'Colchon',
    'Mantenimiento', //210
    'Lavadora',
    'Salsicha',
    'Huevo',
    'Leche'
  };
}
