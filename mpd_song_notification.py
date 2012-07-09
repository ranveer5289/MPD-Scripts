#!/usr/bin/python
import gobject
import pynotify
from mpdor.client import Client
from mpdor.protocol import MPDProtocolClient

pynotify.init("Currently Playing")
ICON = "/home/ranveer/.images/mpd.png"

class MPDNotification(Client):
    def on_player_song_start(self, client, songdata):
        notification(songdata)
	
def callback(source, condition):
    source._get_response()
    source.idle()
    return True

def notification(songdata):
    if "artist" in songdata.__dict__:
        string_to_notify = "{0}  by  {1}".format(songdata.title, songdata.artist)
        notification_show = pynotify.Notification("Currently Playing",
                                                   string_to_notify, ICON)
        notification_show.show()

if __name__ == "__main__":
	c = MPDNotification()
	c = MPDProtocolClient()
	c.connect_to_server("localhost", 6600)
	c.idle()
	gobject.io_add_watch(c, gobject.IO_IN, callback)
	gobject.MainLoop().run()
