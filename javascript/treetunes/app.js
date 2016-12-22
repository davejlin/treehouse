var playlist = new Playlist();

var song1 = new Song("Song 1", "Artist 1", "2:00");
var song2 = new Song("Song 2", "Artist 2", "3:00");
var movie1 = new Movie("Movie 1", "2016", "2:00:00");
var movie2 = new Movie("Movie 2", "2015", "1:30:00");

playlist.add(song1);
playlist.add(song2);
playlist.add(movie1);
playlist.add(movie2);

var playlistElement = document.getElementById("playlist");

playlist.renderInElement(playlistElement);

var playButton = document.getElementById("play");
playButton.onclick = function() {
  playlist.play();
  playlist.renderInElement(playlistElement);
}
var nextButton = document.getElementById("next");
nextButton.onclick = function() {
  playlist.next();
  playlist.renderInElement(playlistElement);
}
var stopButton = document.getElementById("stop");
stopButton.onclick = function() {
  playlist.stop();
  playlist.renderInElement(playlistElement);
}