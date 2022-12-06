import http from "http";
import app from "./app";

const server = http.createServer(app);
const port = 3000;

server.on("listening", () => {
  const address = server.address();
  const bind = typeof address === "string" ? `pipe ${address}` : `port ${port}`;
  console.log(`Listening on ${bind}`);
});

server.listen(port);
