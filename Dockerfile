# ----------- Stage 1: Builder for dependencies -----------
FROM node:20 AS deps-builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

# ----------- Stage 2: Production image -----------
FROM node:20-alpine

WORKDIR /app

COPY --from=deps-builder /app/node_modules ./node_modules

COPY . .

USER node

CMD ["node", "index.js"]