@echo off

scons platform=windows target=editor steamapi=yes module_mono_enabled=yes -j8
scons platform=windows target=template_debug profile=profiles/rframework_profile.py -j8
scons platform=windows target=template_release profile=profiles/rframework_profile.py -j8

bin/godot.windows.editor.x86_64.rframework.mono.exe --headless --generate-mono-glue modules/mono/glue

python modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows