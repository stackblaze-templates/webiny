FROM node:22-slim
WORKDIR /app
RUN (npm init -y && npx create-webiny-project@latest . --no-interactive || true) && \
    chown -R node:node /app
USER node
ENV NODE_ENV=production
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/', (r) => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"
CMD ["npm", "start"]
