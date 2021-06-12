#Procedures
DELIMITER //

DROP PROCEDURE IF EXISTS cardNum//
CREATE PROCEDURE cardNum(paramstr VARCHAR(45))
BEGIN
    DECLARE counter int;
    DECLARE totalAmount INT DEFAULT (select max(card.idCard) from card);
    SET counter = 1;
    if (totalAmount is null)
	then
		set totalAmount = 1;
    else
		set totalAmount = totalAmount + 1;
    end if;
    WHILE counter <= 13 DO
		if (counter >=10)
        then
			INSERT INTO card(idCard,cardPower,CardType) VALUES (totalAmount,10,paramstr);
        else
			INSERT INTO card(idCard,cardPower,CardType) VALUES (totalAmount,counter,paramstr);
        end if;
        SET counter = counter + 1;
        SET totalAmount = totalAmount+1;
    END WHILE;
END //


DROP PROCEDURE IF EXISTS generateRoullateBets//
CREATE PROCEDURE generateRoullateBets()
BEGIN
	DECLARE counter int DEFAULT 0;
    DECLARE isRed boolean DEFAULT false;
    
    DELETE from roulattebet where (idRoulatteNum>=0);
	DELETE from roulattebet where (idRoulatteNum<0);

	DELETE from roullate_guessing_options where (guessingOption>=0);
	DELETE from roullate_guessing_options where (guessingOption<0);
    
    WHILE counter<=37 DO
		INSERT INTO roulattebet(idRoulatteNum,is_red) VALUES (counter,isRed);
        INSERT INTO roullate_guessing_options(guessingOption,name) VALUES (counter,"Percise Guess");
        if (counter%7!=0)
        then
			set isRed = ! isRed;
		end if;
        set counter = counter + 1;
	END WHILE;
    INSERT INTO roullate_guessing_options(guessingOption,name) VALUES (38,"Red Color");
    INSERT INTO roullate_guessing_options(guessingOption,name) VALUES (39,"Black Color");
    INSERT INTO roullate_guessing_options(guessingOption,name) VALUES (40,"Even");
    INSERT INTO roullate_guessing_options(guessingOption,name) VALUES (41,"Odd");
END//

DELIMITER ;

/* customers*/
insert into customers (idCustomer,name,lastVisited) values (123,"Peter Kalman",20171122033217);
insert into customers (idCustomer,name,lastVisited) values (127,"Korel Kashri",20160319053900);
insert into customers (idCustomer,name,lastVisited) values (128,"Sergey Vorfolomeyev",20171122033227);
insert into customers (idCustomer,name,lastVisited) values (38,"Kirill Rostopchin",20171122033237);
insert into customers (idCustomer,name,lastVisited) values (101,"Big B",20170123223259);
insert into customers (idCustomer,name,lastVisited) values (50,"Mark Green",20160505001018);
insert into customers (idCustomer,name,lastVisited) values (55,"Dave Blue",20160505001028);

/* workers */
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (1,1,2,300,30);
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (3,1,5,800,35);
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (2,2,10,1643,45);
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (10,2,1,90,29);
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (4,1,1,463,22);
insert into workers (idWorker,workerType,yearsOfExperience,hoursWorked,perHourPay) values (19,3,3,710,18);

/* customer's games */
insert into customers_games (idGame) values (1);
insert into customers_games (idGame) values (2);
insert into customers_games (idGame) values (3);
insert into customers_games (idGame) values (4);


/* worker in games */
insert into workers_in_game (idGame,idWorker) values (1,1);
insert into workers_in_game (idGame,idWorker) values (1,2);
insert into workers_in_game (idGame,idWorker) values (2,19);
insert into workers_in_game (idGame,idWorker) values (1,19);
insert into workers_in_game (idGame,idWorker) values (2,4);
insert into workers_in_game (idGame,idWorker) values (2,10);
insert into workers_in_game (idGame,idWorker) values (3,4);
insert into workers_in_game (idGame,idWorker) values (3,2);
insert into workers_in_game (idGame,idWorker) values (4,2);
insert into workers_in_game (idGame,idWorker) values (4,19);

