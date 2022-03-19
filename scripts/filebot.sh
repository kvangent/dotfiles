#!/bin/bash

DEBUG=
FMT=
FLAGS=
TAG=

while :; do
    case $1 in
        -m|--movie|--movies)
            FMT="$PWD/{n} ({y})/{n} ({y})"
            FLAGS="$FLAGS --db \"TheMovieDb\""
            ;;
        -t|--tv)
            FMT="$PWD/{n} ({y})/Season {s.pad(2)}/{n} ({y}) - {s00e00}"
            FLAGS="$FLAGS --db \"TheTVDB\" -non-strict"
            ;;

        -q=?*|--query=?*)
            FLAGS="$FLAGS --query ${1#*=}"
            ;;
        -t=?*|--tag=?*)
            TAG=${1#*=}
            ;;

        -dr|--dry-run)
            FLAGS="$FLAGS --action test"
            ;;
        -d|--debug)
            DEBUG=true
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)  # Default case: No more options, so break out of the loop.
            if [ -z "$1" ]; then
                printf 'ERROR: No target(s) specified'
                exit
            fi
            break
    esac

    shift
done

if [ -n "$TAGS" ] ; then
    FMT="$FMT [$TAGS]"
else
    FMT="$FMT [{vf},{vc}]"
fi

# -rename "$1" -r --format "$PWD/{n} ({y})/{n} ({y}) {tags}" --q "$2" --db "TheMovieDb"
CMD="filebot -rename -r \"$1\" --format \"$FMT\" $FLAGS"

if [ "$DEBUG" = true ] ; then
    echo $CMD
else
    eval $CMD
fi

