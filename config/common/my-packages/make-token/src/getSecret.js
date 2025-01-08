import { chooseTarget, readSecret, saveToClipboard } from "./utils.js";

async function main() {
  const target = await chooseTarget();
  const secret = await readSecret({ target });

  await saveToClipboard(secret);

  console.error("Secret saved to clipboard!");

  console.log(secret);
}

await main();
