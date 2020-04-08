org 100h
.model small
.stack 100h

.data
dinosourpos dw 270
dinosourpos2 dw 350
treepos1 dw 540     ;tree size
treepos2 dw 560
go db "Game Over!$"
i dw 0
randtree dw 0
randspeed dw 0
speed dw 1
life dw 3
score dw 0

.code 

;main procedure
main proc
    
    mov dx, @data
    mov ds, dx
    
    call mainline
    
    initialize:
    
        call dinosour
        
        call move_tree
        
        ; check if lifes available
        cmp life,0
        je exit
                       
        
        L6:      ; check if key pressed  
            mov ah, 1
            int 16h
            jnz key_pressed
            jmp initialize
        
        key_pressed:
            mov ah, 0
            int 16h ;consume key buffer
            mov dl, al ; ascii in dl
        
            mov ah, 2
            int 21h
            cmp dl, 'q' ; quiting
            je exit
            cmp dl, 'j'
            je call_jump
            jmp initialize
        
        call_jump:
            call jump
            jmp initialize
            
exit:
    
ret      
endp main 

mainline proc 
        
    ;set video mode
    mov ah, 0
    mov al, 12h
    int 10h
    
    ; set a pixel
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 50
    mov dx, 350
   
    
    L1:
        int 10h
        inc cx
        cmp cx, 600
        jne L1        
        
     ret 
endp mainline



dinosour proc     
    ; set a pixel
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos
    
    L2:
        int 10h
        inc dx
        cmp dx, dinosourpos2
        jne L2
        
        
    ; set a pixel
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 120
    mov dx, dinosourpos
    
    L3:
        int 10h
        inc dx
        cmp dx, dinosourpos2
        jne L3
        
        
    ; set a pixel
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos
    
    L4:
        int 10h
        inc cx
        cmp cx, 120
        jne L4
        
    ; set a pixel
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos2
    
    L5:
        int 10h
        inc cx
        cmp cx, 120
        jne L5    
        
    ret
endp dinosour

clean_dinosour proc     
    ; set a pixel
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos
    
    L9:
        int 10h
        inc dx
        cmp dx, dinosourpos2
        jne L9
        
        
    ; set a pixel
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, 120
    mov dx, dinosourpos
    
    L10:
        int 10h
        inc dx
        cmp dx, dinosourpos2
        jne L10
        
        
    ; set a pixel
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos
    
    L11:
        int 10h
        inc cx
        cmp cx, 120
        jne L11
        
    ; set a pixel
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, dinosourpos2
    
    L12:
        int 10h
        inc cx
        cmp cx, 120
        jne L12
    
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, 80
    mov dx, 350
    
    L13:
        int 10h
        inc cx
        cmp cx, 120
        jne L13    
        
    ret
endp clean_dinosour


jump proc
    
    L7:
        mov i, 0
        cond:
            cmp i, 110
            jl iter
            jmp L8
            
        iter:
            call clean_dinosour
            inc i
            dec dinosourpos
            dec dinosourpos2
            

            call dinosour
            call move_tree
            jmp cond
        
    L8:
        mov i, 0
        cond2:
            cmp i, 110
            jl iter2
            jmp exitloop
            
        iter2:
            call clean_dinosour
            inc i
            inc dinosourpos
            inc dinosourpos2
                                                
            call dinosour
            call move_tree
            jmp cond2  
            
    exitloop:
    ret
endp jump        


tree proc
    
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 350
    
    L14:
        int 10h
        inc cx
        cmp cx, treepos2
        jne L14
        
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 300
    
    L15:
        int 10h
        inc cx
        cmp cx, treepos2
        jne L15
        
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 300
    
    L16:
        int 10h
        inc dx
        cmp dx, 350
        jne L16 
    
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, treepos2
    mov dx, 300
    
    L17:
        int 10h
        inc dx
        cmp dx, 350
        jne L17   
    
    
    ret
endp tree

clean_tree proc
    
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 350
    
    L18:
        int 10h
        inc cx
        cmp cx, treepos2
        jne L18
        
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 300
    
    L19:
        int 10h
        inc cx
        cmp cx, treepos2
        jne L19
        
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 300
    
    L20:
        int 10h
        inc dx
        cmp dx, 350
        jne L20 
    
    mov ah, 0ch
    mov al, 0 ; light red = 12 ; white  = 15
    mov cx, treepos2
    mov dx, 300
    
    L21:
        int 10h
        inc dx
        cmp dx, 350
        jne L21
        
    mov ah, 0ch
    mov al, 15 ; light red = 12 ; white  = 15
    mov cx, treepos1
    mov dx, 350
    
    L22:
        int 10h
        inc cx
        cmp cx, treepos2
        jne L22
    
    ret
endp clean_tree

move_tree proc
    
        cmp treepos1, 20
        je init_new_tree
        jmp continue
        
        init_new_tree:
            
            inc score   ; update score
            mov dx, score
            mov ah, 2
            int 21h
                    
            call clean_tree
                        
            ;rand operation starts here
            pushall macro
            push ax
            push bx
            push cx
            push dx
            endm
        
            popall macro
            pop dx
            pop cx
            pop bx
            pop ax
            endm
        
            ; following macro stores a random value using system time
            ; into cur variable (word)
            getrand macro cur 
            pushall
            mov ah, 0
            int 1ah
            
            mov ax, dx
            mov dx, cx  ;dx:ax contains system time
            
            mov bx, 7261
            mul ax
            add ax, 1
            mov dx, 0
            mov bx, 10  ;limit 32767
            div bx
            
            mov cur, dx
            popall
            endm
            ;rand operation ends here
            
            ;speed generator
            getrand randspeed
            cmp randspeed, 5
            jl normal
            jg faster
            je faster            
            normal:
                mov speed, 1
                jmp speedGenerated                
            faster:
                mov speed, 2
                jmp speedGenerated
            
                        
            speedGenerated:
            
            ;change the width of tree
            mov treepos2, 560 ; new position2 ends at 560
            getrand randtree  ; generates random value for treepos 
            cmp randtree, 5
            jl littletree
            je bigtree
            jg mediumtree
            
            littletree:            
                mov treepos1, 550  ; new position1 depends on rand
                mov speed, 2
                jmp continue            
            bigtree:
                mov treepos1, 520  ; new position1 depends on rand
                jmp continue
            mediumtree:
                mov treepos1, 540  ; new position1 depends on rand
                jmp continue
            
        
        continue:           
            call clean_tree
            ;select speed
            cmp speed,2
            jl selectNormal
            je selectFaster
            jg selectFaster
            
            selectNormal:
                dec treepos1 ; treepos decreases once
                dec treepos2
                jmp treemoved
            selectFaster:
                dec treepos1 ; treepos decreases twice
                dec treepos1
                dec treepos2
                dec treepos2
                jmp treemoved
            
            treemoved:
            call tree
            ; checks confliction while tree moves
            cmp treepos1, 120
            jl deadzone
            jmp done
            deadzone:
            cmp treepos2, 80
            jg deadzone2
            jmp done
            deadzone2:
            cmp dinosourpos2, 300
            jg go1
            jmp done
            go1:            
            mov dl, 7 ;beep         
            mov ah, 2
            int 21h
            dec life
            jmp init_new_tree
                               
            done:
    
    ret
endp move_tree





end main