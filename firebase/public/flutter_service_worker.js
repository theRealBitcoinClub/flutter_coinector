'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "font-awesome.min.css": "52e0947497241863100f97ca49093350",
"jssocials.css": "34c0a3f580b60afc46265539329a249a",
"old_favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "9e294a8deb08fa1ca46e5a4ef208bb6d",
"manifest.json": "2249e5af1c6ddf5b637b5175bda8800d",
"jssocials.min.js": "81b383b7ec040274c775b85a465e3a06",
"jquery-3.5.1.min.js": "12b69d0ae6c6f0c42942ae6da2896e84",
"main.dart.js": "f23e9cc187d2c65ce48fa44260561e94",
"share.html": "ecf76614157fe87e6193f2c98c801f4c",
"icons/old_Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/old_Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"jssocials-theme-plain.css": "5ee9d7623ad0c2a3ed195d102a7e573a",
"index.html": "1cf514a3b3b2c57e56e923e2ce1b6ecd",
"/": "1cf514a3b3b2c57e56e923e2ce1b6ecd",
"assets/NOTICES": "385347fe36c59429f15779e2a5e3886e",
"assets/packages/awesome_dialog/assets/flare/error.flr": "87d83833748ad4425a01986f2821a75b",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/error_without_loop.flr": "35b9b6c9a71063406bdac60d7b3d53e8",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.json": "2adf277b0b3efde8b95ff3bbd776aec7",
"assets/assets/e.json": "7754a3646e8007c875482c702a857b75",
"assets/assets/am-ven.json": "a9377368a86e48a68aff951a6ae7dff4",
"assets/assets/am.json": "d03614c549d2aa5079954a2b3e094882",
"assets/assets/e-spa.json": "d0b99eafff07176d8fccdba09e1c0d22",
"assets/assets/placesId.json": "c1e7ecd6919c5deb1001a7c42be8236b",
"assets/assets/au.json": "5567703e4008ab697195af75efd2500a",
"assets/assets/am-ven-car.json": "5c1e3420c3082c3237b8e3ddd47a456d",
"assets/assets/as.json": "da7a77cb8a4f3579c69b01eda3935327",
"assets/assets/as-jap.json": "f29dd6a6470500f8582f822f66fc53b2",
"assets/assets/flutter_i18n/id.json": "a8792df01835f04a7a4d798eaa2545dc",
"assets/assets/flutter_i18n/de.json": "00202090d6a239b887823ad586f0553e",
"assets/assets/flutter_i18n/en.json": "8bcc93579479b178f3789b0651fbf2db",
"assets/assets/flutter_i18n/es.json": "2212361e922a02ce5d1af34fbbab563e",
"assets/assets/flutter_i18n/it.json": "68cf2aa107e317957f7c41226097d171",
"assets/assets/flutter_i18n/fr.json": "a39ff1a0a3767d66f0ac8f2662b28ee8",
"assets/assets/flutter_i18n/ja.json": "de663060379c3baea2801f75b2d8233f",
"assets/assets/placeholder640x480.jpg": "8184a42cfad772e3f265af520aefae94",
"assets/assets/addr.json": "da6ee8795a017b2c14acb470b03b8625"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
