#!/usr/bin/env bash

# carell2db.sh - given a directory, build (reduce) a database

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# June 28, 2018 - first cut

# configure
REDUCE='./bin/reduce.pl'
INITIALIZEDB='./bin/initialize-database.sh'

# sanity check
if [[ -z "$1" ]]; then
	echo "Usage: $0 <directory>" >&2
	exit
fi

# get input
DIRECTORY=$1

# echo and do the work
echo "$DIRECTORY" >&2
$INITIALIZEDB $DIRECTORY
find $DIRECTORY -name '*.pos' | parallel $REDUCE $DIRECTORY pos {} \;
find $DIRECTORY -name '*.ent' | parallel $REDUCE $DIRECTORY ent {} \;
find $DIRECTORY -name '*.wrd' | parallel $REDUCE $DIRECTORY wrd {} \;
find $DIRECTORY -name '*.adr' | parallel $REDUCE $DIRECTORY adr {} \;
find $DIRECTORY -name '*.url' | parallel $REDUCE $DIRECTORY url {} \;
find $DIRECTORY -name '*.bib' | parallel $REDUCE $DIRECTORY bib {} \;