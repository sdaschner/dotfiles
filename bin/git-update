#!/bin/zsh
set -eu

message=${1:-updated}
branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

pushd $(git rev-parse --show-toplevel || echo ".")
    git add --all .
    git commit -m "${message}" || true
    git pull --rebase origin ${branch} || true
    git push origin ${branch}
popd
