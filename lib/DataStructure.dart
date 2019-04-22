 /// For the moment we will use redundant data which we might normalize later if we run into any memory issues, therefore the mappings are not needed
 /// This file contains all the city and state codes to make sure they are unique, as const does not allow duplicates

class DataStructure {
  static final continents =
      const {'america', 'europe', 'africa', 'asia', 'australia'};
  /* static final statesMappedToContinents = const {
    'nha, nyo',
    'spa, fra, ger',
    'nig,tog,gha',
    'jap,chi,indi,indo',
    'nsw,vic'
  };*/
  static final states = const {'fra', 'ger', 'nha', 'nyo', 'spa'};
  /* static final citiesMappedToStates =
      const {'par,mar', 'ber,ham', 'por', 'nyc,alb', 'bar,mad'};*/
  static final cities = const {'bar', 'mad', 'mar', 'nyc', 'par', 'por'};
}
