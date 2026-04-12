FROM node:22-slim
WORKDIR /app
RUN npm init -y && npx create-webiny-project@latest . --no-interactive || true
EXPOSE 3000
CMD ["npm", "run", "dev"]
