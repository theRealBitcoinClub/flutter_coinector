'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "apple-icon-120x120.png": "5baa370f804026ca8799c62e59e01bd3",
"apple-icon-72x72.png": "c9bef1b0d58dcab547ea9c3013285c35",
"ms-icon-310x310.png": "280547830348cadb6b86bdb171e4fa80",
"apple-icon-152x152.png": "28416b99ea86609c7c124e4464cf555c",
"ms-icon-144x144.png": "ac1d9ef1c03a9828f07ea3711f06d722",
"apple-icon-144x144.png": "ac1d9ef1c03a9828f07ea3711f06d722",
"favicon.ico": "3f720ae57855fc086345bf2357fd37a3",
"favicon-32x32.png": "55fcfc5947576702e3c2e5a9c7a726b7",
"ms-icon-70x70.png": "b6ad81371c13cab7c2502c00dfc3e643",
"manifest.json": "44a0d5258eb35d65c0d738cb1894f257",
"android-icon-36x36.png": "d610da37d6baf51210bf197ad1b97883",
"android-icon-192x192.png": "ec75a67b15b324824dd76646d51b34f5",
"favicon-96x96.png": "5e69d450e3c74ee0e6cfeb71420b0d09",
"apple-icon-76x76.png": "6ad8880d12dc04a5940853ba6dc8f18a",
"android-icon-72x72.png": "c9bef1b0d58dcab547ea9c3013285c35",
"bitcoincashmaplogo640x480.jpg": "8184a42cfad772e3f265af520aefae94",
"apple-icon.png": "a48e57921307ed6d60553156f5f488df",
"apple-icon-precomposed.png": "a48e57921307ed6d60553156f5f488df",
"apple-icon-57x57.png": "ef09cb2ec79ab0b4b53017ce6aac37ca",
"android-icon-48x48.png": "8e98824d99f9d7f8483f4ac1d9246d78",
"main.dart.js": "5e3d8280cc7174887ae1e25c9070dc38",
"logo1200x630.png": "ef03133c4c39ac9777cff2c3dea3af99",
"android-icon-96x96.png": "5e69d450e3c74ee0e6cfeb71420b0d09",
"apple-icon-114x114.png": "af692900e144af645b776fe653e4907c",
"apple-icon-60x60.png": "0f59e7850aee8231c5476f34f5e7b028",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"android-icon-144x144.png": "ac1d9ef1c03a9828f07ea3711f06d722",
"favicon-16x16.png": "c2041d9d7514f24af2f2172bbb91e1d2",
"ms-icon-150x150.png": "a51f6d4856d44b5c023e7fa54453ada6",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "b4c79d385269671665c307df0a3383cc",
"/": "b4c79d385269671665c307df0a3383cc",
"apple-icon-180x180.png": "74561a32272aa94331693fa2ff7a875c",
"assets/NOTICES": "23d93a20edc5007e6805aaeb4c4ff054",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.json": "14f00393dafc9da9f2364b6165cf329e",
"assets/assets/e.json": "8de152d12f29d67bcd2bad7fc3d7a862",
"assets/assets/am-ven.json": "a61d705f6e893e5eeb15f967f463c78c",
"assets/assets/am.json": "8cd7ea3a9ecb4b90c25471d3b8141e93",
"assets/assets/e-spa.json": "f2ac393d8d81e491f2be920a5e87d561",
"assets/assets/placesId.json": "c1e7ecd6919c5deb1001a7c42be8236b",
"assets/assets/au.json": "d6100ce2357a1205feff5bdf7f0bf98d",
"assets/assets/am-ven-car.json": "ec27057693880ca75995141d3108602d",
"assets/assets/as.json": "b58d2ce7a6c8d7cffd249f09e5156d8e",
"assets/assets/as-jap.json": "1e4f200d57b504b7d0b7278be56fb0bc",
"assets/assets/flutter_i18n/id.json": "5eeab732fbf3e0b3100be60ca4d26267",
"assets/assets/flutter_i18n/de.json": "e934c0309585489ffa1db59a216333a6",
"assets/assets/flutter_i18n/en.json": "517ea2c91e4c84a6d45586fc0b8bf9ca",
"assets/assets/flutter_i18n/es.json": "a1725af3715788418921cb9a2e6ff8b4",
"assets/assets/flutter_i18n/it.json": "b8fd4ff3275f2875b25cf4d1805bc3b8",
"assets/assets/flutter_i18n/fr.json": "00a76f4fadb3cee58463aabffa6e1786",
"assets/assets/flutter_i18n/ja.json": "328967020bd3d94ad3de19e1459930b6",
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
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
    return self.skipWaiting();
  }
  if (event.message === 'downloadOffline') {
    downloadOffline();
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
