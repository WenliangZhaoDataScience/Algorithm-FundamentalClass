;; Programming Language coding assignment 2: Scheme functions
;; Lecturer: Benjamin Goldberg
;; Student Name: Wenliang Zhao
;; NYU ID: N14346975

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 1

;; (fromTo k n)           returns the list of integers from k to n.
;;                        The size of the problem can be seen as the
;;                        difference between k and n.
;; Base Case:             if k = n (i.e. if the size of the difference is 0)
;;                        then the result is the list containing only n.
;; Hypothesis:            Assume (fromTo (+ k 1) n) returns the list of integers
;;                        k+1 to n.
;; Recursive step:        (fromTo k n) = (cons k (fromTo (+ k 1) n) )

(define (fromTo k n)
  (cond ( (= k n) (list k) )
        (else (cons k (fromTo (+ k 1) n) ) )
  )
)

;; Test run
(fromTo 3 8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 2

;; (removeMults m L)                 returns a list who doesn't contain and multiple if m.
;;                                   The size of the problem is the length of L.
;; Base Case:                        If L is empty, return a empty list.
;; Hypothesis:                       Assume (removeMults m (cdr L) ) returns a list whose elements
;;                                   are all not multiple of m.
;; Recursive step:                   If (modulo (car L) m) != 0, (removeMults m L) = (cons (car L) (removeMults m (cdr L) ) )
;;                                   If (modulo (car L) m)  = 0, (removeMults m L) = (removeMults m (cdr L) )

(define (removeMults m L)
  (cond ( (null? L) '() )
        (else (cond ( (not (= (modulo (car L) m) 0) ) (cons (car L) (removeMults m (cdr L) ) ) )
                    (else (removeMults m (cdr L) ) )
              )
        )
  )
)

;; Test run
(removeMults 3 '(2 3 4 5 6 7 8 9 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 3

;; (removeMults m L)                 returns a list who doesn't contain and multiple if m.
;;                                   The size of the problem is the length of L.
;; Base Case:                        If L is empty, return a empty list.
;; Hypothesis:                       Assume (removeMults m (cdr L) ) returns a list whose elements
;;                                   are all not multiple of m.
;; Recursive step:                   If (modulo (car L) m) != 0, (removeMults m L) = (cons (car L) (removeMults m (cdr L) ) )
;;                                   If (modulo (car L) m)  = 0, (removeMults m L) = (removeMults m (cdr L) )

(define (removeMults m L)
  (cond ( (null? L) '() )
        (else (cond ( (not (= (modulo (car L) m) 0) ) (cons (car L) (removeMults m (cdr L) ) ) )
                    (else (removeMults m (cdr L) ) )
              )
        )
  )
)

;; (removeAllMults L)         returns the list any element is not multiple of others.  
;;                            The worst case size of the problem (i.e. for each recursion,
;;                            all elements are kept after removeMults) is sum of arithematic
;;                            array of (n + (n-1) + ... + 1) = (n-1)n/2
;; Base Case:                 If L is empty return '().
;; Hypothesis:                Assume (removeAllMults (cdr L) ) returns the
;;                            list of non-multiples except the first element of L.
;; Recursive step:            (removeAllMults L) = (cons (car L) (removeAllMults (cdr L) ) )
(define (removeAllMults L)
  (cond ( (null? L) '() )
        (else (cons (car L) (removeMults (car L) (removeAllMults (cdr L) ) ) ) )
  )
)

;; Test run
(removeAllMults '(3 4 6 7 8 10 12 15 20 22 23))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 4

(define (addPrime m L)
  
  ;; (notMult m L)          returns a list with single number which
  ;;                        is not multiple of list L
  ;; Base Case:             If the list is empty, return m as a list
  ;; Hypothesis:            Assume (notMult m (cdr L)) return if m is
  ;;                        multiple of the rest of list L.
  ;; Recursive step:        if (modulo (car L) m ) is 0, return '()
  ;;                        otherwise, return (notMult m (cdr L))
  
  (define (notMult m L)
      (cond ( (null? L) (list m) )
            (else (cond ( (not (= (modulo m (car L)) 0) ) (notMult m (cdr L) ) ) 
                        (else '())
                  )
            )
      )
  )
  (append L (notMult m L) )
)

;; (prime n) returns all prime number within (inclusive) n
;; Base Case:              If n = 2, return '(2)
;; Hypothsis:              Assume (prime (- n 1)) returns all
;;                         prime number within (n-1)
;; Recursive Step:         For the new number n, check if it
;;                         is multiple of all (n-1) prime numbers.
;;                         Add n at the back of prime number list
;;                         for (n-1). If notMulti return '(), then
;;                         just add empty list.

(define (primes n)
  (cond ( (= n 2) '(2) )
        (else (addPrime n (primes (- n 1) ) ) )
  )
)

;; Test run
(primes 30)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 5

;; (maxDepth L)             returns the maximum depth of a nested list
;; Base Case:               If L is empty, return 0; if L is number, return -1.
;; Hypothesis:              Assume (maxDepth M) returns the maximum depth of M,
;;                          where M is one of the subarray of L.
;; Recursive step:          (maxDepth L) = (+ (apply max (map maxDepth L) ) 1),
;;                          which means calculating maximum depth of all subarrays
;;                          of L, get max one among them, and add 1 to the result.
(define (maxDepth L)
  (cond ( (null? L) 0 )
        ( (not (list? L) ) -1)
        (else (+ (apply max (map maxDepth L) ) 1) )
  )
)

;; Test run
(maxDepth '((0 1) (2 (3 (4 5 (6 (7 8) 9) 10) 11 12) 13) (14 15)))
(maxDepth '() )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 6

;; (prefix exp)              transforms an infix arithmetic expression exp into
;;                           prefix notation
;; Base Case:                If exp is empty, return empty list; if exp only contains
;;                           return that element.
;; Hypothesis:               Assume (prefix (removeFirstTwo exp) ) return the prefix expression
;;                           list.
;; Recursive step:           (prefix exp) = (list (cadr (firstTwo exp) ) (car (firstTwo exp) )  (prefix (removeFirstTwo exp) ) ) )
(define (prefix exp)
  
  (define (firstTwo L)
    (cond ( (null? (cdr L) ) (car L) )
          (else (cons (car L) (list (cadr L) ) ) )
    )
  )

  (define (removeFirstTwo L)
    (cond ( (null? L) '() )
          ( (null? (cdr L) ) (car L) )
          (else (cddr L) )
    )
  )                            
                                       
  (cond ( (not (list? exp)) exp )
        ( (null? exp) '() )
        ( (null? (cdr exp) ) (car exp))
        (else (cond ( (or (eq? (cadr (firstTwo exp)) '+) (eq? (cadr (firstTwo exp)) '-) (eq? (cadr (firstTwo exp)) '*) (eq? (cadr (firstTwo exp)) '/) )
                      (list (cadr (firstTwo exp) ) (car (firstTwo exp) )  (prefix (removeFirstTwo exp) ) ) )
                    (else (display "Operator not found!") (newline) )                  
              )
        )
  )
)
              
(prefix 3)
(prefix '(3 + 4))
(prefix '((3 + 4) * 5))
(prefix '(3 + 4 * 5 - 6))
(prefix '((3 * 4) + (5 - 6) * 7))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Just for fun, below is a code follow real mathematic rules on operators  ; 
; prefix of '(3 + 4 * 5 - 6) now is (- (+ 3 (* 4 5) ) 6)                   ;
; A version of prefix giving the correct output is shown below             ;
; If the grader think it is not relevant, please ignore. Thanks!           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (prefix exp)         transforms an infix arithmetic expression exp into
;;                      prefix notation following mathematical rules.
;; Base Case:           If exp is a number, return exp; if exp is empty, return '();
;; Hypothesis:          Assume (prefix (removeLastTwo exp)) and (prefix (lastTwo exp))
;;                      return prefix expression list for L1 and L2, where L1 is the list
;;                      of original list without last two element, L2 is the list with only
;;                      the last two elements.
;; Recursive step:      If operator in L2 is "+ or -", (prefix exp) =
;;                      (list (car p2) (prefix (removeLastTwo exp) ) (car (cdr (lastTwo exp) ) ) );
;;                      if operator in L2 is "* or /", then (prefix exp) =
;;                      (list (car (cadr (partition (removeLastTwo exp) (lastTwo exp) ) ) )         (continue in next line)
;;                      (prefix (car (partition (removeLastTwo exp) (lastTwo exp) ) ) )             (continue in next line)
;;                      (prefix (cdr (cadr (partition (removeLastTwo exp) (lastTwo exp) ) ) ) ) )

(define (prefix exp)
  
  ;; (lastTwo L)        returns a list containing last two element of L. 
  ;;                    First should be an operator, and second should be
  ;;                    an id.
  ;; Base Case:         If L's length is 2, return L.
  ;; Hypothesis:        Assume (lastTwo (cdr L) return the last 2 elements of L.
  ;; Recursive step:    (lastTwo L) = (lastTwo (cdr L) )
  (define (lastTwo L)
    (cond ( (null? (cddr L) ) L)
          (else (lastTwo (cdr L) ) )
    )
  )

  ;; removeLastTwo      returns a list L without the last two elements.
  ;; Base Case:         If L doesn't have at least 2 elements, return '()
  ;; Hypothesis:        Assume (removeLastTwo (cdr L) return a list without
  ;;                    the last two elements of L
  ;; Recursive step     (removeLastTwo L) = (cons (car L) (removeLastTwo (cdr L) ) )
  (define (removeLastTwo L)
    (cond ( (null? (cddr L) ) '() )
          (else (cons (car L) (removeLastTwo (cdr L) ) ) )
    )
  )                            
                                 
  ;; (partition L1 L2)               returns a list containing 2 lists with the first
  ;;                                 element of the later one is an "+ or -" operator, and
  ;;                                 if the length of the later one larger than 2, other
  ;;                                 operator in the second list are all "* or /"
  ;; Base Case:                      If L1 is empty, return ('() L2); if L1 has only only
  ;;                                 element, return (L1 L2)
  ;; Hypothesis:                     Assume (partition (removeLastTwo L1) (append (lastTwo L1) L2) ) )
  ;;                                 returns the partition result based on (removeLastTwo L1) and
  ;;                                 (append (lastTwo L1) L2).
  ;; Recursive step:                 If the first operator in L2 is "+ or -", (partition L1 L2) =
  ;;                                 (list (removeLastTwo L1) (append (lastTwo L1) L2) ) ); if the
  ;;                                 first operator in L2 is "* or /", (partition L1 L2) =
  ;;                                 (partition (removeLastTwo L1) (append (lastTwo L1) L2) )
  
  (define (partition L1 L2)
    (cond ( (null? L1) (list '() L2) )
          ( (null? (cdr L1) )
            (list L1 L2) )
          (else (cond ( (or (eq? (car (lastTwo L1) ) '+) (eq? (car (lastTwo L1) ) '-) )  
                        (list (removeLastTwo L1) (append (lastTwo L1) L2) ) )
                                         
                      (else (partition (removeLastTwo L1) (append (lastTwo L1) L2) ) )
                )
          )
    )
  )

  (cond ( (not (list? exp)) exp )
        ( (null? exp) '() )
        ( (null? (cdr exp) ) (car exp))
        (else (cond ( (or (eq? (car (lastTwo exp)) '+) (eq? (car (lastTwo exp)) '-) )
                      (list (car (lastTwo exp) ) (prefix (removeLastTwo exp) ) (car (cdr (lastTwo exp) ) ) ) )
                      
                    (else (list (car (cadr (partition (removeLastTwo exp) (lastTwo exp) ) ) )
                          (prefix (car (partition (removeLastTwo exp) (lastTwo exp) ) ) )
                          (prefix (cdr (cadr (partition (removeLastTwo exp) (lastTwo exp) ) ) ) ) )
                    )
              )
        )
  )
)

;; Test run
(prefix 3)
(prefix '(3 + 4))
(prefix '((3 + 4) * 5))
(prefix '(3 + 4 * 5 - 6))
(prefix '((3 * 4) + (5 - 6) * 7))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Extra code ends. Many thanks if you read it!                             ;                                                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 7

;; (composition fns)                  returns combined function which is the composition of the functions in fns
;; Base Case:                         If fns only contains 1 function (i.e. (cdr fns) = null,
;;                                    return the first function, represented by f1 here.
;; Hypothesis:                        Assume (composition (cdr fns)), represented by fr (rest functions)
;;                                    returns the functon which is the composition of the functions
;;                                    in fns except the first function.                                   
;; Recursive step:                    (composition fns) = (lambda (x) (f1 (fr x) ) )
(define (composition fns)
  (let ( (f1 (car fns) ) )
    (if (null? (cdr fns) ) f1 
        (let ( (fr (composition (cdr fns) ) ) )
          (lambda (x) (f1 (fr x) ) ) ) )
  )
)

(define f (composition (list (lambda (x) (+ x 1)) (lambda (x) (* x 2)))))

;; Test run
(f 3)

;;;;;;;;;;;;;;;;;;;;;;;;; That all, thanks for reviewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;