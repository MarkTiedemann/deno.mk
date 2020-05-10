# deno.mk

**Cross-platform Makefile for installing and running [Deno](https://deno.land/).**

## Why should I use this?

- This Makefile works on MacOS, Linux, and Windows out of the box. This makes your Deno project easy to contribute to for people with different operating systems. For example, as a Linux user, you don't need to know how to unzip files or set environment variables on Windows. This Makefile handles all the cross-platform details and pitfalls for you and your contributors.
- This Makefile creates an isolated Deno environment, with both the Deno binary as well as the Deno directory being located in your project directory. This makes it easy for you to manage multiple, independent Deno projects on your computer, without any side-effects. It also ensures that contributors to your project always use the intended Deno version. For example, if someone has installed Deno 0.20.0 on his computer, but your project requires Deno 0.40.0, then building the project will still work since the Deno version specified in your Makefile will be used.
- This Makefile removes install, uninstall, and update concerns. If someone downloads your project, they will only need to run `make` rather than having to figure out how to install Deno on their system first. If they delete the project, the project-specific Deno installation will be deleted, too. Updates are declarative: To update the Deno version of your project, you only need to set a new Deno version number in your Makefile and run `make` again.
- It's simple, proven, debuggable technology. Though this project may have a rather long documentation, its core is a simple 50-line Makefile. When you run `make`, all the commands that are necessary to install the specific Deno version in your project will be printed as they are executed. It's fully transparent; there's no magic.

## How do I use it?

**1. Download the Makefile**

```sh
curl -o deno.mk https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
```

**2. Include it in your Makefile**

There are two variables that can be set to configure the installation:
  - `DENO_VERSION`: The version of Deno to be installed _(required)_
  - `DENO_INSTALL`: The directory to install Deno in _(optional, defaults to the current working directory if not set)_

How to use the Makefile:
  - Include it: `include deno.mk`.
  - Before using Deno in a recipe, add `$(DENO_BIN)` as a prerequisite to ensure that Deno is installed.
  - To run Deno in a recipe, use `$(call deno,$arguments)`, e.g. to run `deno --version`, use `$(call deno,--version)`.

<!--begin-example-->
```Makefile
DENO_VERSION := 1.0.0-rc2
DENO_INSTALL := third_party
include deno.mk

.PHONY: all
all: $(DENO_BIN)
	$(call deno,run https://deno.land/std/examples/welcome.ts)
```
<!--end-example-->

**3. Test your Makefile**

MacOS & Linux:

<!--begin-macos-linux-->
```
$ make
mkdir -p third_party/deno-0.41.0/bin
curl -Lo third_party/deno-0.41.0/bin/deno.zip -C - https://github.com/denoland/deno/releases/download/v0.41.0/deno-x86_64-apple-darwin.zip
unzip -qod third_party/deno-0.41.0/bin third_party/deno-0.41.0/bin/deno.zip
rm third_party/deno-0.41.0/bin/deno.zip
chmod +x third_party/deno-0.41.0/bin/deno
DENO_DIR=third_party/deno-0.41.0 third_party/deno-0.41.0/bin/deno https://deno.land/std/examples/welcome.ts
Download https://deno.land/std/examples/welcome.ts
Compile https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```

```
$ make
DENO_DIR=third_party/deno-0.41.0 third_party/deno-0.41.0/bin/deno https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```
<!--end-macos-linux-->

```
$ tree
.
├── deno.mk
├── Makefile
└── third_party
    └── deno-$version
        ├── bin
        │   └── deno
        ├── deps
        │   └── ...
        └── gen
            └── ...
```

Windows:

<!--begin-windows-->
```batch
> make
md third_party\deno-1.0.0-rc2\bin
curl -Lo third_party\deno-1.0.0-rc2\bin\deno.zip https://github.com/denoland/deno/releases/download/v1.0.0-rc2/deno-x86_64-pc-windows-msvc.zip
powershell -c "Expand-Archive -Path third_party\deno-1.0.0-rc2\bin\deno.zip -DestinationPath third_party\deno-1.0.0-rc2\bin"
del /q third_party\deno-1.0.0-rc2\bin\deno.zip
cmd /c "set DENO_DIR=third_party\deno-1.0.0-rc2& third_party\deno-1.0.0-rc2\bin\deno.exe run https://deno.land/std/examples/welcome.ts"
Download https://deno.land/std/examples/welcome.ts
Compile https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```

```batch
> make
cmd /c "set DENO_DIR=third_party\deno-1.0.0-rc2& third_party\deno-1.0.0-rc2\bin\deno.exe run https://deno.land/std/examples/welcome.ts"
Welcome to Deno 🦕
```
<!--end-windows-->

## License

[Blue Oak](https://blueoakcouncil.org/license/1.0.0)