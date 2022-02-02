#! /bin/sh

git submodule update --init --merge && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    ln -s "${PWD}/zshrc" ~/.zshrc
