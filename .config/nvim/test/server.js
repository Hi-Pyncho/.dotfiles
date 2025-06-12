import { createServer } from 'node:http';

const wait = (ms) => {
  return new Promise((res) => setTimeout(res, ms));
};

const server = createServer(async (req, res) => {
  await wait(2000);
  res.end('df');
});

server.listen(3000);
