#!/bin/bash

#Creates a MPD playlist of recently added songs.

date_today=$(date +%h" "%d)

echo "$(grep added /var/log/mpd/mpd.log | \

grep "$date_today"  |  \

awk -F "added " '{print $2}')" >> ~/MPDPlaylist/RecentlyAdded.m3u

if [ $? -eq 0 ]
then

    echo "successfully parsed"
    sort -u -o ~/MPDPlaylist/RecentlyAdded.m3u ~/MPDPlaylist/RecentlyAdded.m3u
    echo "duplicates removed"
    echo "successfully added to ~/MPDPlaylist/RecentlyAdded.m3u"

else
    echo "problem parsing mpd.log"
fi
