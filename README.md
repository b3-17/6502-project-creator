# 6502-project-creator
Simple bash script which can set up a basic 6502, c64 project. 

When learning c64 6502 machine language, you might have to create test projects over and over again. It can be tedious to go
through each file and update the sources, build targets, paths etc. Missing a directive or mistyping can lead to assembly errors.
This script when run will create a project with the following files in a new folder:

* index.asm
* main.asm
* a core project file (e.g. if run as foo, will create a foo.asm).
* if not being run with a nest command, will create a .project xml file for eclipse.
* simply refresh eclipse (for nested) or add new project of the same name and location to see created projects!

Will set up files with boiler plate directives:

* the index will have the relative !source directives.
* main will have the * entry point pointing to $c000

Bash arguments:

* -c if true, create eclipse project file, otherwise if false, will not create a project file (i.e. not being used with eclipse, OR is a nested project within an existing eclipse project).
* -f folder path. Specify full BASE folder path for the project to be created IN. Will NOT overwrite existing folder paths.
* -p project name. Specify the project name which will detirmine the .project name (if -c = true), the folder name of the folder created IN the base folder path, the .prg assembly target and the name of the .asm file for the core project.

Useage:

*Nested:
/$PATH-TO-SCRIPT/c64projectsetup.sh -c false -p projectname -f /$PATH-TO-PROJECT-PARENTFOLDER/

*New eclipse project
/$PATH-TO-SCRIPT/c64projectsetup.sh -c true -p projectname -f /$PATH-TO-PROJECT-PARENTFOLDER/
