import { select } from "@inquirer/prompts";
import { readdir } from "node:fs/promises";
import { promisify } from "node:util";
import { execFile as execFileCallback } from "node:child_process";
import jwt from "jsonwebtoken";

const execFile = promisify(execFileCallback);

const TOKEN_SECRETS_DIR = `${process.env.PASSWORD_STORE_DIR}/ftgp/token-secrets`;

async function main() {
  const targets = await listTargets();
  const target = await chooseTarget({ targets });
  const secret = await readSecret({ target });
  const token = await makeToken({ secret });

  console.log(token);
}

async function listTargets() {
  const entries = await readdir(TOKEN_SECRETS_DIR, {
    withFileTypes: true,
  });

  const files = entries.filter(
    (entry) => entry.isFile() && entry.name.endsWith(".foretagsplatsen.se.gpg"),
  );

  return files.map((file) => file.name.replace(/\.gpg$/, ""));
}

/**
 * @param {object} params -
 * @param {string[]} params.targets
 */
function chooseTarget({ targets }) {
  return select(
    {
      message: "Select a target",
      choices: targets.map((target) => ({ name: target, value: target })),
    },
    { output: process.stderr },
  );
}

async function readSecret({ target }) {
  // Decrypt the GPG file at TOKEN_SECRETS_DIR/${target}.gpg by executing gpg
  // and reading the output.
  const { stdout } = await execFile(
    "gpg",
    ["--decrypt", `${TOKEN_SECRETS_DIR}/${target}.gpg`],
    { encoding: "utf-8" },
  );

  // return the first line of output:
  return stdout.slice(0, stdout.indexOf("\n"));
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
