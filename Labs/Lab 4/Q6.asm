include irvine32.inc
.data
	seconds = 60*60*24
.code
main proc
	mov eax, seconds
	call WriteDec
	call crlf
	exit
main endp

end main
