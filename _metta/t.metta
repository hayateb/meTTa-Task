;; The lists for task manipulation  
(::A(::B(::C(::D))))  

;; Extracting the last element in the list  
(= (last (:: $X ())) $X)  
(= (last (:: $X $Y)) (last $Y))  

!(last (::A(::B(::C(::D())))))  

;; Prepending an element to the beginning of the list  
(= (prepend $elem $list) (:: $elem $list))  

!(prepend Z (::A(::B(::C()))))  

;; Appending an element to the end of the list  
(= (append $list $elem)  
   (match $list  
      (:: $X ()) (:: $X (:: $elem ()))  
      (:: $X $Y) (:: $X (append $Y $elem))  
   )  
)  

!(append (::A(::B(::C(::D())))) E)  

;; Finding the length of a list  
(= (length-list ()) 0)  
(= (length-list $list)  
   (if (cdr-atom $list)  
      (+ 1 (length-list (cdr-atom $list)))  
      1  
   )  
)  

!(length-list (A B C D))  

;; Flattening a nested list  
(= (flatten (:: $X ())) $X)  
(= (flatten (:: $X $Y))  
   (cons-atom $X (flatten $Y))  
)  

!(flatten (:: A (:: B (:: C (:: D ())))))  

;; Finding the length of an expression  
(= (length-expression ()) 0)  
(= (length-expression ($X $Y))  
   (+ 1 (length-expression $Y))  
)  

!(length-expression (A B C D))  

;; Summing two numbers  
(= (sum-expression ($a $b))  
   (if (and (number? $a) (number? $b))  
      (+ $a $b)  
      (Error "invalid input")  
   )  
)  

!(sum-expression (10 20))  

;; Selecting an element by index  
(= (select $list 0) (car-atom $list))  
(= (select $list $n)  
   (if (> $n 0)  
      (select (cdr-atom $list) (- $n 1))  
      (Error "out of range"))  
)  

!(select (7 8 9) 2)  ;; Returns 9  
!(select (7 8 9) 3)  ;; Returns Error  

;; Slicing a list  
(= (slice $list 0 $end)  
   (if (or (= $end 0) (not (cdr-atom $list)))  
      ()  
      (cons-atom (car-atom $list) (slice (cdr-atom $list) 0 (- $end 1))))  
)  

!(slice (1 2 3 4 5) 1 3)  

;; Reconstructing a list using car-atom, cdr-atom, and cons-atom  
(= (reconstruct $list)  
   (if (cdr-atom $list)  
      (cons-atom (car-atom $list) (reconstruct (cdr-atom $list)))  
      (car-atom $list)  
   )  
)  

!(reconstruct (1 2 3 4))  
