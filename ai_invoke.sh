#!/bin/sh
# AI Invoke Scripts
# SPDX-License-Identifier: MIT (https://ncurl.xyz/s/Kkn2DQsNR)

# Call the AI model with the given prompt and return the response
AI_INVOKE() {
    # Read content from argument or stdin
    local CONTENT="${1:-$(cat /dev/stdin)}"

    # Set parameters for the AI model
    local OPENAI_TEMPERATURE="${OPENAI_TEMPERATURE:-0.7}"
    local JSON_PAYLOAD="$(jq -n --arg model "$OPENAI_MODEL" --argjson temperature "$OPENAI_TEMPERATURE" --arg content "$CONTENT" \
        '{model: $model, messages: [{role: "user", content: $content }], temperature: $temperature}'
    )"

    # Make the API call to OpenAI and extract the response
    curl -sSfL \
        -X POST "$OPENAI_BASE_URL/chat/completions" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -H "Content-Type: application/json" \
        -d "$JSON_PAYLOAD" | jq -r '.choices[0].message.content // "(No Content)"'
}
