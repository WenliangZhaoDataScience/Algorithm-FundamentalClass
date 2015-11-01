
################################################################
# A multi-thread merge sort package written in Ada             #
#                                                              #
# Author: Wenliang Zhao, 2015-10-01                            #
# MS in CS at Courant Institute of Mathematical Sciences, NYU  #                                                             
################################################################

*** Proof of concurrency ***
1) Divide-and-Conquer step is concurrent 
   left and right half are working at the same time
   As well as further small parts. Whenever there is no dependence, the program works concurrently
   To show this we obtain screen shots for middle indice at each merge step. With multiple run, we see these indice are in different order
   Proof: see image/Middle_point_concurrent_merge.jpg

2) Sum and Print tasks work concurrently
   Proof: see image/Sum_print_concurrent.jpg
   From which we see the output of Sum sometimes occur on screen before the print step, sometimes is after.

   
