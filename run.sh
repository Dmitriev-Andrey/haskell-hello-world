#!/bin/bash

sqlite3 store.db < init.sql
stack setup
stack install
~/.local/bin/book-store-haskell-exe