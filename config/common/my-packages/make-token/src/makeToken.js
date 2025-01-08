import jwt from "jsonwebtoken";
import { listTargets, chooseTarget, readSecret } from "./utils.js";

async function main() {
  const targets = await listTargets();
  const target = await chooseTarget({ targets });
  const secret = await readSecret({ target });
  const token = await makeToken({ secret });

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
