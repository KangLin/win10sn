Set WshShell = CreateObject("WScript.Shell")
regKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\"
DigitalProductId = WshShell.RegRead(regKey & "DigitalProductId")

WinProductName = "Windows Product Name: " & WshShell.RegRead(regKey & "ProductName") & vbNewLine
WinProductID = "Windows Product ID: " & WshShell.RegRead(regKey & "ProductID") & vbNewLine
WinProductKey = ConvertToKey(DigitalProductId)
strProductKey ="Windows Key: " & WinProductKey & vbNewLine & vbNewLine & "-  康林工作室"& vbNewLine & "-  http://blog.csdn.net/kl222"
WinProductID = WinProductName & WinProductID & strProductKey 

MsgBox(WinProductID)
Dim ret
ret = InputBox(vbNewLine & "你可在下面自行复制序列号："& vbNewLine & vbNewLine & "[ 点击确定或取消退出本程序 ]" ,"Win10 序列号查看器 - iPlaySoft.com",WinProductKey)

Function ConvertToKey(regKey)
    Const KeyOffset = 52
    isWin8 = (regKey(66) \ 6) And 1
    regKey(66) = (regKey(66) And &HF7) Or ((isWin8 And 2) * 4)
    j = 24
    Chars = "BCDFGHJKMPQRTVWXY2346789"
    Do
        Cur = 0
        y = 14
        Do
            Cur = Cur * 256
            Cur = regKey(y + KeyOffset) + Cur
            regKey(y + KeyOffset) = (Cur \ 24)
            Cur = Cur Mod 24
            y = y -1
        Loop While y >= 0
        j = j -1
        winKeyOutput = Mid(Chars, Cur + 1, 1) & winKeyOutput
        Last = Cur
    Loop While j >= 0
    If (isWin8 = 1) Then
        keypart1 = Mid(winKeyOutput, 2, Last)
        insert = "N"
        winKeyOutput = Replace(winKeyOutput, keypart1, keypart1 & insert, 2, 1, 0)
        If Last = 0 Then winKeyOutput = insert & winKeyOutput
    End If
    a = Mid(winKeyOutput, 1, 5)
    b = Mid(winKeyOutput, 6, 5)
    c = Mid(winKeyOutput, 11, 5)
    d = Mid(winKeyOutput, 16, 5)
    e = Mid(winKeyOutput, 21, 5)
    ConvertToKey = a & "-" & b & "-" & c & "-" & d & "-" & e
End Function