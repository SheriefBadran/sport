const Hapi = require('hapi');

export function createServer({port, host} = {port: 3000, host: 'localhost'}) {
  const server = new Hapi.Server({port, host})

  return server
}

export function startServer() {
  const server = createServer({port: 7001, host: '0.0.0.0'})
  server.start(console.log(`Server running at: ${server.info.uri}`))
}

startServer()
