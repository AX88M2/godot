@echo off

cd ..

set BUILD_NAME=rframework

scons platform=windows target=editor steamapi=yes module_mono_enabled=yes -j8
scons platform=windows target=template_debug profile=profiles/rframework_profile.py -j8
scons platform=windows target=template_release profile=profiles/rframework_profile.py -j8

bin/godot.windows.editor.x86_64.mono.exe --headless --generate-mono-glue modules/mono/glue

python modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows --push-nupkgs-local %appdata%/NuGet/GodotSharp

ren bin/godot.windows.editor.x86_64.mono.exe bin/editor.exe
ren bin/godot.windows.editor.x86_64.mono.console.exe bin/editor.console.exe
ren bin/godot.windows.template_debug.x86_64.mono.exe bin/windows_debug_x86_64.exe
ren bin/godot.windows.template_debug.x86_64.mono.console.exe bin/windows_debug_x86_64.console.exe
ren bin/godot.windows.template_release.x86_64.mono.exe bin/windows_release_x86_64.exe
ren bin/godot.windows.template_release.x86_64.mono.console.exe bin/windows_release_x86_64.console.exe