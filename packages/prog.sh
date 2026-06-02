#!/bin/sh
# AI Invoke Scripts - Programming Utilities
# SPDX-License-Identifier: MIT (https://ncurl.xyz/s/Kkn2DQsNR)

# Explain the purpose and logic of a code snippet (supports file path or stdin).
AI_PROG_EXPLAIN() {
    local CONTENT=""
    if [ -f "$1" ]; then
        CONTENT="$(cat "$1")"
    else
        CONTENT="$(cat /dev/stdin)"
    fi
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-4000}"
    local TRUNCATED_CONTENT="${CONTENT:0:$TRUNCATE_LENGTH}"
    local PROMPT="Explain the following code snippet concisely. Describe its purpose and key logic. Answer in $OPENAI_LOCALE. Code: <code_snippet>$TRUNCATED_CONTENT</code_snippet>"
    AI_INVOKE "$PROMPT"
}

# Suggest refactoring improvements for code readability, performance, and maintainability.
AI_PROG_REFACTOR() {
    local CONTENT=""
    if [ -f "$1" ]; then
        CONTENT="$(cat "$1")"
    else
        CONTENT="$(cat /dev/stdin)"
    fi
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-4000}"
    local TRUNCATED_CONTENT="${CONTENT:0:$TRUNCATE_LENGTH}"
    local PROMPT="Refactor the following code to improve readability, performance, and maintainability. Explain the changes in $OPENAI_LOCALE. Code: <code_snippet>$TRUNCATED_CONTENT</code_snippet>"
    AI_INVOKE "$PROMPT"
}

# Generate unit tests for the provided code using a specific framework (e.g., Jest, Pytest).
AI_PROG_TEST() {
    local FRAMEWORK="${1:-generic}"
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-4000}"
    local CONTENT="$(cat /dev/stdin | head -c $TRUNCATE_LENGTH)"
    local PROMPT="Write unit tests for the following code using $FRAMEWORK. Provide high code coverage. Code: <code_snippet>$CONTENT</code_snippet>"
    AI_INVOKE "$PROMPT"
}

# Suggest variable or function names based on logic or description.
AI_PROG_NAMING() {
    local CONTEXT="$1"
    local PROMPT="Suggest 5 variable/function names for the following context/logic. Follow standard naming conventions (camelCase, snake_case etc appropriate for the context). Context: <context>$CONTEXT</context>"
    AI_INVOKE "$PROMPT"
}

# Analyze error logs to identify the root cause and suggest a fix.
AI_PROG_DEBUG() {
    local LOGS=""
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-4000}"
    if [ -f "$1" ]; then
        LOGS="$(cat "$1" | head -c $TRUNCATE_LENGTH)"
    else
        LOGS="$(cat /dev/stdin | head -c $TRUNCATE_LENGTH)"
    fi
    local PROMPT="Analyze the following error logs. Identify the root cause and suggest a fix. Answer in $OPENAI_LOCALE. Logs: <logs>$LOGS</logs>"
    AI_INVOKE "$PROMPT"
}

# Generate a single, safe shell command based on a natural language request.
AI_PROG_CMD() {
    local QUERY="$1"
    local PROMPT="Provide a single, safe Linux shell command to achieve the following: '$QUERY'. Wrap the command in a code block. Do not explain unless necessary. Requirement: <requirement>$QUERY</requirement>"
    AI_INVOKE "$PROMPT"
}

# Review code specifically for security vulnerabilities (e.g., injection, secrets).
AI_PROG_SEC() {
    local CONTENT=""
    if [ -f "$1" ]; then
        CONTENT="$(cat "$1")"
    else
        CONTENT="$(cat /dev/stdin)"
    fi
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-4000}"
    local TRUNCATED_CONTENT="${CONTENT:0:$TRUNCATE_LENGTH}"
    local PROMPT="Review this code snippet specifically for security vulnerabilities (e.g., hardcoded API keys, injection, XSS). Answer in $OPENAI_LOCALE. Code: <code_snippet>$TRUNCATED_CONTENT</code_snippet>"
    AI_INVOKE "$PROMPT"
}
