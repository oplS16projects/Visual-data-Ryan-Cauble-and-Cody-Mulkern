#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define nil '())

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define retrieveData2 (file->list "testData.txt"))  ;; creates list from the data.

(define retrieveData3 (list (file->list "testData.txt")))  ;; creates list of list from the data.

;;; test can be deleted.......
;(car retrieveData2)
;
;(third retrieveData2)
;(fourth retrieveData2)
;
;(define addthem
;  (+ (third retrieveData2)(fourth retrieveData2) )
;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;Constructor
(define carDB '() )

;insert one record into the database. 
;(define (insert-record dealership year month sold-in-year)
(define (insert-record dealership year
         one two three four five six seven eight nine ten eleven tweleve   ;; represents the months.
                       sold-in-year
                       )
  
  (if (null? carDB)
;     (set! carDB (cons (list insert-record dealership year month  sold-in-year) carDB))
     (set! carDB (cons (list insert-record dealership year
                       one two three four five six seven eight nine ten eleven tweleve 
                             sold-in-year
                             ) carDB))
     
;     (set! carDB (append carDB (list (list insert-record dealership year month  sold-in-year))))
          (set! carDB (append carDB (list (list insert-record dealership year
                       one two three four five six seven eight nine ten eleven tweleve 
                                                sold-in-year
                                                ))))
  )
)

;insert more than one record into database
;Input is a list of records.
;; test with            >>>             (insert-record-list retrieveData3)
(define (insert-record-list lst)        
  (if (null? lst)
      (set! carDB carDB)
      (insert-record (get-dealership (car lst))
                     (get-year (car lst))                             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                     (get-January-value2 (car lst))  
                     (get-February-value2 (car lst))   
                     (get-March-value2 (car lst))  
                     (get-April-value2 (car lst))  
                     (get-May-value2 (car lst))  
                     (get-June-value2 (car lst))  
                     (get-July-value2 (car lst)) 
                     (get-August-value2 (car lst)) 
                     (get-September-value2 (car lst))  
                     (get-October-value2 (car lst))  
                     (get-November-value2 (car lst))  
                     (get-December-value2 (car lst))  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                     (Twelve-Month-Sum2 (car lst))
                     ;(get-units-sold (car lst)) ;; will need to add them up first then get.
                     ))
  
  (if (null? (cdr lst))
      (set! carDB carDB)
      (insert-record-list (cdr lst)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;>>>>>>>>>>>>>>>>  Accessors <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;(should return specified attribute value for the given record)
(define (get-dealership rec)  ;; dealership name needs to be first in data set.
  (first rec))      

(define (get-year rec)       ;; year needs to be second in data set. 
  (second rec))

;;;; Following the dealership name and year will come 12 months.
;;;; These months can be represented in string or number form.
;;;; example (01 02 03 ..... 11 12) or (Jan Feb ... Dec). 

;; So maybe a accessor to grab all 12 months..
;; and 12 more to grab a specific month if needed?

;;;; my input list is....
; retrieveData2
;(define get-January-value 
;  (list-ref retrieveData2 2)
;)  

;(define (get-January-value2 rec)  
;  (list-ref retrieveData2 rec)
;)

(define (get-January-value2 rec)  
  (third rec))

(define (get-February-value2 rec)  
  (fourth rec))

(define (get-March-value2 rec)  
  (fifth rec))

(define (get-April-value2 rec)  
  (sixth rec))

(define (get-May-value2 rec)  
  (seventh rec)) 

(define (get-June-value2 rec)  
  (eighth rec))

(define (get-July-value2 rec)  
  (ninth rec))

(define (get-August-value2 rec)  
  (tenth rec))

(define (get-September-value2 rec)  
;  (eleventh rec)
(cadddr(cddddr(cdddr rec)))
)

(define (get-October-value2 rec)  
;  (twelfth rec)
(cadddr(cddddr(cddddr rec)))
)

(define (get-November-value2 rec)  
;  (thirteenth rec)
(cadddr(cddddr(cddddr(cdr rec))))
)

(define (get-December-value2 rec)  
;  (fourteenth rec)
(cadddr(cddddr(cddddr(cddr rec))))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add all 12 months in the year together.

;(list-tail retrieveData2 2) ;produces a list of just the numbers
                             ;from the 12 months.

;; This works for straight list
;; 'Bob_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;; add's all the numbers in this list together from element 2 till end of list.
(define Twelve-Month-Sum             
 (foldl (lambda (elem v) 
           (+ v elem)) 
         0 
         (list-tail retrieveData2 2)
         )
)  


;; This one works with our insert-record-list
(define (Twelve-Month-Sum2 rec)
 (foldl (lambda (elem v) 
           (+ v elem)) 
         0 
         (list-tail rec 2)
         )
)  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; The above code accomplishes the following:
;> (insert-record-list retrieveData3)
;> carDB
;'((#<procedure:insert-record>
;   'Bob_Autos
;   2015
;   100
;   200
;   300
;   400
;   500
;   600
;   700
;   800
;   900
;   1000
;   1100
;   1200
;   7800))
;> 


;; Cody I need retrieveData3 to work with multiple lines of data in a file.

;; (define retrieveData3 (list (file->list "testData.txt")))  ;; creates list of list from the data.
;; this code as it is will work for data in this form:

;'Bob_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200

;; What I need is for it to work for the following type:

;'Bob_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Jil_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Bic_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Lee_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200






