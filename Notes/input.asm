include Irvine32.inc
.data
	fileName byte 80 dup(0)
.code
	main proc
	mov edx, offset filename ; edx points to the string
	mov ecx, sizeof filename - 1 ; ecx specifies the max num of chars user can enter
	call ReadString
	
	exit
main endp
end main
