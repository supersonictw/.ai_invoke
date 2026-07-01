#!/bin/sh
# AI Invoke Scripts - Git Utilities
# SPDX-License-Identifier: MIT (https://ncurl.xyz/s/Kkn2DQsNR)

# Automatically generate a standardized Commitizen-style commit message based on staged changes.
AI_GIT_CZMSG() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-5000}"
    local DIFF_RESULT="$(git diff --staged | head -c $TRUNCATE_LENGTH)"
    local PROMPT="Generate a Commitizen style commit message (e.g., feat: ..., fix: ...) of no more than 20 words based on the changes. Output ONLY the message in $OPENAI_LOCALE. Changes: <diff>$DIFF_RESULT</diff>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}

# Perform a quick AI code review on staged files before committing, focusing on bugs and security risks.
AI_GIT_REVIEW() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-5000}"
    local DIFF_RESULT="$(git diff --staged | head -c $TRUNCATE_LENGTH)"
    local PROMPT="Act as a senior engineer. Perform a concise code review on the following git diff. Identify potential bugs, security risks, or logic flaws, and provide improvement suggestions. Answer in $OPENAI_LOCALE. Diff: <diff>$DIFF_RESULT</diff>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}

# Compile a draft release note in Markdown based on the last N commits (default 10).
AI_GIT_RELNOTE() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local COUNT="${1:-10}"
    local LOG_CONTENT="$(git log -n "$COUNT" --pretty=format:"%h - %s")"
    local PROMPT="Draft a release note in Markdown format based on the following git commit logs. Categorize the changes (e.g., Features, Fixes, Refactor) and use $OPENAI_LOCALE for the content: <log_content>$LOG_CONTENT</log_content>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}

# Suggest suitable git branch names (kebab-case) based on staged content or a provided description.
AI_GIT_BRNAME() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local INPUT_DATA=""
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-5000}"
    if [ -n "$1" ]; then
        INPUT_DATA="Task description: $1"
    else
        INPUT_DATA="Code changes: $(git diff --staged | head -c $TRUNCATE_LENGTH)"
    fi
    local PROMPT="Suggest 3 valid kebab-case git branch names (e.g., feat/user-login, fix/api-timeout) based on the context. Output only the names, one per line. Context: <context>$INPUT_DATA</context>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}

# Explain the logic and purpose of the staged changes (useful when you forget what you wrote).
AI_GIT_EXPLAIN() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local TRUNCATE_LENGTH="${TRUNCATE_LENGTH:-5000}"
    local DIFF_RESULT="$(git diff --staged | head -c $TRUNCATE_LENGTH)"
    local PROMPT="Explain the logic and purpose of the following staged changes as if explaining to a colleague. Answer in $OPENAI_LOCALE. Changes: <diff>$DIFF_RESULT</diff>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}

# Quickly generate standard .gitignore content based on provided keywords.
AI_GIT_IGNORE() {
    local PREFIX_PROMPT="${PREFIX_PROMPT:-}"
    local KEYWORDS="$1"
    local PROMPT="Generate a standard .gitignore file content for the technologies listed below. Output raw text only, no markdown code blocks. Technologies: <keywords>$KEYWORDS</keywords>"
    AI_INVOKE "${PREFIX_PROMPT}${PROMPT}"
}
