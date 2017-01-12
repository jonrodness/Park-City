var mapStyle = [{"featureType":"all","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#aadd55"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"on"}]},{"featureType":"road.arterial","elementType":"labels.text","stylers":[{"visibility":"on"}]},{"featureType":"road.local","elementType":"labels.text","stylers":[{"visibility":"on"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#0099dd"}]}]

function initializemap(locations, handlerw) {

  var arrayhash = [];
  for (i = 0; i < locations.length; i++) {
    var lat;
    var lon;
    lat = locations[i][0];
    lon = locations[i][1];
    var infoString = locations[i][2];
    var infotext = returnContent(locations, i);
    var obj = {
      "lat": lat,
      "lng": lon,
      "infowindow": infotext,
      "id": locations[i][6],
      picture: {
        url: 'http://alfredsin.com/images/tree-small.png',
        height: 50,
        width: 50
      }
    };
    arrayhash.push(obj);
    
  }
  return arrayhash;
}

function markerhandler(markers, arrayparks, directionsService, directionsDisplay){
  for (i=0; i < markers.length; i++){
    var obj = markers[i].serviceObject;
    var markerobj = markers[i].serviceObject;
    google.maps.event.addListener(markers[i].serviceObject, 'click', (function(obj, i) {
      var lat = obj.latLng.k.toFixed(6);
      var lon = obj.latLng.D.toFixed(6);
      var origin      = new google.maps.LatLng(41.850033, -87.6500523);
      var destination = new google.maps.LatLng(lat, lon);
      calcRoute(originPoint, destination, directionsService, directionsDisplay);
      directionsDisplay.setMap(handler.getMap());
      var id = parkidfinder(arrayparks, lat, lon);
      $("#event_park_id").val(id);
    })
    )
  }
};

function markerhandlerparks(markers, arrayparks, directionsService, directionsDisplay){
  for (i=0; i < markers.length; i++){
    var obj = markers[i].serviceObject;
    var markerobj = markers[i].serviceObject;
    google.maps.event.addListener(markers[i].serviceObject, 'click', (function(obj, i) {
      var lat = obj.latLng.k.toFixed(6);
      var lon = obj.latLng.D.toFixed(6);
      var id = parkidfinder(arrayparks, lat, lon);
      var offset = $("#"+id).position().top;
      $('#parkscontainer').scrollTop(0);
      alert(id);
      alert(offset);
      $('#parkscontainer').scrollTop(offset - 300);
      id = null;
    })
    )
  }
};

function parkidfinder(parkarray, lat, lon){
  for (i=0; i < parkarray.length; i++) {
    if ( (parkarray[i][0] == lat) && (parkarray[i][1] == lon) ){
      return parkarray[i][2];
    } 
  }
};

function calcRoute(origin, destination, directionsService, directionsDisplay) {

  var request = {
    origin:      origin,
    destination: destination,
    travelMode:  google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
      directionsDisplay.setPanel(document.getElementById('directions-panel'));
    }
  });
};

function displayOnMap(position){
  originPoint = new google.maps.LatLng(parseFloat(position.coords.latitude), parseFloat(position.coords.longitude));
  var displayText = "<h3>You are here! :D</h3><h4>Isn't that cool?</h4><p>We're stalking you...</p>"
  var iconMap = '/assets/fox.gif';
  myLatlong = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
  var marker = new google.maps.Marker({
    map: handler.getMap(),
    position: myLatlong,
    optimized: false,
    icon: iconMap
  });
  var infowindow = new google.maps.InfoWindow({
    content:"<h3>You are here! :D</h3><h4>Isn't that cool?</h4><p>We're stalking you...</p>"
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(handler.getMap(),marker);
  });
  handler.map.centerOn(marker);
};

function returnContent(loc, pos) {
  var returnText;
  returnText = "<h2>" + loc[pos][2] + "</h2>";
  returnText += "<p>" + loc[pos][3] + " " + loc[pos][4] + "</p>";
  returnText += "<p> Latitude: " + loc[pos][0] + "</p>";
  returnText += "<p> Longitude: " + loc[pos][1] + "</p>";
  returnText += "<h3>Features:</h3>";
  returnText += "<ul>";
  for (j = 0; j < loc[pos][5].length; j++) {
    returnText += "<li>";
    returnText += loc[pos][5][j];
    returnText += "</li>";

  }
  returnText += "</ul>";
  returnText += "<a class='btn btn-primary btn-padding' href='/this_park_events?park_param=" + loc[pos][6] + "'> View Events </a>";
  returnText += "<a class='btn btn-primary btn-padding' href='/events/new?park_param=" + loc[pos][6] + "'> Create Event </a>";

  return returnText;
};
