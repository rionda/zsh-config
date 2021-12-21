#! /bin/sh
(echo "## Pulling from remote" &&  git pull --no-rebase) || exit 1
(echo "## Syncing submodules " && git submodule sync) || exit 1
(echo "## Updating/Initing and merging submodules from their remote" &&  \
    git submodule update --init --remote --merge) || exit 1
(echo "## Committing update " &&  \
    git commit --no-gpg-sign plugins -m "Sync submodules.") || \
    exit 1
(echo "## Pushing " && git push) || exit 1
