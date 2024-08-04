FROM node:20.11.1
WORKDIR /app
COPY ./letalkTest-back/package*.json ./
RUN yarn
COPY ./letalkTest-back .
EXPOSE 3000
CMD ["sh", "-c", "yarn && yarn start:dev"]