; test of IRRE_ASM assembly v4

; specify the label to be used as an entry point. optional.
%entry :main

; items here are placfed in the executable code section
%section code

; use BIND ("@") to define a macro
; the argument list is followed by MARK (":")
add2@ rA rB v0 :    ; this macro sets rA = rB + v0
    set ad v0
    add rA rB ad
::

main:
    set r1 $0
    set r2 $4
    add2 r2 r2 $8
    ; labels can be ahead-referenced
    ; any relative offsets will be resolved later
    set r4 ::func1
    cal r4

    ; labels can be accessed with positive offsets
    set r3 ::data1 ; pointer to "hello" string
    set r5 ::data0^#4

    hlt

func1:
    set r7 $ff
    ret

; indicate that items here should be placed in the data section
%section data

; data must appear in the data section
data0:
    %d \x $22000000  ; $22 in little endian
data1:
    %d \' hello ; data string support
    %d \x $00    ; null terminator