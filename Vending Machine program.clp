; template to create items
(deftemplate items
    (slot itemName)
    (slot itemPrice)
)

; Facts used when instantiatng 
(deffacts itemDetails
    (items (itemName chocolate) (itemPrice 15.00))
    (items (itemName cola) (itemPrice 8.50))
    (items (itemName orange) (itemPrice 10.00))
    (items (itemName sweets) (itemPrice 12.50))
)

; Function to retrieve amount of change if any
(deffunction paymentChange (?amountChange)
    (if (< ?amountChange 0) then
        (printout t "Dont forget your change: R " (* ?amountChange -1) "0" crlf ; used -1 because it retrieves a negative if there is change when we want positive
                    "Come back anytime for more goodies" crlf)
    else
        (printout t "You do not have any change, have a nice day" crlf)
    )
)

; Function to calcuate and add a payment to be regstered
(deffunction addPayment (?calcAmount)
    (while (> ?calcAmount 0)    
        (bind ?inputCoin (read)
    )
    (if(eq ?inputCoin R5) then
        (bind ?calcAmount (- ?calcAmount 5.00)) ; Probably hould have used a facts for this
    )
    (if(eq ?inputCoin R2) then
        (bind ?calcAmount (- ?calcAmount 2.00))
    )
    (if(eq ?inputCoin R1) then
        (bind ?calcAmount (- ?calcAmount 1.00))
    )
    (if(eq ?inputCoin c50) then
        (bind ?calcAmount (- ?calcAmount 0.50))
    )
    (if(eq ?inputCoin c20) then
        (bind ?calcAmount (- ?calcAmount 0.20))
    )
    (if(eq ?inputCoin c10) then
        (bind ?calcAmount (- ?calcAmount 0.10))
    )
    (if(> ?calcAmount 0) then
        (printout t "You have a balance of R " ?calcAmount "0" crlf))
    )
    (paymentChange ?calcAmount)
)

; Function to instantiate an item to be processed
(deffunction addItem ()
    (bind ?choice (read))
    (if (eq ?choice ch) then
        (bind ?priceChoice 15.00)
    )
    (if (eq ?choice co) then
        (bind ?priceChoice 8.50)
    )
    (if (eq ?choice or) then
        (bind ?priceChoice 10.00)
    )
    (if (eq ?choice sw) then
        (bind ?priceChoice 12.50)
    )
    (printout t "Your total amount to be paid is " ?priceChoice "0" crlf)
    (printout t "You may enter the following amounts: " crlf 
                " R5, R2, R1, c50, c20, c10" crlf
                "Enter amount for input : " )
    (addPayment ?priceChoice)
)

; Rule used to as the user what item they would like
(defrule askItems
=>
    (printout t "Choose one of the following : " crlf
                "Chocolate : ch" crlf
                "Cola : co" crlf
                "Orange : or" crlf
                "Sweets : sw" crlf)
    (printout t "Your choice: ")
    (addItem)
)
