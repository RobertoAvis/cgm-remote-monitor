FROM node:10 AS build

MAINTAINER Nightscout Contributors

RUN mkdir -p /app
ADD . /app
WORKDIR /app

RUN npm install && \
  npm run postinstall && \
  npm run env && \
  npm audit fix


FROM node:10-alpine AS release

COPY --from=build /app /app
RUN chown -R node:node /app
USER node
WORKDIR /app

EXPOSE 1337

CMD ["node", "server.js"]
