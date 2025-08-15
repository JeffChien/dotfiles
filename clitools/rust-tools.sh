#!/usr/bin/env bash

cargo install sd
cargo install choose
cargo install huniq
cargo install rargs
[[ $(uname) == "Darwin" ]] && cargo install coreutils --features macos
