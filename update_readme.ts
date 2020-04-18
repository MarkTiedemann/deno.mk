main();

async function main(): Promise<void> {
    let [readme, example, first_make, second_make] = await readFiles("README.md", "Makefile", "tmp/first_make.txt", "tmp/second_make.txt");
    // Replace Example Code
    readme = replace(readme, "<!--begin-example-->", "<!--end-example-->", `
\`\`\`Makefile
${example.split("# end-example")[0].trim()}
\`\`\`
`);
    // Replace OS-specific Example Output
    let os = Deno.build.os;
    let id = os === "win" ? "windows" : "macos-linux";
    let shell = os === "win" ? "batch" : "";
    let command = os === "win" ? "> make" : "$ make";
    readme = replace(readme, `<!--begin-${id}-->`, `<!--end-${id}-->`, `
\`\`\`${shell}
${command}
${first_make.trim()}
\`\`\`

\`\`\`${shell}
${command}
${second_make.trim()}
\`\`\`
`);
    return writeFile("README.md", readme);
}

function replace(string: string, beginTag: string, endTag: string, replacement: string): string {
    let beginIdx = string.indexOf(beginTag);
    let endIdx = string.indexOf(endTag);
    return string.substring(0, beginIdx + beginTag.length) + replacement + string.substring(endIdx);
}

function readFiles(...fileNames: string[]): Promise<string[]> {
    let decoder = new TextDecoder();
    return Promise.all(fileNames.map(f => Deno.readFile(f).then(b => decoder.decode(b))));
}

function writeFile(fileName: string, content: string): Promise<void> {
    let encoder = new TextEncoder();
    return Deno.writeFile(fileName, encoder.encode(content));
}