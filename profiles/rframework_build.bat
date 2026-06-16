@echo off

cd ..

set BUILD_NAME=rframework_rtx

scons platform=windows target=editor steamapi=yes module_mono_enabled=yes module_text_server_fb_enabled=yes d3d12=yes accesskit=yes angle=yes -j8
scons platform=windows target=template_debug profile=profiles/rframework_profile.py -j8
scons platform=windows target=template_release profile=profiles/rframework_profile.py -j8

bin/godot.windows.editor.x86_64.mono.exe --headless --generate-mono-glue modules/mono/glue

python modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows --push-nupkgs-local %appdata%/NuGet/GodotSharp

cd bin

ren godot.windows.editor.x86_64.mono.exe editor.exe
ren godot.windows.editor.x86_64.mono.console.exe editor.console.exe
ren godot.windows.template_debug.x86_64.mono.exe windows_debug_x86_64.exe
ren godot.windows.template_debug.x86_64.mono.console.exe windows_debug_x86_64.console.exe
ren godot.windows.template_release.x86_64.mono.exe windows_release_x86_64.exe
ren godot.windows.template_release.x86_64.mono.console.exe windows_release_x86_64.console.exe