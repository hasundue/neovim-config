type ContentJson = {
  name: string;
  url: string;
};

function isDenoRepo(entries: ContentJson[]): boolean {
  return entries.some((it) =>
    it.name === "deno.json" || it.name === "deno.jsonc" || it.name === "denops"
  );
}

async function updateDenoLock(
  repo: string,
) {
  const name = repo.split("/")[1];
  const response = await fetch(
    `https://api.github.com/repos/${repo}/contents`,
  );
  if (!response.ok) {
    throw new Error(response.statusText);
  }
  const contents: ContentJson[] = await response.json();
  const lock = contents.find((it) => it.name === "deno.lock");
  if (lock) {
    return Deno.writeTextFile(
      `./plugins/${name}/deno.lock`,
      await fetch(lock.url).then((it) => it.text()),
    );
  }
  if (!isDenoRepo(contents)) {
    return;
  }
}

if (import.meta.main) {
  await updateDenoLock(Deno.args[0]);
}
