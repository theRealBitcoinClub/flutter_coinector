import 'dart:typed_data';

import 'package:Coinector/ConfigReader.dart';
import 'package:http/http.dart' as http;

/// The Network Utility
class NetworkUtilityCoinector {
  static final _authority = 'maps.googleapis.com';
  static final _unencodedPath = 'maps/api/place/photo';

  static Future<String> fetchUrl(
    Uri uri, {
    Map<String, String> headers,
  }) async {
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(Duration(milliseconds: 1500));
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Uint8List> fetchImage(String photoReference,
      {int maxHeight, int maxWidth, var proxyUrl}) async {
    assert(photoReference != "");
    var queryParameters = _createParameters(
      ConfigReader.getGooglePlacesKey(),
      photoReference,
      maxHeight,
      maxWidth,
    );
    var uri = Uri.https(
      proxyUrl != null && proxyUrl != '' ? proxyUrl : _authority,
      proxyUrl != null && proxyUrl != ''
          ? 'https://$_authority/$_unencodedPath'
          : _unencodedPath,
      queryParameters,
    );
    var response = await fetchUrl(uri);
    if (response != null) {
      List<int> list = response.codeUnits;
      return Uint8List.fromList(list);
    }
    return null;
  }

  /// Prepare query Parameters
  static Map<String, String> _createParameters(
    String apiKEY,
    String photoReference,
    int maxHeight,
    int maxWidth,
  ) {
    Map<String, String> queryParameters = {
      'photoreference': photoReference,
      'key': apiKEY,
    };
    if (maxHeight != null) {}
    if (maxWidth != null) {
      var item = {
        'maxwidth': maxWidth.toString(),
      };
      queryParameters.addAll(item);
    }
    return queryParameters;
  }
}
