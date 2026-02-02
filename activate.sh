#!/bin/sh
# AI Invoke Scripts - Activate
# SPDX-License-Identifier: MIT (https://ncurl.xyz/s/Kkn2DQsNR

# The script to activate the AI Invoke environment
# sets up necessary environment variables and sources required scripts

# Determine the base path of the script
BASE_PATH="$(dirname "$0")"

# Source the core AI invoke script
. "$BASE_PATH/ai_invoke.sh"

# Source additional packages as needed
. "$BASE_PATH/packages/git.sh"
. "$BASE_PATH/packages/ops.sh"
. "$BASE_PATH/packages/prog.sh"
