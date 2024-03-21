from flask import Flask, redirect, render_template, flash
from flask_debugtoolbar import DebugToolbarExtension
import os

from models import db, connect_db, Playlist, Song, PlaylistSong
from forms import NewSongForPlaylistForm, SongForm, PlaylistForm

app = Flask(__name__)
# Please do not modify the following line on submission
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get(
    'DATABASE_URL', 'postgresql:///playlist-app')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

app.config['SECRET_KEY'] = "I'LL NEVER TELL!!"

# Having the Debug Toolbar show redirects explicitly is often useful;
# however, if you want to turn it off, you can uncomment this line:
#
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

debug = DebugToolbarExtension(app)


connect_db(app)
with app.app_context():
    # db.drop_all()
    db.create_all()

@app.route("/")
def root():
    """Homepage: redirect to /playlists."""

    return redirect("/playlists")


##############################################################################
# Playlist routes


@app.route("/playlists")
def show_all_playlists():
    """Return a list of playlists."""

    playlist = Playlist.query.all()
    return render_template("playlists.html", playlists=playlist)


@app.route("/playlists/<int:playlist_id>")
def show_playlist(playlist_id):
    """Show detail on specific playlist."""

    # ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK
    playlist = Playlist.query.get_or_404(playlist_id)
    songs = playlist.songs
    return render_template("playlist.html", playlist=playlist, songs=songs)


@app.route("/playlists/add", methods=["GET", "POST"])
def add_playlist():
    """Handle add-playlist form:

    - if form not filled out or invalid: show form
    - if valid: add playlist to SQLA and redirect to list-of-playlists
    """

    # ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK
    form = PlaylistForm()
    
    if form.validate_on_submit():
        name = form.name.data
        description = form.description.data

        playlist = Playlist(name=name, description=description)
        with app.app_context():
            db.session.add(playlist)
            db.session.commit()

        flash(f"Added a playlist {playlist}")
        return redirect('/playlists')
    else:
        return render_template("new_playlist.html", form=form)


##############################################################################
# Song routes


@app.route("/songs")
def show_all_songs():
    """Show list of songs."""

    songs = Song.query.all()
    return render_template("songs.html", songs=songs)


@app.route("/songs/<int:song_id>")
def show_song(song_id):
    """return a specific song"""

    # ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK
    song = Song.query.get_or_404(song_id)
    playlists = song.playlists
    return render_template("song.html", song=song, playlists=playlists)


@app.route("/songs/add", methods=["GET", "POST"])
def add_song():
    """Handle add-song form:

    - if form not filled out or invalid: show form
    - if valid: add playlist to SQLA and redirect to list-of-songs
    """

    # ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK
    form = SongForm()

    if form.validate_on_submit():
        title = form.title.data
        artist = form.artist.data

        song = Song(title=title, artist=artist)
        with app.app_context():
            db.session.add(song)
            db.session.commit()

        flash(f"Added {artist}'s song {title}")
        return redirect('/songs')
    else:
        return render_template("new_song.html", form=form)


@app.route("/playlists/<int:playlist_id>/add-song", methods=["GET", "POST"])
def add_song_to_playlist(playlist_id):
    """Add a playlist and redirect to list."""

    # BONUS - ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK

    # THE SOLUTION TO THIS IS IN A HINT IN THE ASSESSMENT INSTRUCTIONS

    playlist = Playlist.query.get_or_404(playlist_id)
    form = NewSongForPlaylistForm()

    # Restrict form to songs not already on this playlist

    curr_on_playlist = [s.id for s in playlist.songs]
    choices = (db.session.query(Song.id, Song.title)
                .filter(Song.id.notin_(curr_on_playlist))
                .all())

    for choice in choices:    
        # Convert Song.id from int to     
        form.song.choices.append((str(choice[0]), choice[1]))
    
    # form.song.choices = (db.session.query(Song.id, Song.title)
    #                      .filter(Song.id.notin_(curr_on_playlist))
    #                      .all())
    
    if form.validate_on_submit():

        # ADD THE NECESSARY CODE HERE FOR THIS ROUTE TO WORK
        # This is one way you could do this ...
        playlist_song = PlaylistSong(song_id=form.song.data,
                                     playlist_id=playlist_id)
        db.session.add(playlist_song)
        print(form.song.data,'--------------------------',type(form.song.data))
        print(playlist_id,'----------------------------',type(playlist_id))
        print(playlist_song.playlist_id,'------------------------',playlist_song.song_id)
        
        # Here's another way you could do, which is slightly more ORM-ish:
        #
        # song = Song.query.get(form.song.data)
        # playlist.songs.append(song)

        # Either way, commit:
        with app.app_context():
            db.session.commit()

        return redirect(f"/playlists/{playlist_id}")

    return render_template("add_song_to_playlist.html",
                           playlist=playlist,
                           form=form)
