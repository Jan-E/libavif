cd ext
git clone -b "v2.0.2" --depth 1 https://aomedia.googlesource.com/aom
cd aom
if exist build.libavif rd build.libavif /s /q
md build.libavif
cd build.libavif
cmake -G "Visual Studio 16 2019" -A x64 -DENABLE_DOCS=0 -DENABLE_EXAMPLES=0 -DENABLE_TESTDATA=0 -DENABLE_TESTS=0 -DENABLE_TOOLS=0 -DENABLE_NASM=1 -DENABLE_SSE2=1 -DENABLE_SSE3=1 -DENABLE_SSSE3=1 -DENABLE_SSE4_1=1 -DENABLE_SSE4_2=1 -DENABLE_AVX=1 -DENABLE_AVX2=1 ..
msbuild /t:Build /p:Configuration=Release /p:Platform=x64 AOM.sln
xcopy Release\*.??b . /y
xcopy Release\aom.lib .\aom_a.lib* /y
xcopy .\aom_a.lib ..\..\..\RelWithDebInfo\* /y
cd ..\..\..
if exist CMakeCache.txt del CMakeCache.txt
if exist CMakeFiles rd CMakeFiles /s /q
cmake -G "Visual Studio 16 2019" -A x64 -DAVIF_CODEC_AOM=1 -DAVIF_LOCAL_AOM=1 -DAVIF_ENABLE_WERROR=0 .
msbuild /t:Build /p:Configuration=RelWithDebInfo /p:Platform=x64 libavif.sln
