# ─────────────────────────────────────────────────────────────────────────────
#  CEO-Chief HQ — Dockerfile
#  Builds a minimal Node.js container for cloud deployment.
#  Compatible with: Railway, Render, Fly.io, DigitalOcean, any Docker host.
# ─────────────────────────────────────────────────────────────────────────────

FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy package files first (layer caching — only re-installs if deps change)
COPY package.json ./

# Install production dependencies only
RUN npm install --omit=dev

# Copy the bridge and supporting files
COPY cloud-bridge.js ./
COPY agents/ ./agents/
COPY shared-brain/ ./shared-brain/

# Cloud platforms (Railway, Render) inject PORT automatically.
# Health-check server inside cloud-bridge.js listens on this port.
ENV PORT=3000

# Expose health-check port
EXPOSE 3000

# Required env vars (set these in your cloud platform dashboard):
#   TELEGRAM_BOT_TOKEN
#   NVIDIA_API_KEY
#   ALLOWED_CHAT_IDS   (optional)
#   MODEL              (optional, default: nvidia/llama-3.1-nemotron-70b-instruct)

# Run as non-root for security
RUN addgroup --system botuser && adduser --system --ingroup botuser botuser
RUN chown -R botuser:botuser /app
USER botuser

# Health check — cloud platforms use this to verify the container is alive
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD node -e "require('http').get('http://localhost:' + (process.env.PORT||3000), r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"

CMD ["node", "cloud-bridge.js"]
