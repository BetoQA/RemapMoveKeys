#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

/*
 * --------------------------------------------------------------------
 * Proyecto: RemapMoveKeys
 * Autor: <lib.bioq@gmail.com>
 * Versión: <v2.0.0>
 * Fecha: [DD/MM/AAAA]
 *
 * Descripción General:
 *		Remapea las teclas direcionales para que su digitación sea más
 *		comodo y evitar el movimiento brusco de la mano hacia las teclas
 *		direccionales.
 *
 * Notas Técnicas:
 *   – []
 *
 * --------------------------------------------------------------------
 */


;* ----- Configuración -------------------------------------------------
#Include, %A_ScriptDir%\RemapMoveKeys_reverse.ahk
;#Include, %A_ScriptDir%\RemapMoveKeys_standar.ahk
; ----------------------------------------------------------------------

 esAlfanumerico(){
    texto := clipboard
    if StrLen(texto) == 0
    {
        return 2
    }

    StringLower, texto, texto
    statusValid := 0
    Loop, Parse, texto
    {
        ordValue := Ord(A_LoopField)

        if (ordValue >= 48 and ordValue <= 57) or (ordValue >= 97 and ordValue <= 122)
        {
            statusValid := 1
            break
        }
    }
    return statusValid
}

SelectPrevWord(){
    Clipboard := ""
    SendInput, {left}
    SendInput, ^+{left}
    Send, ^c
    Sleep, 50

    statusValue := esAlfanumerico()
    While, statusValue == 0
    {
        Clipboard := ""
        SendInput, {left}
        SendInput, ^+{left}
        Send, ^c
        Sleep, 50
        statusValue := esAlfanumerico()
    }

    if (statusValue == 1)
    {
        sendInput, {left}
        SendInput, ^{right}
        SendInput, ^+{left}
    }
}

SelectNextWord(){
    Clipboard := ""
    SendInput, {right}
    SendInput, ^+{right}
    Send, ^c
    Sleep, 50

    statusValue := esAlfanumerico()
    While, statusValue == 0
    {
        Clipboard := ""
        SendInput, {right}
        SendInput, ^+{right}
        Send, ^c
        Sleep, 50
        statusValue := esAlfanumerico()
    }

    if (statusValue == 1)
    {
        sendInput, {right}
        SendInput, ^{left}
        SendInput, ^+{right}
    }
}





/**
* CURSOR MOV
*/
; Jump to home, end
!SC032::sendInput, {Home}
!SC033::sendInput, {Enter}
!SC034::sendInput, {End}

/**
* Delete
*/
; Delete to home
^+SC032::sendInput, +{Home}{delete}
; Delete to End
^+SC034::sendInput, +{End}{delete}

; Delete Current Line
^+SC033::sendInput, {End}+{Home}+{Home}{Delete}{Delete}


/**
* SELECTIONS
*/
; Select to home, end
!+SC032::sendInput, +{Home}
!+SC034::sendInput, +{End}

; Select prev, next word
!+SC023::SelectPrevWord()
!+SC027::SelectNextWord()

/**
* ESCAPE
*/
!SC00D::sendInput, {Escape}
<^>!SC014::sendInput, {Escape}
/**
* Invirt teclado "=" y "+"
*/
; SC00D:: +
; +SC00D:: sendInput, =

#If NOT WinActive("ahk_exe Code.exe")
    /**
    * NEW LINE
    */
    ; New line down
    ^Enter::sendInput,{End}{Enter}
    ^NumpadEnter::sendInput,{End}{Enter}

    ; New line up
    ^+Enter::sendInput,{Home}{Enter}{Up}
    ^+NumpadEnter::sendInput,{Home}{Enter}{Up}

    /**
    * INSERT SEMICOLON(;)
    */
	; Add semicolon at end of line
    +Enter::sendInput,{End}`;
    +NumpadEnter::sendInput,{End}`;

	; Add semicolon at end of line and new line
    !Enter::sendInput,{End}`;{Enter}
    !NumpadEnter::sendInput,{End}`;{Enter}

    /**
    * Delete current Line
    */
    ; ctrl+shift+k: eliminar linea actual
    ^+SC025::sendInput, {End}+{Home}+{Home}{Delete}{Delete}

	; Add inverted symbols "<" and ">"
    !9::sendInput, <
    !0::sendInput, >
#If

