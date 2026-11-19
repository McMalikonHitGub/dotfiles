#!/bin/sh
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
qs ipc call audio update
