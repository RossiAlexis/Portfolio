FROM node:20-alpine AS runtime
RUN npm install -g pnpm@latest
COPY package.json pnpm-lock.yaml ./

WORKDIR /app
COPY . .

# Remove existing node_modules and package-lock.json
RUN rm -rf node_modules
RUN rm -f package-lock.json

RUN pnpm install
RUN pnpm build

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD ["node", "./dist/server/entry.mjs"]
