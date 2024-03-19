"""Models for Playlist app."""

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Playlist(db.Model):
    """Playlist."""

    # ADD THE NECESSARY CODE HERE
    __tablename__ = "playlists"
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)
    description = db.Column(db.String(100))
    assignments = db.relationship('PlaylistSong', backref='playlist')
    songs = db.relationship('Song', 
                            secondary='playlists_songs', 
                            backref='playlists')


class Song(db.Model):
    """Song."""

    # ADD THE NECESSARY CODE HERE
    __tablename__ = "songs"

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.Text, nullable=False)
    artist = db.Column(db.Text, nullable=False)
    assignments = db.relationship('PlaylistSong', backref='song')
    # playlists = db.relationship('Playlist', 
    #                             secondary='playlists_songs', 
    #                             backref='songs')


class PlaylistSong(db.Model):
    """Mapping of a playlist to a song."""

    # ADD THE NECESSARY CODE HERE
    __tablename__ = "playlists_songs"

    id = db.Column(db.Integer, primary_key=True)
    playlist_id = db.Column(db.Integer, db.ForeignKey("playlists.id"), nullable=False)
    song_id = db.Column(db.Integer, db.ForeignKey("songs.id"), nullable=False)


# DO NOT MODIFY THIS FUNCTION
def connect_db(app):
    """Connect to database."""

    db.app = app
    db.init_app(app)
