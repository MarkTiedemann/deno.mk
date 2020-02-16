# deno.mk

**Cross-plattform Makefile for installing and running [Deno](https://deno.land/).**

## Usage

**1. Download the Makefile**

MacOS & Linux:

```sh
curl -Lo deno.mk https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
```

Windows:

```batch
powershell -c "Invoke-WebRequest -OutFile deno.mk -Uri https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk"
```

**2. Include it in your Makefile**

There are two variables that can be set to configure the installation:
  - `DENO_VERSION`: The version of Deno to be installed _(required)_
  - `DENO_INSTALL`: The directory to install Deno in _(optional, defaults to the current working directory if not set)_

How to use the Makefile:
  - Include it: `include deno.mk`.
  - Before using Deno in a recipe, add `$(DENO_BIN)` as a prerequisite to ensure that Deno is installed.
  - To run Deno in a recipe, use `$(call deno,$arguments)`, e.g. to run `deno --version`, use `$(call deno,--version)`.
  - To uninstall Deno, call the `deno_clean` function.

```Makefile
DENO_VERSION := 0.33.0
DENO_INSTALL := third_party
include deno.mk

.PHONY: all
all: $(DENO_BIN)
	$(call deno,https://deno.land/std/examples/welcome.ts)

.PHONY: clean
clean:
	$(call deno_clean)
```

**3. Test your Makefile**

MacOS & Linux:

```
$ make
mkdir -p third_party/deno-0.33.0/bin
curl -Lo third_party/deno-0.33.0/bin/deno.gz https://github.com/denoland/deno/releases/download/v0.33.0/deno_osx_x64.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   606  100   606    0     0   1607      0 --:--:-- --:--:-- --:--:--  1607
100 12.9M  100 12.9M    0     0  3577k      0  0:00:03  0:00:03 --:--:-- 4202k
gunzip third_party/deno-0.33.0/bin/deno.gz
chmod +x third_party/deno-0.33.0/bin/deno
DENO_DIR=third_party/deno-0.33.0 third_party/deno-0.33.0/bin/deno https://deno.land/std/examples/welcome.ts
Download https://deno.land/std/examples/welcome.ts
Compile https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```

```
$ make
DENO_DIR=third_party/deno-0.33.0 third_party/deno-0.33.0/bin/deno https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```

```
$ tree
.
├── deno.mk
├── Makefile
└── third_party
    └── deno-0.33.0
        ├── bin
        │   └── deno
        ├── deps
        │   └── ...
        └── gen
            └── ...
```

```
$ make clean
rm -rf third_party/deno-0.33.0
```

Windows:

```batch
> make
mkdir third_party
powershell -c "Invoke-WebRequest -OutFile third_party\make-4.2.exe -Uri https://raw.githubusercontent.com/MarkTiedemann/make-for-windows/master/make-4.2/64/make.exe"
third_party\make-4.2.exe
mkdir third_party\deno-0.33.0\bin
powershell -c "Invoke-WebRequest -OutFile third_party\deno-0.33.0\bin\deno.zip -Uri https://github.com/denoland/deno/releases/download/v0.33.0/deno_win_x64.zip"
powershell -c "Expand-Archive -Path third_party\deno-0.33.0\bin\deno.zip -DestinationPath third_party\deno-0.33.0\bin"
del /q third_party\deno-0.33.0\bin\deno.zip
cmd /V /C "set DENO_DIR=third_party\deno-0.33.0& third_party\deno-0.33.0\bin\deno.exe https://deno.land/std/examples/welcome.ts"
Download https://deno.land/std/examples/welcome.ts
Compile https://deno.land/std/examples/welcome.ts
Welcome to Deno 🦕
```

```batch
> make
third_party\make-4.2.exe
cmd /V /C "set DENO_DIR=third_party\deno-0.33.0& third_party\deno-0.33.0\bin\deno.exe https://deno.land/std/examples/welcome.ts"
Welcome to Deno 🦕
```

```batch
> make clean
third_party\make-4.2.exe clean
rmdir /q /s third_party\deno-0.33.0
```

## License

[Blue Oak](https://blueoakcouncil.org/license/1.0.0)
