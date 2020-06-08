#! /bin/sh
echo "## Pulling from remote" && \
git pull && \
echo "## Syncing submodules " &&  \
git submodule sync && \
echo "## Updating/Initing and merging submodules from their remote" &&  \
git submodule update --init --remote --merge && \
echo "## Committing update " &&  \
git commit --no-gpg-sign plugins -m "Sync submodules." && \
echo "## Pushing " &&  \
git push
