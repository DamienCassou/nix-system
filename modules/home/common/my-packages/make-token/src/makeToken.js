import jwt from "jsonwebtoken";
import { chooseTarget, readSecret, saveToClipboard } from "./utils.js";

async function main() {
  const target = await chooseTarget();
  const secret = await readSecret({ target });
  const token = await makeToken({ secret });

  await saveToClipboard(token);

  console.error("Token saved to clipboard!");
  console.log(token);
}

function makeToken({ secret }) {
  const payload = {
    IsTemporaryUser: true,
    MonitorUserType: "BackOffice",
    CountryId: "SV",
  };

  const options = {
    algorithm: "HS256",
    issuer: "monitor",
    audience: "monitor",
    notBefore: 0,
    expiresIn: "8h",
  };

  return new Promise((resolve, reject) => {
    jwt.sign(payload, secret, options, (err, token) => {
      if (err) reject(err);
      resolve(token);
    });
  });
}

await main();
