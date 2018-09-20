FROM node:9.6.1

WORKDIR /app

COPY app/package.json .

RUN npm install

COPY app .

CMD ["yarn", "run", "start"]
