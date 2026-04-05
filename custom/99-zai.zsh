# Common setup function for Z.AI configuration
_zai_setup() {
  local caller="$1"
  local config="$HOME/.zai.json"

  if ! command -v jq >/dev/null 2>&1; then
    echo "$caller: jq is required (brew install jq | apt-get install jq)" >&2
    return 1
  fi

  if [ ! -f "$config" ]; then
    echo "$caller: missing $config" >&2
    return 1
  fi

  local api_url api_key yolo haiku_model sonnet_model opus_model
  IFS=$'\t' read -r api_url api_key yolo haiku_model sonnet_model opus_model < <(
    jq -r '[.apiUrl // "", .apiKey // "", .yolo // false, .haikuModel // "", .sonnetModel // "", .opusModel // ""] | @tsv' "$config"
  )

  if [ -z "$api_url" ] || [ -z "$api_key" ]; then
    echo "$caller: apiUrl/apiKey missing in $config" >&2
    return 1
  fi

  [ -z "$haiku_model" ] && haiku_model="glm-4.5-air"
  [ -z "$sonnet_model" ] && sonnet_model="glm-4.7"
  [ -z "$opus_model" ] && opus_model="glm-4.7"

  local key_hint="${api_key:0:4}...${api_key: -4}"
  echo "$caller: endpoint=$api_url | haiku=$haiku_model | sonnet=$sonnet_model | opus=$opus_model | key=$key_hint"

  # Export for caller to use
  export _ZAI_API_URL="$api_url"
  export _ZAI_API_KEY="$api_key"
  export _ZAI_YOLO="$yolo"
  export _ZAI_HAIKU_MODEL="$haiku_model"
  export _ZAI_SONNET_MODEL="$sonnet_model"
  export _ZAI_OPUS_MODEL="$opus_model"

  return 0
}


zz() {
  _zai_setup "zz" || return 1

  ANTHROPIC_BASE_URL="$_ZAI_API_URL" \
  ANTHROPIC_AUTH_TOKEN="$_ZAI_API_KEY" \
  ANTHROPIC_DEFAULT_HAIKU_MODEL="$_ZAI_HAIKU_MODEL" \
  ANTHROPIC_DEFAULT_SONNET_MODEL="$_ZAI_SONNET_MODEL" \
  ANTHROPIC_DEFAULT_OPUS_MODEL="$_ZAI_OPUS_MODEL" \
  PS1="Z.AI %~ %# " \
  zsh
}

zaoe() {
  _zai_setup "zaoe" || return 1

  if ! command -v aoe >/dev/null 2>&1; then
    echo "zaoe: aoe not found. Please install aoe first." >&2
    return 1
  fi

  ANTHROPIC_BASE_URL="$_ZAI_API_URL" \
  ANTHROPIC_AUTH_TOKEN="$_ZAI_API_KEY" \
  ANTHROPIC_DEFAULT_HAIKU_MODEL="$_ZAI_HAIKU_MODEL" \
  ANTHROPIC_DEFAULT_SONNET_MODEL="$_ZAI_SONNET_MODEL" \
  ANTHROPIC_DEFAULT_OPUS_MODEL="$_ZAI_OPUS_MODEL" \
  aoe 
}
