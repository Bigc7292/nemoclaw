#!/bin/bash
set -e

SANDBOXES=(
  "social-director" "adult-influencer-russian" "adult-influencer-asian" "adult-influencer-latina"
  "funny-content" "babies-niche" "animals-niche" "business-growth" "streamer-clipper"
  "coding-cto" "discount-hunter-specialist" "ai-lead-iq-specialist" "eva_eva-specialist" "stonesightainew-specialist"
  "market-research-lead" "trend-scout" "audience-analyzer"
  "competition-director" "rival-tracker" "gap-analyst"
  "ai-scout-daily" "model-evaluator" "innovation-reporter"
  "infra-engineer" "log-monitor" "upgrade-scout"
)

# Onboarding missing sandboxes
for sb in "${SANDBOXES[@]}"; do
  if ! openshell sandbox list | grep -q "$sb"; then
    echo "[NEW] Onboarding missing sandbox: $sb..."
    openshell sandbox create "$sb" || true
  fi
done
echo "DONE CREATING SANDBOXES"
