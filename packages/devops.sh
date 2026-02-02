#!/bin/sh
# AI Invoke Scripts - DevOps
# SPDX-License-Identifier: MIT (https://ncurl.xyz/s/Kkn2DQsNR)

# Generate a safe Linux shell command based on a natural language query.
ASK_CMD() {
    local QUERY="$1"
    AIINVOKE "Provide a single, safe Linux shell command to achieve the following: '$QUERY'. Wrap the command in a code block. Do not explain unless necessary."
}

# Generate a standard Cron expression based on a natural language schedule description.
AI_OPS_CRON() {
    local SCHEDULE="$1"
    local PROMPT="Convert the following schedule description into a standard Cron expression. Output ONLY the expression (e.g., '30 8 * * 1') without explanation. Schedule: <schedule>$SCHEDULE</schedule>"
    AI_INVOKE "$PROMPT"
}

# Generate Nginx configuration snippets or location blocks based on requirements.
AI_OPS_NGINX() {
    local REQUIREMENTS="$1"
    local PROMPT="Generate an Nginx configuration snippet based on the requirements. Do not include unrelated default settings. Output raw text. Requirements: <requirements>$REQUIREMENTS</requirements>"
    AI_INVOKE "$PROMPT"
}

# Generate a Regular Expression (PCRE) based on a specific validation or matching requirement.
AI_OPS_REGEX() {
    local REQUIREMENT="$1"
    local PROMPT="Generate a PCRE compatible Regular Expression for the requirement. Explain the pattern logic briefly in $OPENAI_LOCALE. Requirement: <requirement>$REQUIREMENT</requirement>"
    AI_INVOKE "$PROMPT"
}

# Generate a Dockerfile or Docker Compose snippet for a specific tech stack.
AI_OPS_DOCKER() {
    local DESCRIPTION="$1"
    local PROMPT="Generate a Dockerfile or Docker Compose snippet for the described stack. Follow best practices (e.g., multi-stage builds). Output raw text. Description: <description>$DESCRIPTION</description>"
    AI_INVOKE "$PROMPT"
}

# Analyze error logs from a file or stdin to identify root causes and suggest fixes.
AI_OPS_LOGANA() {
    local LOG_CONTENT=""
    if [ -f "$1" ]; then
        LOG_CONTENT="$(cat "$1" | head -c 4000)"
    else
        LOG_CONTENT="$(cat /dev/stdin | head -c 4000)"
    fi
    local PROMPT="Analyze the following error logs. Identify the root cause and suggest a fix. Answer in $OPENAI_LOCALE. Logs: <logs>$LOG_CONTENT</logs>"
    AI_INVOKE "$PROMPT"
}

# Convert unstructured text data into JSON format.
AI_OPS_TOJSON() {
    local DATA="$(cat /dev/stdin | head -c 3000)"
    local PROMPT="Convert the following unstructured text into valid JSON format. Infer keys intelligently. Output ONLY the JSON. Text: <text>$DATA</text>"
    AI_INVOKE "$PROMPT"
}
