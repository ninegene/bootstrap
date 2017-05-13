#!/bin/sh
set -e

if [[ $# -le 2 ]]; then
    echo "Usage: $0 [GIT_COMMITTER_NAME|GIT_AUTHOR_NAME] \"old name\" \"new name\""
    echo "       $0 [GIT_COMMITTER_EMAIL|GIT_AUTHOR_EMAIL] \"old@email.com\" \"new@email.com\""
    echo "       $0 [GIT_COMMITTER_EMAIL|GIT_AUTHOR_EMAIL] \"old@email.com\" \"new@email.com\"" HEAD~2..HEAD
    exit 2
fi

GIT_VAR=$1
OLD=$2
NEW=$3
shift 3

set -x
git filter-branch --env-filter "
    if [ \"$`echo $GIT_VAR`\" = \"$OLD\" ]; then
        export $GIT_VAR=\"$NEW\"
    fi" $@
