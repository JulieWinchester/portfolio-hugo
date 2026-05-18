#!/usr/bin/env bash
# deploy.sh — Pull the latest built portfolio artifact from GitHub Actions and deploy it.
#
# SETUP (one-time):
#   1. Create a GitHub fine-grained PAT at https://github.com/settings/personal-access-tokens/new
#      - Repository access: JulieWinchester/portfolio-hugo
#      - Permissions: "Actions" → Read-only (to download artifacts and trigger workflows)
#   2. Set the token in your environment (add to ~/.bashrc or ~/.profile on the VM):
#        export GITHUB_TOKEN="github_pat_xxxx..."
#   3. Make this script executable: chmod +x deploy.sh
#   4. Run it from anywhere: ~/portfolio/deploy.sh
#
# USAGE:
#   Deploy latest already-built artifact:
#     ./deploy.sh
#
#   Trigger a fresh build first, then deploy:
#     ./deploy.sh --build

set -euo pipefail

REPO="JulieWinchester/portfolio-hugo"
WORKFLOW_FILE="publish.yaml"
ARTIFACT_NAME="portfolio-site"
DEPLOY_DIR="/home/julie/portfolio/html"
BRANCH="main"

API="https://api.github.com/repos/${REPO}"
AUTH_HEADER="Authorization: Bearer ${GITHUB_TOKEN:?Please set the GITHUB_TOKEN environment variable}"

# ── Optional: trigger a new build ────────────────────────────────────────────
if [[ "${1:-}" == "--build" ]]; then
  echo "→ Triggering new build..."
  curl -sS -X POST "${API}/actions/workflows/${WORKFLOW_FILE}/dispatches" \
    -H "${AUTH_HEADER}" \
    -H "Accept: application/vnd.github+json" \
    -d "{\"ref\":\"${BRANCH}\"}"

  echo "→ Waiting for build to start..."
  sleep 8

  echo "→ Waiting for build to complete..."
  for i in $(seq 1 30); do
    STATUS=$(curl -sS "${API}/actions/runs?branch=${BRANCH}&event=workflow_dispatch&per_page=1" \
      -H "${AUTH_HEADER}" \
      -H "Accept: application/vnd.github+json" \
      | jq -r '.workflow_runs[0].status')
    CONCLUSION=$(curl -sS "${API}/actions/runs?branch=${BRANCH}&event=workflow_dispatch&per_page=1" \
      -H "${AUTH_HEADER}" \
      -H "Accept: application/vnd.github+json" \
      | jq -r '.workflow_runs[0].conclusion')
    echo "   status: ${STATUS} / conclusion: ${CONCLUSION}"
    if [[ "${STATUS}" == "completed" ]]; then
      if [[ "${CONCLUSION}" != "success" ]]; then
        echo "✗ Build failed (conclusion: ${CONCLUSION}). Check GitHub Actions for details."
        exit 1
      fi
      break
    fi
    sleep 10
  done
fi

# ── Find the latest successful artifact ──────────────────────────────────────
echo "→ Finding latest '${ARTIFACT_NAME}' artifact..."
ARTIFACT=$(curl -sS "${API}/actions/artifacts?name=${ARTIFACT_NAME}&per_page=1" \
  -H "${AUTH_HEADER}" \
  -H "Accept: application/vnd.github+json" \
  | jq -r '.artifacts[0]')

ARTIFACT_ID=$(echo "${ARTIFACT}" | jq -r '.id')
CREATED_AT=$(echo "${ARTIFACT}" | jq -r '.created_at')

if [[ -z "${ARTIFACT_ID}" || "${ARTIFACT_ID}" == "null" ]]; then
  echo "✗ No artifact found. Push to main or run './deploy.sh --build' to create one."
  exit 1
fi

echo "   artifact id: ${ARTIFACT_ID} (built at ${CREATED_AT})"

# ── Download and extract ──────────────────────────────────────────────────────
TMP_DIR=$(mktemp -d)
trap "rm -rf ${TMP_DIR}" EXIT

echo "→ Downloading artifact..."
curl -sS -L "${API}/actions/artifacts/${ARTIFACT_ID}/zip" \
  -H "${AUTH_HEADER}" \
  -H "Accept: application/vnd.github+json" \
  -o "${TMP_DIR}/site.zip"

echo "→ Extracting..."
unzip -q "${TMP_DIR}/site.zip" -d "${TMP_DIR}/site"

echo "→ Deploying to ${DEPLOY_DIR}..."
# Clear existing files and replace with new build
rm -rf "${DEPLOY_DIR:?}"/*
cp -r "${TMP_DIR}/site/." "${DEPLOY_DIR}/"

echo "✓ Done. Site deployed from artifact built at ${CREATED_AT}."
