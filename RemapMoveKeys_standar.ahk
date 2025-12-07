#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

/**
* @nameProyect - MoveKeyRemap_reverse
* @autor - <lib.bioq@gmail.com>
* @version - 1.0
*/

/**
* CURSOR MOV
*/
;Directional arrays
!SC017::sendInput, {up}
!SC025::sendInput, {down}
!SC024::sendInput, {left}
!SC026::sendInput, {right}

; Jump a word left, right
!SC016::sendInput, ^{left}
!SC018::sendInput, ^{right}

/**
* Delete
*/
; Delete a character
!SC023::sendInput, {BackSpace}
!SC027::sendInput, {Delete}

; Delete a word
!SC015::sendInput, ^{BackSpace}
!SC019::sendInput, ^{Delete}

/**
* SELECTIONS
*/
; Expand Select with array directionals
!+SC017::sendInput, +{up}
!+SC025::sendInput, +{down}
!+SC024::sendInput, +{left}
!+SC026::sendInput, +{right}

; Expand Select word left, right
!+SC016::sendInput, ^+{left}
!+SC018::sendInput, ^+{right}
