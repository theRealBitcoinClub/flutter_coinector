'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "font-awesome.min.css": "52e0947497241863100f97ca49093350",
"jssocials.css": "34c0a3f580b60afc46265539329a249a",
"old_favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "c5a67512432c05cbe8c81dfab7efdebf",
"manifest.json": "2249e5af1c6ddf5b637b5175bda8800d",
"jssocials.min.js": "81b383b7ec040274c775b85a465e3a06",
"base.css": "d41d8cd98f00b204e9800998ecf8427e",
"jquery-3.5.1.min.js": "12b69d0ae6c6f0c42942ae6da2896e84",
"main.dart.js": "4409f8533f430dd411544aaccfecbf69",
"jssocials-theme-classic.css": "e870cb4d3804fe4f3a28c678e5162242",
"share.html": "ebcb7e7abd7551735842c9aac1b2f8d0",
"icons/old_Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/old_Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"jssocials-theme-plain.css": "5ee9d7623ad0c2a3ed195d102a7e573a",
"style.css": "7b28b538bb989158a0443d065243c021",
"index.html": "c7e4aed49c988cfe96e9e5a0475003a1",
"/": "c7e4aed49c988cfe96e9e5a0475003a1",
"assets/NOTICES": "c3cd2224cd06211ff00dff6bf7f8e8fe",
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
"assets/assets/e.json": "f8a80e779d5c8af80d9105922108e3dd",
"assets/assets/am-ven.json": "9aa3995ee31ca69e0b624e250af4e090",
"assets/assets/am.json": "3fee5a5a9b4a57b498212063f8d25c72",
"assets/assets/e-spa.json": "9065f76dd40cbfab414e9c899f1a834f",
"assets/assets/placesId.json": "c1e7ecd6919c5deb1001a7c42be8236b",
"assets/assets/au.json": "1ba2ad9ac33ed7025d19c76da0ffe33d",
"assets/assets/am-ven-car.json": "f41fce3b3e0db8c170f2f8116ef47d8d",
"assets/assets/as.json": "c4f66f5d97a14d7614b4038aa92c96ce",
"assets/assets/as-jap.json": "b6863fee6a31b96a769884343228de94",
"assets/assets/flutter_i18n/id.json": "2ad665bc0a334136053d620a8de4b817",
"assets/assets/flutter_i18n/de.json": "0de764621d432f6bab5d7f90d496c66b",
"assets/assets/flutter_i18n/en.json": "187fc9065586026a38e5f5fb22fbbfc0",
"assets/assets/flutter_i18n/es.json": "c47806177c6045776604d88221e8ae3b",
"assets/assets/flutter_i18n/it.json": "c5c6ec2b10f1c6d0c889307cb787609f",
"assets/assets/flutter_i18n/fr.json": "793147dd02ae6716961b879376fad789",
"assets/assets/flutter_i18n/ja.json": "0adc1171d419beb9b3b5eb3c3dee2cda",
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
