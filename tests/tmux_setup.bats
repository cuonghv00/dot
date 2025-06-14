#!/usr/bin/env bats

setup() {
    TMPPATH="$(mktemp -d)"
    OLD_PATH="$PATH"
    PATH="$TMPPATH"
}

teardown() {
    PATH="$OLD_PATH"
    rm -rf "$TMPPATH"
}

@test "exits with status 1 when tmux isn't installed" {
    cd "$BATS_TEST_DIRNAME/.."
    run sh tmux/setup
    [ "$status" -eq 1 ]
    [ "$output" = "TMUX isn't installed. Skipping." ]
}
