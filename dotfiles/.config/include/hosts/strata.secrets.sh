##
# Strata: Secrets
#
# NOTE: This file SHOULD NOT BE version-controlled.
# NOTE: If you use this repo, remove this file once you fork/clone.
##

# GitHub
export GITHUB_AUTH_TOKEN=<redacted>

# Gemfury
export FURY_AUTH_PULL=<redacted>
export FURY_AUTH_PUSH=<redacted>


fury_init() {
  export GEMFURY_API_TOKEN=${FURY_AUTH}
  export PIP_EXTRA_INDEX_URL=https://${FURY_AUTH}:@pypi.fury.io/strata/
}

fury_pull() {
  export FURY_AUTH=${FURY_AUTH_PULL}
  fury_init
}

fury_push() {
  export FURY_AUTH=${FURY_AUTH_PUSH}
  fury_init
}

fury_pull
