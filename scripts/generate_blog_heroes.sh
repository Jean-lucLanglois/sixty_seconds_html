#!/usr/bin/env bash
# Generate 13 blog hero images via the banana fallback script.
# Run AFTER enabling billing on Google AI Studio for the configured API key.
#
# Usage: ./scripts/generate_blog_heroes.sh
#   Output: img/blog-heroes/<slug>.png  (1200x630-ish, 2K resolution)

set -euo pipefail
cd "$(dirname "$0")/.."

# Load API key from settings.json
export GOOGLE_AI_API_KEY=$(python3 -c "
import json
with open('$HOME/.claude/settings.json') as f:
    s = json.load(f)
print(s['mcpServers']['nanobanana-mcp']['env']['GOOGLE_AI_API_KEY'])
")

GEN=$HOME/.claude/plugins/cache/agricidaniel-seo/claude-seo/1.9.8/extensions/banana/scripts/generate.py
OUT_DIR="img/blog-heroes"
mkdir -p "$OUT_DIR"

# Style baseline shared by all prompts: brand-aligned, cinematic, editorial.
BRAND="Cinematic editorial illustration in a dark navy and gold color palette. Background base color #0B0F12 deep navy. Accent color #D3BC5F warm gold. Modern, premium, restrained composition. No text or numbers anywhere in the image. No logos. No readable signage. No human faces. 16:9 widescreen composition with strong negative space."

generate() {
  local slug="$1"; shift
  local scene="$1"; shift
  local out="$OUT_DIR/$slug.png"
  if [ -f "$out" ]; then
    echo "  [skip] $out exists"
    return 0
  fi
  echo "==> $slug"
  # Move existing latest file out of the way so we can capture this generation.
  rm -f "$HOME/Documents/nanobanana_generated/"*.png 2>/dev/null || true
  python3 "$GEN" \
    --model gemini-2.5-flash-image \
    --prompt "$BRAND  Scene: $scene" \
    --aspect-ratio 16:9 \
    --resolution 2K \
    --image-only > /dev/null
  # Move the freshly generated image to our destination
  local latest=$(ls -t "$HOME/Documents/nanobanana_generated/"*.png 2>/dev/null | head -1)
  if [ -n "$latest" ] && [ -f "$latest" ]; then
    mv "$latest" "$out"
    echo "    saved: $out ($(ls -lh "$out" | awk '{print $5}'))"
  else
    echo "    [FAIL] no output produced for $slug"
  fi
  sleep 2  # gentle rate-limit cushion
}

generate "391-higher-conversion-rates" \
  "A glowing analog stopwatch suspended in mid-air on the left third of the frame, its second hand sweeping past the 1-second mark with a subtle motion blur trail. Behind it, an out-of-focus night cityscape of warm office windows. Deep navy atmosphere with warm gold light spilling from the stopwatch face."

generate "ai-in-sales-process" \
  "Two interlocking translucent gears — one geometric and circuit-patterned representing AI, the other classic mechanical brass representing human craft — meshed together in the center of the frame, glowing where they meet. Dark navy void background with soft gold rim lighting on the gears."

generate "ai-sales-agent-vs-human-sdr-cost" \
  "Split-frame composition: left half shows a sleek metallic abstract AI-pattern (circuits, glowing nodes), right half shows a worn brass desk lamp casting warm light on a paper notebook. A thin vertical gold divider line runs between them. Dark navy background."

generate "chatbots-vs-sdr-vs-ai" \
  "Three suspended geometric shapes hovering against a dark navy field — a simple chat-bubble outline on the left, a stylized human silhouette in the center, and a complex glowing neural-network sphere on the right. The neural-network shape is largest and most luminous in warm gold. Cinematic depth and atmosphere."

generate "commission-only-sales" \
  "A close-up of a classic mechanical balance scale with two empty brass pans, one slightly higher than the other, against a moody dark navy backdrop. Warm gold light catches the edges of the scale's chain and beam. Editorial, restrained, slightly off-center composition."

generate "cost-of-slow-response" \
  "Time-lapse style: a stack of golden coins slowly tipping and falling off the right edge of a dark surface, each coin frozen at a different stage of its fall, creating a cascade. Dark navy void background. Warm gold tones, dramatic side lighting."

generate "lead-response-benchmarks" \
  "An abstract bar chart rendered as glowing translucent vertical pillars of varying heights against a dark navy void. The tallest pillar on the left glows the brightest warm gold, the others fade progressively dimmer toward the right. Soft volumetric haze."

generate "outsourced-sales-team-cost" \
  "An open vintage briefcase resting on its side, with abstract golden particles streaming out of it and dispersing into the dark navy air around it. Selective focus on the briefcase. Premium, cinematic mood."

generate "personal-injury-lead-intake-automation" \
  "A single antique brass telephone handset resting on its side on a dark polished surface, its coiled cord trailing off into shadow. A subtle warm gold halo of light surrounds it. Quiet, urgent, editorial composition."

generate "roofing-lead-response-service-cost" \
  "Architectural silhouette of a residential rooftop seen from below at sunset, dramatic foreshortened angle. Dark navy sky with warm gold light catching the leading edge of the roofline and chimney. Restrained, cinematic, premium home services aesthetic."

generate "sales-outsourcing-vs-hiring" \
  "Two stylized doorways stand parallel in a dark navy void — one inward-opening with warm gold light spilling out, one closed with cool moonlight along its edge. Composition emphasizes choice and consequence. Editorial illustration style."

generate "slow-lead-response-cost" \
  "Hourglass on the left third of the frame with most of its sand piled in the bottom chamber. The remaining sand falls in slow particles, each catching warm gold light. The bottom chamber overflows slightly, sand spilling onto the dark surface. Dark navy atmospheric background."

generate "why-leads-arent-converting" \
  "A constellation of disconnected glowing dots scattered across a dark navy field, with faint dotted lines attempting to connect them but stopping short — most connections incomplete. A few of the dots glow warm gold; most are dim. Abstract, editorial."

echo ""
echo "Done. Generated images in $OUT_DIR/"
ls -lh "$OUT_DIR"
