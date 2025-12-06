#!/usr/bin/env bash
set -euo pipefail

# Simple starter script: if execution data doesn't exist, run init + first_start;
# otherwise run restart.
DIR=$(cd "$(dirname "$0")" && pwd)

echo "[start] Checking for initialization..."

if [ ! -d "$DIR/data/execution-data" ]; then
	echo "[start] data/execution-data not found — running initialization sequence"

	if [ -x "$DIR/init.sh" ]; then
		echo "[start] Running init.sh"
		"$DIR/init.sh"
	else
		echo "[start] ✗ init.sh not found or not executable: $DIR/init.sh"
		echo "[start] Please ensure initialization script exists and is executable"
		exit 1
	fi

	if [ -x "$DIR/first_start.sh" ]; then
		echo "[start] Running first_start.sh"
		"$DIR/first_start.sh"
	else
		echo "[start] ✗ first_start.sh not found or not executable: $DIR/first_start.sh"
		echo "[start] Please ensure first_start.sh exists and is executable"
		exit 1
	fi

	echo "[start] Initialization and first start finished"
	exit 0
fi

echo "[start] data/execution-data exists — running restart sequence"

if [ -x "$DIR/restart.sh" ]; then
	"$DIR/restart.sh"
else
	echo "[start] ✗ restart.sh not found or not executable: $DIR/restart.sh"
	echo "[start] Please ensure restart.sh exists and is executable"
	exit 1
fi
