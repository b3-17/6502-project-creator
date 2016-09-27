 #!/bin/bash

createprojectfolder=false
helplevel=""

# create a boiler plate c64 6502 project suite comprising of an index.asm which facilitates acme assembler from two ancillary files, main.asm and $projectname asm
# if -c argument value is set to true, create a project file for eclipse which will allow adding into that ide later.
# if -c is not true, assume a nested project under an existing project, but which will have its own folder under the parent project

while getopts p:f:c: option
do
        case "${option}"
        in
                (p) projectname=${OPTARG};;
                (f) folderpath=$OPTARG;;
                (c) createprojectfolder=$OPTARG;;
        esac
done

indextext='!cpu 6502 \n
!to "%s.prg",cbm    ; output file \n
\n
; useful links  \n
; http://sta.c64.org/cbm64scr.html \n
; http://www.1000bit.it/support/manuali/commodore/c64/Machine_Code_Games_Routines_for_the_Commodore_64.pdf \n
; http://www.6502.org/tutorials/6502opcodes.html#CMP \n
; http://sta.c64.org/cbm64mem.html \n
; http://www.binaryhexconverter.com/decimal-to-hex-converter \n
; http://sta.c64.org/cbm64krnfunc.html \n
\n
;============================================================ \n
; BASIC loader with start address $c000 \n
;============================================================ \n
\n
* = $0801                                ; BASIC start address (#2049) \n
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000... \n
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152 \n
   				            ; start address for 6502 code \n
\n
!source "%s.asm" \n
!source "main.asm"'

maintext='* = $c000 ; load our program into 49152, 4k ram after BASIC'

projectfiletext='<?xml version="1.0" encoding="UTF-8"?>\n
<projectDescription>\n
        <name>%s</name>\n
        <comment></comment>\n
        <projects>\n
        </projects>\n
        <buildSpec>\n
        </buildSpec>\n
        <natures>\n
        </natures>\n
</projectDescription>\n'

createprojectfiles() {
	mkdir $folderpath/$projectname
	touch $folderpath/$projectname/main.asm
	touch $folderpath/$projectname/index.asm
	touch $folderpath/$projectname/$projectname.asm
	if [ $createprojectfolder = true ]
		then touch $folderpath/$projectname/.project
	fi

	writetoprojectfiles
	echo "$folderpath $projectname has been created"
}

writetoprojectfiles(){
	printf "$indextext" "$projectname" "$projectname" > $folderpath/$projectname/index.asm
	printf "$maintext" > $folderpath/$projectname/main.asm
	if [ $createprojectfolder = true ]
		then printf "$projectfiletext" "$projectname" > $folderpath/$projectname/.project
	fi
}

if [ -z "$projectname" ] || [ "$projectname" = " " ] 
		then echo "cannot continue, no project name has been set"
	elif [ -z "$folderpath" ] || [ "$folderpath" = " " ] 
		then echo "cannot continue, no folder path has been set"
	elif [ -d "$folderpath/$projectname" ]
		then echo "folder already exists, do not overwrite"
	else createprojectfiles
fi



