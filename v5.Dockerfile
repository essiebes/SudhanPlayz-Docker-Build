FROM node:16-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --ignore-scripts

WORKDIR /usr/src/app/dashboard
COPY dashboard/package*.json ./
RUN npm install --ignore-scripts

WORKDIR /usr/src/app
COPY . .

WORKDIR /usr/src/app/dashboard
RUN npm run build
WORKDIR /usr/src/app

EXPOSE 3000

CMD [ "npm", "run", "deploy" ]

CMD [ "node", "index.js" ]
