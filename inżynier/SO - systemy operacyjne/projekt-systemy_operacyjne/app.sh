#!/bin/bash

gcc "src/main.c" -o "apps/main.exe" &&
gcc "src/process1.c" -o "apps/process1.exe" &&
gcc "src/process2.c" -o "apps/process2.exe" &&
gcc "src/process3.c" -o "apps/process3.exe" &&
gcc "src/checker.c" -o "apps/checker.exe" &&

./apps/main.exe
