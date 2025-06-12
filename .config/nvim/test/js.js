const wait = (ms) => {
  return new Promise((res) => setTimeout(res, ms));
};

async function main() {
  console.log(1);
  await wait(2000);
  console.log(2);
}

main();
