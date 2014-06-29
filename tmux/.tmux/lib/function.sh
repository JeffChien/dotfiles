#!/usr/bin/env bash
exist() {
    hash "$1" 2>/dev/null && return 1 || return 0
}
