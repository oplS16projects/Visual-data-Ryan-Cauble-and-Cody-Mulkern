#lang racket

(require plot)

(plot (list (discrete-histogram
               '(#(Eggs 1.5) #(Bacon 2.5) #(Pancakes 3.5))
               #:skip 2.5 #:x-min 0
               #:label "AMD")
              (discrete-histogram
               '(#(Eggs 1.4) #(Bacon 2.3) #(Pancakes 3.1))
               #:skip 2.5 #:x-min 1
               #:label "Intel" #:color 2 #:line-color 2))
        #:x-label "Breakfast Food" #:y-label "Cooking Time (minutes)"
        #:title "Cooking Times For Breakfast Food, Per Processor"
        ;#:out-file "testPlot.png"	 
 	;#:out-kind 'png
)

(plot (list (discrete-histogram
               '(#(January 150) #(February 250) #(March 350) #(April 150) #(May 250) #(June 350)
                 #(July 150) #(August 250) #(September 350) #(October 150) #(November 250) #(December 350))
               #:skip 2.5
               #:x-min 0
               #:y-max 500
               #:invert? #t
               #:label "Online Sales")
              (discrete-histogram
               '(#(January 140) #(February 230) #(March 310) #(April 170) #(May 220) #(June 250)
                 #(July 170) #(August 350) #(September 150) #(October 350) #(November 280) #(December 150))
               #:skip 2.5
               #:x-min 1
               #:y-max 500
               #:invert? #t
               #:label "Normal Sales" #:color 2 #:line-color 2))
      #:y-label "Month"
      #:x-label "Sales"
      #:out-file "totalSoldPlot.png"	 
      #:out-kind 'png
)

(plot (list (discrete-histogram
               '(#(January 150) #(February 250) #(March 350) #(April 150) #(May 250) #(June 350)
                 #(July 150) #(August 250) #(September 350) #(October 150) #(November 250) #(December 350))
               #:skip 2.5
               #:x-min 0
               #:y-max 500
               #:invert? #t
               #:label "Car Sales")
              (discrete-histogram
               '(#(January 140) #(February 230) #(March 310) #(April 170) #(May 220) #(June 250)
                 #(July 170) #(August 350) #(September 150) #(October 350) #(November 280) #(December 150))
               #:skip 2.5
               #:x-min 1
               #:y-max 500
               #:invert? #t
               #:label "Truck Sales" #:color 1 #:line-color 1))
      #:y-label "Month"
      #:x-label "Sales"
      #:out-file "carTruckSoldPlot.png"	 
      #:out-kind 'png
)
