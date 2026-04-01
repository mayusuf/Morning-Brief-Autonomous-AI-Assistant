#!/bin/bash

# Fetch recent Gmail messages using gog
# gog gmail search \
#   newer_than:1d in:inbox \
#   --limit 20 \
#   --format json

#   #!/bin/bash

# Fetch recent Gmail messages using gog (no --query flag)
gog gmail search "newer_than:1d in:inbox" \
  --limit 20 \
  --json