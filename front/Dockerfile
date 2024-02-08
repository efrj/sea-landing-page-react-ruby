FROM node:14-alpine

COPY ./ /app

WORKDIR /app

COPY package*.json ./app

RUN npm install

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]