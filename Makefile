# fsharp-mono-template
# https://github.com/loverdos/fsharp-mono-template
#
# Make sure you have curl and mono, everything else is downloaded, including
# FAKE, NuGet and any dependencies declared in ./.nuget/packages.config
#
# Christos KK Loverdos

.PHONY: clean fetch-deps

all: ./tools/nuget/nuget.exe ./tools/FAKE/tools/FAKE.exe fetch-deps

clean:
	rm -rf ./packages ./tools

./tools/nuget/nuget.exe:
	rm -rf ./tools/nuget && mkdir -p ./tools/nuget
	curl -Lo ./tools/nuget/nuget.exe https://nuget.org/nuget.exe

./tools/FAKE/tools/FAKE.exe: ./tools/nuget/nuget.exe
	mono ./tools/nuget/nuget.exe install FAKE -OutputDirectory tools -ExcludeVersion -Prerelease

fetch-deps: ./tools/FAKE/tools/FAKE.exe
	mono ./tools/FAKE/tools/FAKE.exe ./fetch-deps.fsx