/* customer in game */
insert into customer_in_game (idCustomer,idGame) values (123,1);
insert into customer_in_game (idCustomer,idGame) values (128,1);
insert into customer_in_game (idCustomer,idGame) values (38,1);
insert into customer_in_game (idCustomer,idGame) values (50,2);
insert into customer_in_game (idCustomer,idGame) values (55,2);
insert into customer_in_game (idCustomer,idGame) values (123,3);
insert into customer_in_game (idCustomer,idGame) values (50,4);

/* Blackjack Turn Procedure */
insert into blackjack_turn (idBlackjack_turnProcedure,procedureName) values (1,"Receive Card");
insert into blackjack_turn(idBlackjack_turnProcedure,procedureName) values (2,"Stand");
insert into blackjack_turn (idBlackjack_turnProcedure,procedureName) values (3,"Double Down");
insert into blackjack_turn (idBlackjack_turnProcedure,procedureName) values (4,"Split");



/* Card */
call cardNum("Hearts");
call cardNum("Diamonds");
call cardNum("Clubs");
call cardNum("Spades");

/* Blackjack */
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,0,false,2000,1,5);#5 Hearts [5]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,1,false,0,1,40);#1 Spades [6/16]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,2,true,0,1,26);#13 Diamonds[10]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,3,true,0,1,49);#10 Spades[20]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,4,false,0,1,30);#4 Clubs[10/20]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,5,false,2000,3,49);#10 Spades[20]
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (3,6,false,0,1,40);#1 Spade[21]Winner

insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (4,0,false,500,1,5);#5 Hearts
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (4,1,false,0,1,24);#11 Diamonds
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (4,2,true,0,1,26);#13 Diamonds
insert into blackjack(idGame,turn,casinos_Hand,moneyPlaced,turnProcedure,Card) values (4,3,true,0,1,48);#10 Spades

/* Roulatee Bets And Guessing Options*/
call generateRoullateBets();

/* Roullate */
insert into roulatte(idGame,moneyPlaced,ballGuess,ballResult) VALUES (1,200,38,25);/*Game:#1,200 $ bet ,Guess:Red,Result:25IsRed */
insert into roulatte(idGame,moneyPlaced,ballGuess,ballResult) VALUES (2,1000,11,36);/*Game:#2,1000 $ bet,Guess:PerciseGuess,Result,36IsBlack*/


/* Roullate */
select * from roulatte;
DELETE from roulatte where (idGame>=0);
DELETE from roulatte where (idGame<0);
/* RoullateBet */
select * from roulattebet;
/*Roullate Guessing Options*/
select * from roullate_guessing_options;

/* Blackjack */
select * from blackjack;
DELETE from blackjack where (idGame>=0);
DELETE from blackjack where (idGame<0);
/* Blackjack Turn Procedure */
select * from blackjack_turn;
DELETE from blackjack_turn where (idBlackjack_turnProcedure>=0);
DELETE from blackjack_turn where (idBlackjack_turnProcedure<0);

/* Card */
select * from card;
DELETE from card where (idCard>=0);
DELETE from card where (idCard<0);

/* customer in game */
select * from customer_in_game;
DELETE from customer_in_game where (idGame>=0);
DELETE from customer_in_game where (idGame<0);
/* workers in games */
select * from workers_in_game;
DELETE from workers_in_game where (idGame>=0);
DELETE from workers_in_game where (idGame<0);
/* customer's games */
select * from customers_games;
DELETE from customers_games where (idGame>=0);
DELETE from customers_games where (idGame<0);
/* workers */
select * from workers;
DELETE from workers where (idWorker>=0);
DELETE from workers where (idWorker<0);

/* customers*/
select * from customers;
DELETE from customers where (idCustomer>=0);
DELETE from customers where (idCustomer<0);

