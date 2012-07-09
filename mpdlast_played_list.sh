#!/bin/bash

#Created a MPD playlist of last played tracks.

while [ 1 ]
do
    mpc idle > /dev/null
    track=$(mpc current | awk -F " - " '{print $2}')
    if [ "$track" != "" ]
    then
        path_to_track=$(mpc search title "$track")

        if [ -f ~/MPDPlaylist/LastPlayed.m3u ]
        then
            echo "$path_to_track" >> ~/MPDPlaylist/LastPlayed.m3u
            sort -u -o ~/MPDPlaylist/LastPlayed.m3u ~/MPDPlaylist/LastPlayed.m3u
        else
            mkdir ~/MPDPlaylist && touch ~/MPDPlaylist/LastPlayed.m3u
            echo "$path_to_track" >> ~/MPDPlaylist/LastPlayed.m3u
            sort -u -o ~/MPDPlaylist/LastPlayed.m3u ~/MPDPlaylist/LastPlayed.m3u
        fi
    fi
done
