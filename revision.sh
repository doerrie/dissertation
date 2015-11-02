#!/bin/bash
GIT=`which git`
DATE=`which date`

function usage {
    echo "Usage:"
    echo "     $0 output.tex";
    echo "If 'git' or 'date' are not installed, empty commands will be produced."
    exit 1;
    }


if [ -z "$1" ]
then
    usage;
fi


function default_output {
    echo "\newcommand{\RevisionInfo}{} \newcommand{\gitStatus}{}" > "$1";
    exit 0;
}

if [ -z "$GIT" -o -z "$DATE" ]
then
    default_output "$1";
fi


$GIT diff --quiet --exit-code
case $? in
    0)
	$GIT log -1 --date=iso --format=format:'\newcommand{\gitRevision}{Revision %h} \newcommand{\gitStatus}{%ad}' > "$1";
    ;;
    1)
	TZ="UTC";
	NOW=`$DATE "+%Y-%m-%d %0H:%0M:%0S %z"`;
	echo "\newcommand{\gitRevision}{Working Directory} \newcommand{\gitStatus}{$NOW}" > "$1";
    ;;
    *)
	default_output "$1";
    ;;
esac
     
