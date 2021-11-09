DELIMITER $

CREATE FUNCTION `judge_big` (num INT) RETURNS VARCHAR (10) 
BEGIN
  DECLARE res VARCHAR (10) ;
  
  IF num < 1000 
  THEN SET res = '小于一千' ;
  ELSEIF num < 2000 
  THEN SET res = '小于两千' ;
  ELSEIF num < 3000 
  THEN SET res = '小于三千' ;
  ELSEIF num < 4000 
  THEN SET res = '小于四千' ;
  ELSE SET res = '太大啦' ;
  END IF ;
  
  RETURN res ;
END $

DELIMITER ;

SELECT judge_big(3400);