FROM node:20

WORKDIR /app
COPY package*.json ./
COPY ../package.json ./ # untuk workspaces
RUN npm install --legacy-peer-deps

WORKDIR /app/api
COPY . .

ENV NODE_ENV=production
CMD ["npm", "run", "server"]
