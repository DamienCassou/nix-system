import clipboard from "clipboardy";
import { select } from "@inquirer/prompts";
import { readdir } from "node:fs/promises";
import { promisify } from "node:util";
import { execFile as execFileCallback } from "node:child_process";

const execFile = promisify(execFileCallback);

const TOKEN_SECRETS_DIR = `${process.env.PASSWORD_STORE_DIR}/ftgp/token-secrets`;

export async function chooseTarget() {
  const targets = await listTargets();
  return chooseTargetFromTargets({ targets });
}

async function listTargets() {
  const entries = await readdir(TOKEN_SECRETS_DIR, {
    withFileTypes: true,
  });

  const files = entries.filter(isValidTargetEntry);

  return files.map((file) => file.name.replace(/\.gpg$/, ""));
}

function isValidTargetEntry(entry) {
  return entry.isFile() && entry.name.endsWith(".foretagsplatsen.se.gpg");
}

function chooseTargetFromTargets({ targets }) {
  return select(
    {
      message: "Select a target",
      choices: targets.map((target) => ({ name: target, value: target })),
    },
    { output: process.stderr },
  );
}

export async function readSecret({ target }) {
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

export async function saveToClipboard(text) {
  await clipboard.write(text);
}
