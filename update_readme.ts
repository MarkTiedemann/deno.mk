let [readme, example, first_make, second_make] = await Promise.all([
  Deno.readTextFile("README.md"),
  Deno.readTextFile("Makefile"),
  Deno.readTextFile("tmp/first_make.txt"),
  Deno.readTextFile("tmp/second_make.txt"),
]);
// Replace example code
readme = readme.replace(
  /<!--begin-example-->[\s\S]*?<!--end-example-->/,
  `<!--begin-example-->
\`\`\`Makefile
${example.split("# end-example")[0].trim()}
\`\`\`
<!--end-example-->`,
);
// Replace OS-specific example output
let isWin = Deno.build.os === "windows";
let id = isWin ? "windows" : "macos-linux";
let shell = isWin ? "batch" : "";
let command = isWin ? "> make" : "$ make";
readme = readme.replace(
  new RegExp(`<!--begin-${id}-->[\\s\\S]*?<!--end-${id}-->`),
  `<!--begin-${id}-->
\`\`\`${shell}
${command}
${first_make.trim()}
\`\`\`

\`\`\`${shell}
${command}
${second_make.trim()}
\`\`\`
<!--end-${id}-->`,
);
await Deno.writeTextFile("README.md", readme);
