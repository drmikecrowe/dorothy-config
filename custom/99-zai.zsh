zc() {
  local config="$HOME/.zai.json"

  if ! command -v jq >/dev/null 2>&1; then
    echo "zc: jq is required (brew install jq | apt-get install jq)" >&2
    return 1
  fi

  if ! command -v claude >/dev/null 2>&1; then
    echo "zc: Claude Code not found. Install: npm install -g @anthropic-ai/claude-code" >&2
    return 1
  fi

  if [ ! -f "$config" ]; then
    echo "zc: missing $config" >&2
    return 1
  fi

  local api_url api_key yolo haiku_model sonnet_model opus_model
  IFS=$'\t' read -r api_url api_key yolo haiku_model sonnet_model opus_model < <(
    jq -r '[.apiUrl // "", .apiKey // "", .yolo // false, .haikuModel // "", .sonnetModel // "", .opusModel // ""] | @tsv' "$config"
  )

  if [ -z "$api_url" ] || [ -z "$api_key" ]; then
    echo "zc: apiUrl/apiKey missing in $config" >&2
    return 1
  fi

  [ -z "$haiku_model" ] && haiku_model="glm-4.5-air"
  [ -z "$sonnet_model" ] && sonnet_model="glm-4.7"
  [ -z "$opus_model" ] && opus_model="glm-4.7"

  local yolo_flag=""
  if [ "$yolo" = "true" ]; then
    yolo_flag="--dangerously-skip-permissions"
  fi

  local key_hint="${api_key:0:4}...${api_key: -4}"
  echo "zc: endpoint=$api_url | haiku=$haiku_model | sonnet=$sonnet_model | opus=$opus_model | key=$key_hint"

  add_dir=""
  if [[ -d wiki ]]; then
    add_dir="--add-dir wiki"
  fi

  ANTHROPIC_BASE_URL="$api_url" \
  ANTHROPIC_AUTH_TOKEN="$api_key" \
  ANTHROPIC_DEFAULT_HAIKU_MODEL="$haiku_model" \
  ANTHROPIC_DEFAULT_SONNET_MODEL="$sonnet_model" \
  ANTHROPIC_DEFAULT_OPUS_MODEL="$opus_model" \
  claude $yolo_flag $dir_add "$@"
}
