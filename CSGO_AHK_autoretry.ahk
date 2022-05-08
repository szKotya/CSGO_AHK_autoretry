#SingleInstance Force


FileInstall, 3.wav, %a_temp%\3.wav
FileInstall, 4.wav, %a_temp%\4.wav
End::ExitApp


sc43::
if WinActive("ahk_exe csgo.exe")
{
    Checkactive := !Checkactive
    If Checkactive
    {
        SendInput, {sc29}
        Sleep, 50
        Clipboard = %Clipboard%
        SendInput, connect %clipboard%;net_graph 1{enter}
        SetTimer, Check, 750
        SoundPlay, %a_temp%\4.wav,
    }
    Else
    {
        SetTimer Check, Off
        SoundPlay, %a_temp%\3.wav,
    }
}

return


Check:
if WinActive("ahk_exe csgo.exe")
{
    WinGetPos, WinX, WinY, Width, Height, A
    Width := Width + WinX
    Height := Height + WinY
    PixelSearch, ImageX, ImageY, WinX, WinY, Width, Height, 0xff7e19, 5, Fast RGB
    if ErrorLevel
    {
        ; 0x1919FF
        ; 0x007FFF
        PixelSearch, ImageX, ImageY, WinX, WinY, Width, Height, 0xff1919, 5, fast
        if ErrorLevel
        {
            SendInput, {sc29}
            Sleep, 50
            SendInput, retry{enter}
            return
        }
    }
    SetTimer Check, Off
    Checkactive := !Checkactive
    SoundPlay, %a_temp%\3.wav,
}
return
