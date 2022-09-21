#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

/**
* @nameProyect - MoveKeyRemap
* @autor - <lib.bioq@gmail.com>
* @version - 1.0
*/

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
;Directional arrays
!SC017::sendInput, {up}
!SC025::sendInput, {down}
!SC016::sendInput, {left}
!SC018::sendInput, {right}

; Jump a word left, right
!SC024::sendInput, ^{left}
!SC026::sendInput, ^{right}

; Jump to home, end
!SC032::sendInput, {Home}
!SC033::sendInput, {Enter}
!SC034::sendInput, {End}

/**
* Delete
*/
; Delete a character
; !SC015::send, {BackSpace}
; !SC019::send, {Delete}
; !SC023::send, ^{BackSpace}
; !SC027::send, ^{Delete}
!SC023::sendInput, {BackSpace}
!SC019::sendInput, ^{Delete}

; Delete a word
!SC015::sendInput, ^{BackSpace}
!SC027::sendInput, {Delete}

; Delete to home
^+SC032::sendInput, +{Home}{delete}
; Delete to End
^+SC034::sendInput, +{End}{delete}

; Delete Current Line
^+SC033::sendInput, {End}+{Home}+{Home}{Delete}{Delete}

/**
* SELECTIONS
*/
; Expand Select with array directionals
!+SC017::sendInput, +{up}
!+SC025::sendInput, +{down}
!+SC016::sendInput, +{left}
!+SC018::sendInput, +{right}

; Expand Select word left, right
!+SC024::sendInput, ^+{left}
!+SC026::sendInput, ^+{right}

; Select prev, next word
!+SC023::SelectPrevWord()
!+SC027::SelectNextWord()

; Select to home, end
!+SC032::sendInput, +{Home}
!+SC034::sendInput, +{End}

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






; NOTE - remove this line if you want to use Backspace
; SC00E::SendInput,  {Space}

#If NOT WinActive("ahk_exe Code.exe")
    /**
    * NEW LINE
    */
    ^Enter::sendInput,{End}{Enter}
    ^NumpadEnter::sendInput,{End}{Enter}


    ^+Enter::sendInput,{Home}{Enter}{Up}
    ^+NumpadEnter::sendInput,{Home}{Enter}{Up}

    /**
    * INSERT SEMICOLON(;)
    */
    ; New line down
    +Enter::sendInput,{End}`;
    +NumpadEnter::sendInput,{End}`;

    ; New line up
    !Enter::sendInput,{End}`;{Enter}
    !NumpadEnter::sendInput,{End}`;{Enter}

    /**
    * Delete current Line
    */
    ; ctrl+shift+k: eliminar linea actual
    ^+SC025::sendInput, {End}+{Home}+{Home}{Delete}{Delete}

    !9::sendInput, <
    !0::sendInput, >
#If

