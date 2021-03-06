# Visual-data-Ryan-Cauble-and-Cody-Mulkern


# FP7-webpage Visual Data

##Authors
Ryan Cauble

Cody Mulkern

##Overview
Take in small or large amounts of data from an outside file. Store this data into a database for organization and easy access to desired sub parts of that data. Perform Mathmatical operations on that data and display it visually in a graph.  

##Screenshot
```scheme
> (vs ''Bob_Autos 2015 ''Jil_Autos 2014)
```
![alt](https://raw.githubusercontent.com/oplS16projects/Visual-data-Ryan-Cauble-and-Cody-Mulkern/master/Bob_Autos2015%20VS%20Jil_Autos2014.png)


##Concepts Demonstrated
Identify the OPL concepts demonstrated in your project. Be brief. A simple list and example is sufficient. 
* **Data abstraction** is used to provide access to the data in the database.
* **Use of Built in Racket procedures** regex,stddev,mean
* **Racket Libraries** Plot2d used for discrete histograms
* **Racket structures** we had to learn racket vectors to be able to work with the graphs.


##External Technology and Libraries


(require math/statistics) was used to perform computation on the data. 

(require plot) was used to display the results we wanted visually in a graph.

Much of the technology needed is included in the base package of racket so most was not needed to be installed as it could be used without a require.


##Favorite Scheme Expressions
####Ryan
My favorite procedure was one I wrote to add up all numbers in all the months for a giving year. This procedure will do this for every record in the database. This is cool because the actual code to accomplish this is so small utilizing a foldl (functional composition).
```scheme
(define (Twelve-Month-Sum2 rec)
 (foldl (lambda (elem v) 
           (+ v elem)) 
         0 
         (list-tail rec 2)
         )
)  
```
####Cody 
This was my favorite expression because of how much I had to learn and research into to get it working. I had to learn how to make vectors and put them into lists to make the data work with the plot2d discrete-histograms. Also Had to use regular expressions to go through the lists to pull out names to use for labels on the graphs themselves. It is a long procedure but it does a lot of work and most of it is just the options for the graph itself.
```scheme
(define (vs first-name first-year second-name second-year)
  ;;These two search for the names and return the records that are to be graphed
  (define record1 (dealer-year-sales2 first-name first-year carDB))
  (define record2 (dealer-year-sales2 second-name second-year carDB))

  ;These take the names searched for and manipulates them to look nice in the Labels of the graph
  (define first-name-label (regexp-replace* #rx"([()])" (~a (list-tail (first record1) 1)) ""))
  (define second-name-label (regexp-replace* #rx"([()])" (~a (list-tail (first record2) 1)) ""))

  (plot (list (discrete-histogram
               ;;'(#(January (get-January-value2 rec1)) #(Feburary (get-February-value2 rec1)) #(March (get-March-value2 rec1)) #(April (get-April-value2 rec1)) #(May (get-May-value2 rec1)) #(June (get-June-value2 rec1))
               ;;  #(July (get-July-value2 rec1)) #(August (get-August-value2 rec1)) #(September (get-September-value2 rec1)) #(October (get-October-value2 rec1)) #(November (get-November-value2 rec1)) #(December (get-December-value2 rec1)))
               (make-vector record1)
               #:skip 2.5
               #:x-min 0
               #:y-max 1500
               #:invert? #f
               #:label (string-append first-name-label (string-append " " (number->string first-year)))
               )
              (discrete-histogram
              ;;'(#(January (get-January-value2 rec2)) #(Feburary (get-February-value2 rec2)) #(March (get-March-value2 rec2)) #(April (get-April-value2 rec2)) #(May (get-May-value2 rec2)) #(June (get-June-value2 rec2))
              ;;  #(July (get-July-value2 rec2)) #(August (get-August-value2 rec2)) #(September (get-September-value2 rec2)) #(October (get-October-value2 rec2)) #(November (get-November-value2 rec2)) #(December (get-December-value2 rec2)))
               (make-vector record2)
               #:skip 2.5
               #:x-min 1
               #:y-max 1500
               #:invert? #f
               #:label (string-append second-name-label (string-append " " (number->string second-year)))
               #:color 2
               #:line-color 2
               )
              )
      #:width 1000
      #:x-label "Month"
      #:y-label "Sales"
      ;;Replaced with dynamic names for each graph
      ;#:out-file "totalSoldPlot.png"
      #:out-file (string-append (string-append (string-append first-name-label " VS ") second-name-label) ".png")
      #:out-kind 'png
  )
)
```


#How to Download and Run
To run our project you must just open cp1.rkt and run the racket file. From there you will be presented with the options of what you can do with it.








# FP4-Milestone 1

# Project Title: Visual Data

### Milestone 1
For this first milestone we got our project set up on github.
- We both set up git on our computers and started our project.
- Our goals for the first milestone are below
- - code that accomplishes pulling in data from an outside file.
- - code that accomplishes organizing that data into a database.
- Cody got the code bring in data from a file
```racket
(define retrieveData3 (list (file->list "testData.txt")))
```
-Having this Ryan was able to set up the database and start writting the accessors to access the data inside the db. Procedures were
written to do things like grab all the cars sold in the month of may from every dealership. Additional similar procedures will be added as we determine what else is needed. 
```racket
(insert-record-list retrieveData3)
```
- - This will create a record inside the db which will looking something like this
![alt](https://raw.githubusercontent.com/oplS16projects/Visual-data-Ryan-Cauble-and-Cody-Mulkern/master/dbTest.PNG)

- The next problem we had was trying to add tons of data at once using a large file. In Racket if you read data from a file into a list it will create one giant list and we needed to split it up by each records data. Cody tried using the built in split functions that were built into racket but none were suited to the task we needed it for. He found someones method of using racket's take and drop procedures to split a list at any index which allowed for us to read in a file and receive this:
![alt](https://raw.githubusercontent.com/oplS16projects/Visual-data-Ryan-Cauble-and-Cody-Mulkern/master/listDbTest.PNG)

- Here is the precedure for splitting up the lists:
```racket
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
```

So now we have achieved reading in from the REPL and from files and stored it into a database therfore compeleting out first milestones goals. For the next milestone we plan to actually start using the data and creating ways to view and compare data.


### Problem Statement
When looking at large amounts of data it is sometimes hard to visualize the big picture of whats really going on. 
Lets pretend that you own a car dealership and want to know what months typically have the largest sales. To find out
the answer to this many years of car sales would need to be analysed. This task would be daunting to accomplish without
the help from some clever software. This is interesting because the concept can be applied to many real life situations
where data needs to analysed and viewed graphically to be understood.  

### Problem Analysis
To accomplish this project many concepts from class will be used together to organize, calculate, and display our data.
- A database will be used to store and organize the data that will be used. 
- Mathmatical procedures will be writting to perform the statistcal computation. 
- The plot library will be used to display the data stored in the database. 
- Other methods will be written to import data from an outside file that will be used to fill database. 
- We will be using a combination of methods from in class to accomplish all of this. 

### Data set or other source materials
The data we use will come from a file like a excel sheet we create. This file will simulate the data that could be received 
from other sources like the internet. For building and testing purposes we need the data to be fixed and predictable so that is why 
we decided to create our own data set.

The data will be implemented into a database we create for organization.  

To get an idea of the type of data we should build. We will perform research on car sales to see what kind of information 
is important to consider. 

### Deliverable and Demonstration


At the live demo we will be able to do the following: 
- Input data from an outside file.  
- Show that the data is neatly contained within our database.
- Use the data to generate a detailed 2D/3D visual representation. 
- Display the results of some statistical anaysis visually. 
- It will be interactive.

### Evaluation of Results

To verify if our results are correct we could compare the output to known working statistics applications.
For the visual part, well if we see a graph then chances are that it worked to at least some degree. 


## Architecture Diagram

![VDAD](https://raw.githubusercontent.com/oplS16projects/Visual-data-Ryan-Cauble-and-Cody-Mulkern/master/VDAD.jpg)

It all starts with data. In the upper left corner of the diagram you can see the blocks for (Big Data) and (User Entered Data). Big data is meant to represent any large amount of data that could be found on the interent or from various other sources. The problem with big data is that it takes to long to process manually, so companies need programs to automate this process. This is what our company Visual Data aims to do. Then of course we do not limit our program to huge corporations. User Entered Data represents the ability to enter small amounts of data as well.

To start the process we use our extraction code to disiminate the data into a organized and workable state. This workable state will basically be the data represented into lists. 

These lists will then be used by our database procedures to organize the data. This data will remain in the database till it is ready to be worked on. 

Math will then be performed in procedures we create to obtain useful statistical information. The exact type of math procedures we create will vary depending on the kind of information we want to obtain.

Finally in the last two blocks we will implement various 2D and 3D graphical procedures. These graphing procedures from the (plot) racket library will use the data we worked on in our database. When these procedures finish a visual representation of the data will be displayed for the user.

## Work Plan and Schedule

This project will be accomplished is steps. The first things that will be worked on is the database and extracting
data from a outside file. Once the data is organized into a database we will work on finding ways to display that data
graphically through the plot library. Then we will work on different relevant statistical analysis functions to discover 
cool things about the data. Once the math is done we will look at ways to also display that data. 

### First Milestone (04-15)
What exactly will be turned in on this day?

- code that accomplishes pulling in data from an outside file.
- code that accomplishes organizing that data into a database.

### Second Milestone (04-21)
What exactly will be turned in on this day? 

- code that accomplishes mathmatical computation of data.
- code that accomplishes displaying results graphically.

### Final Presentation (last week of semester)
Any time that is left will be spent on optimizing and looking into adding extra functionality. 


## Group Responsibilities

### Ryan Cauble
will write the code that creates the database and the code that generates the results visually.

### Cody Mulkern
To extract the data from an outside file and manipulate it in a useful way. This will be done using the built in racket file input/output streams. From there the the data will need to be put into a database of some sort to be used later for computation and graphing.





