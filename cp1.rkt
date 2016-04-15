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

     (set! carDB (cons (list dealership year
                       one two three four five six seven eight nine ten eleven tweleve 
                             sold-in-year
                             ) carDB))
     

          (set! carDB (append carDB (list (list dealership year
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
;'((
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

;; (define retrieveData6 (list (file->list "testData.txt")))  ;; creates list of list from the data.
;; this code as it is will work for data in this form:

;'Bob_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200

;; What I need is for it to work for the following type:

;'Bob_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Jil_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Bic_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200
;'Lee_Autos 2015 100 200 300 400 500 600 700 800 900 1000 1100 1200



;;
;; http://stackoverflow.com/questions/8725832/how-to-split-list-into-evenly-sized-chunks-in-racket-scheme
;; USERNAME: yari
;;
;; Takes the one large list that it created from importing from the file and splits it into smaller
;; lists to enter each dealership into the dB
;;
;;
(define (split-by lst n)
   (if (not (empty? lst))
       (cons (take lst n) (split-by (drop lst n) n))
       '() ))


(define (makeDealerList fileName)
  (split-by (file->list fileName) 14)
)

(define retrieveData7 (makeDealerList "testData2.txt") )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; adding aditional functionality to the database.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following procedures will extract all the data from a current month for all
;; the dealerships.... Or for whatever type of data we are analyzing.

;;(all-January carDB)
;;'(101 102 103 104)
(define (all-January lst)
  (if (null? lst)
      '()
      (cons (get-January-value2 (car lst)) (all-January (cdr lst)))
  )
)

(define (all-February lst)
  (if (null? lst)
      '()
      (cons (get-February-value2 (car lst)) (all-February (cdr lst)))
  )
)

(define (all-March lst)
  (if (null? lst)
      '()
      (cons (get-March-value2 (car lst)) (all-March (cdr lst)))
  )
)

(define (all-April lst)
  (if (null? lst)
      '()
      (cons (get-April-value2 (car lst)) (all-April (cdr lst)))
  )
)

(define (all-May lst)
  (if (null? lst)
      '()
      (cons (get-May-value2 (car lst)) (all-May (cdr lst)))
  )
)

(define (all-June lst)
  (if (null? lst)
      '()
      (cons (get-June-value2 (car lst)) (all-June (cdr lst)))
  )
)

(define (all-July lst)
  (if (null? lst)
      '()
      (cons (get-July-value2 (car lst)) (all-July (cdr lst)))
  )
)

(define (all-August lst)
  (if (null? lst)
      '()
      (cons (get-August-value2 (car lst)) (all-August (cdr lst)))
  )
)

(define (all-September lst)
  (if (null? lst)
      '()
      (cons (get-September-value2 (car lst)) (all-September (cdr lst)))
  )
)

(define (all-October lst)
  (if (null? lst)
      '()
      (cons (get-October-value2 (car lst)) (all-October (cdr lst)))
  )
)

(define (all-November lst)
  (if (null? lst)
      '()
      (cons (get-November-value2 (car lst)) (all-November (cdr lst)))
  )
)

;;> (all-December carDB)
;;'(1201 1202 1203 1204)
(define (all-December lst)
  (if (null? lst)
      '()
      (cons (get-December-value2 (car lst)) (all-December (cdr lst)))
  )
)
;; all year totals
;; (all-Twelve-Month-Sum2  carDB)
;; '(15624 15648 15672 15696)
(define (all-Twelve-Month-Sum2  lst)
  (if (null? lst)
      '()
      (cons (Twelve-Month-Sum2 (car lst)) (all-Twelve-Month-Sum2 (cdr lst)))
  )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; insert into database
(insert-record-list retrieveData7)



