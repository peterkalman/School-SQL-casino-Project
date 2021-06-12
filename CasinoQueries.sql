#Query 8: receive all of the clients that the time to pay has passed

SELECT *
FROM customers
WHERE customers.limitDate<NOW();

UPDATE customers_games
SET customers_games.suspicious=TRUE
WHERE customers_games.idGame=2;
#For Demonstration Puposes run Game 2 as suspicious than run the Quary on who bannings
#and then run this thing above.


#Query 4: receive the most not profitable client  (the one that has the lowest spendings)

SELECT *
FROM customers 
ORDER BY spendings asc
LIMIT 1;

#Query 7: banning all players that played in suspicious match 
#Bonus 7: update their debt and set their limitDate


UPDATE Customers,
	(
    SELECT customers.idCustomer, customers.lastVisited,customers_games.suspicious,customers_games.idGame
	FROM ( (customer_in_game INNER JOIN customers_games ON customer_in_game.idGame=customers_games.idGame)
		INNER JOIN customers 
	ON customers.idCustomer=customer_in_game.idCustomer)
    WHERE customers_games.suspicious=TRUE
	) tab1,
	(
	(SELECT RLT.moneyPlaced ,CIGT.idCustomer as customerId,CIGT.idGame FROM roulatte RLT,customer_in_game CIGT ,
		customers_games CGT WHERE CIGT.idGame=CGT.idGame AND RLT.idGame=CGT.idGame)
	UNION
	(SELECT moneyPlaced ,CIGT.idCustomer as customerId, CIGT.idGame FROM
		(SELECT BJ.idGame as gameNum,sum(BJ.moneyPlaced) as moneyPlaced  FROM blackjack BJ GROUP BY BJ.idGame)
	gamesMoney,customer_in_game CIGT ,customers_games CGT WHERE  CIGT.idGame=CGT.idGame AND gamesMoney.gameNum=CGT.idGame)
	)
	tab2
SET Customers.limitDate=DATE_ADD(Customers.lastVisited,INTERVAL 14 DAY),
	Customers.banned=TRUE,
    Customers.debt =tab2.moneyPlaced
WHERE tab1.idCustomer=tab2.customerId AND tab1.idGame = tab2.idGame AND customers.idCustomer=tab1.idCustomer;


#Query 6: give money to all workers in X game 

UPDATE workers
SET perHourPay=perHourPay*0.9
WHERE idWorker IN (SELECT workers_in_game.idWorker
				FROM workers_in_game
                WHERE idGame=3);
                    
#Query 2: Select all customers that won in roullate games
SELECT C.idCustomer as CustomerID ,C.name as Customer_That_Won ,CG.idGame
FROM 
	(SELECT RLT.idGame as gameNum
	FROM roulatte RLT,roullate_guessing_options RGO, roulattebet RBF
	WHERE RLT.ballGuess=RGO.guessingOption AND RBF.idRoulatteNum=RLT.ballResult AND 
	((RGO.name="Red Color" AND RBF.is_red=TRUE) OR
	(RGO.name="Black Color" AND RBF.is_red=FALSE)OR
	(RGO.name="Even" AND RBF.idRoulatteNum%2=0)OR
	(RGO.name="Odd" AND RBF.idRoulatteNum%2=1)OR
	(RLT.ballGuess=RBF.idRoulatteNum))
) RLTWIN, customers_games CG ,customer_in_game CIG , customers C
WHERE CG.idGame = RLTWIN.gameNum AND CIG.idGame=CG.idGame AND CIG.idCustomer=C.idCustomer;

UPDATE customers_games
SET customers_games.customerWon=TRUE
WHERE customers_games.idGame=1;
#Query 1: Select all customers that won in blackjack games

SELECT C.idCustomer as CustomerID ,C.name as Customer_That_Won,CG.idGame
FROM 
(
	SELECT *
	FROM(
		SELECT *
		FROM (
			SELECT BJ.idGame as gameNum,SUM(C.CardPower) AS TotalSum,BJ.casinos_Hand as isCasinoHand
			FROM blackjack BJ, card C
			WHERE C.idCard=BJ.Card
			GROUP BY BJ.idGame ,BJ.casinos_Hand) allSum # all of the sums of both customers and casino
		WHERE allSum.TotalSum<=21 # only sums that do not exceed 21
		ORDER BY allSum.TotalSum Desc # Sort all sums so the bigger results will appear first
	) fin
	GROUP BY fin.gameNum# Select only 1 winner from every game
	having fin.isCasinoHand=FALSE # select all winners that are customers
)BJWIN,customers_games CG ,customer_in_game CIG , customers C
WHERE CG.idGame = BJWIN.gameNum AND CIG.idGame=CG.idGame AND CIG.idCustomer=C.idCustomer;

UPDATE customers_games
SET customers_games.customerWon=TRUE
WHERE customers_games.idGame=3;
#Query 5: Select all of the suspicious customers in all blackjack games
SELECT C.idCustomer as CustomerID ,C.name as Customer_That_Cheated
FROM(
	SELECT *
	FROM(
		SELECT count(*) as counter,BJ.idGame as gameNum,BJ.Card
		FROM blackjack BJ
		GROUP BY BJ.idGame ,BJ.Card
		ORDER BY counter DESC 
	) SUSBJGames
	GROUP BY SUSBJGames.gameNum
	HAVING SUSBJGames.counter>=2
) BJCHEAT,customers_games CG ,customer_in_game CIG , customers C
WHERE CG.idGame = BJCHEAT.gameNum AND CIG.idGame=CG.idGame AND CIG.idCustomer=C.idCustomer;

UPDATE customers_games
SET customers_games.suspicious=TRUE
WHERE customers_games.idGame=3;

#Query 3: Update the spendings of all clients

UPDATE 
	(SELECT C.idCustomer as customID,sum(allGames.totalSum) as finalTotalSum
	FROM 
		(	SELECT allGames.gameNum ,if(CG.customerWon=TRUE,allGames.totalSum*-1,allGames.totalSum) as totalSum, CG.customerWon
		FROM
			( (SELECT BJ.idGame as gameNum ,sum(BJ.moneyPlaced) as totalSum 
			FROM blackjack BJ
			GROUP BY BJ.idGame)
		UNION
			(SELECT RLT.idGame as gameNum,RLT.moneyPlaced as totalSum
			FROM roulatte RLT) ) allGames INNER JOIN customers_games CG ON CG.idGame=allGames.gameNum
		)allGames ,customer_in_game CIG , customers C
		WHERE CIG.idGame=allGames.gameNum AND CIG.idCustomer=C.idCustomer
	GROUP BY C.idCustomer) allFinalSums
,customers
SET customers.spendings=allFinalSums.finalTotalSum
WHERE allFinalSums.customID = customers.idCustomer;
